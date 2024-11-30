import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:railpaytro/common/service/dialog_service.dart';
import 'package:railpaytro/constants/app_config.dart';
import '../../../common/locator/locator.dart';
import '../../../common/service/navigation_service.dart';
import '../../../common/service/toast_service.dart';
import '../../constantes/alert_message.dart';
import '../../network/result.dart';

typedef EntityMapper<Entity, Model> = Model Function(Entity entity);

abstract class _ErrorCode {
  static const message = "message";
  static const errors = "errors";
  static const unauthorized = "unauthorized";
}

abstract class BaseRepository {
  final String _apiEndpoint = AppConfig.baseUrl;

  final ToastService _toastService = locator<ToastService>();

  Future<Dio> get dio => _getDio();

  Future<Dio> _getDio() async {
    final dio = Dio();
    final headers = await _getHeaders();

    dio.options = BaseOptions(
      baseUrl: _apiEndpoint,
      connectTimeout: 500000,
      receiveTimeout: 500000,
      headers: headers,
      followRedirects: true,
    );
    dio.interceptors.add(LogInterceptor(
        responseBody: !kReleaseMode,
        requestBody: !kReleaseMode,
        responseHeader: !kReleaseMode,
        requestHeader: !kReleaseMode,
        error: !kReleaseMode,
        logPrint: (object) {
          if (!kReleaseMode) {
            debugPrint(object.toString());
          }
        },
        request: !kReleaseMode));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 400) {
          try {
            /// show session expired toast
            ///
            _toastService.showLong(error.response?.data["ERROR"]["MESSAGE"] ??
                AlertMessages.SESSION_EXPIRED);
          } catch (e) {
            // return e;
            print("error message : $e");
          }
        }

        return handler.next(error);
      },
    ));

    return dio;
  }

  Future<Dio> get dioConnectionTimeOut => _getDioConnectionTimeOut();

  Future<Dio> _getDioConnectionTimeOut() async {
    final dio = Dio();
    final headers = await _getHeaders();

    dio.options = BaseOptions(
      baseUrl: _apiEndpoint,
      connectTimeout: 500000,
      receiveTimeout: 10000,
      headers: headers,
      followRedirects: true,
    );
    dio.interceptors.add(LogInterceptor(
        responseBody: !kReleaseMode,
        requestBody: !kReleaseMode,
        responseHeader: !kReleaseMode,
        requestHeader: !kReleaseMode,
        error: !kReleaseMode,
        logPrint: (object) {
          if (!kReleaseMode) {
            debugPrint(object.toString());
          }
        },
        request: !kReleaseMode));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 400) {
          try {
            /// show session expired toast
            ///
            _toastService.showLong(error.response?.data["ERROR"]["MESSAGE"] ??
                AlertMessages.SESSION_EXPIRED);
          } catch (e) {
            // return e;
            print("error message : $e");
          }
        }

        return handler.next(error);
      },
    ));

    return dio;
  }

  Future<Map<String, String>> _getHeaders() async {
    return {
      'APIKey': "00112233",
    };
  }

  Future<Result<T>> safeCall<T>(Future<T> call) async {
    try {
      var response = await call;
      print('Base Repository: API successful!');
      return Success(response);
    } catch (exception, stackTrace) {
      print('Base Repository: API failure --> $exception');
      print('Base Repository: API stacktrace --> $stackTrace');
      if (exception is DioError) {
        switch (exception.type) {
          case DioErrorType.connectTimeout:
          case DioErrorType.sendTimeout:
          case DioErrorType.receiveTimeout:
          case DioErrorType.cancel:
            return Error(AlertMessages.TIMEOUT_ERROR_MSG);

          case DioErrorType.other:
            return Error(AlertMessages.OFFLINE_ERROR_MSG);

          case DioErrorType.response:
            return _getError(exception.response);

          default:
            return Error(AlertMessages.GENERIC_ERROR_MSG);
        }
      }
      return Error(AlertMessages.GENERIC_ERROR_MSG);
    }
  }

  Future<Result<T>> _getError<T>(Response? response) async {
    print("response in error case : ${response?.data}");
    if (response?.data != null && response?.data is Map<String, dynamic>) {
      ///To Uppercase added according to responce
      if ((response!.data as Map<String, dynamic>)
          .containsKey(_ErrorCode.message.toUpperCase())) {
        var errorMessage = response.data[_ErrorCode.message] as String;
        return Error(errorMessage);
      }
    }
    return Error(
      AlertMessages.GENERIC_ERROR_MSG,
    );
  }
}

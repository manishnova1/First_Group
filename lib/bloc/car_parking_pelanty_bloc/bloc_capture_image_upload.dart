import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Utils/HelpfullMethods.dart';
import 'package:railpaytro/common/locator/locator.dart';
import 'package:railpaytro/data/repo/car_parking_penalty_repo.dart';
import '../../common/Utils/utils.dart';
import '../../common/router/router.gr.dart';
import '../../common/service/dialog_service.dart';
import '../../common/service/navigation_service.dart';
import '../../common/service/toast_service.dart';
import '../../constants/app_config.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/auth/login_model.dart';
import 'bloc_image_upload.dart';

class RevpCaptureImageUploadEvent {}

class RevpCaptureImageUploadButtonEvent extends RevpCaptureImageUploadEvent {
  List<File> list;
  String caseNum;
  BuildContext context;

  RevpCaptureImageUploadButtonEvent(this.list, this.caseNum, this.context);
}

class OfflineRevpCaptureImageUploadButtonEvent
    extends RevpCaptureImageUploadEvent {
  List<dynamic> list;
  String caseNum;

  OfflineRevpCaptureImageUploadButtonEvent(this.list, this.caseNum);
}

//State --------------------------
class RevpCaptureImageUploadState {}

class RevpCaptureImageUploadInitialState extends RevpCaptureImageUploadState {}

class RevpCaptureImageUploadLoadingState extends RevpCaptureImageUploadState {}

class RevpCaptureImageUploadSucessState extends RevpCaptureImageUploadState {
  dynamic data;

  RevpCaptureImageUploadSucessState(this.data);
}

class RevpCaptureImageProgressPercentState extends RevpCaptureImageUploadState {
  String percentage;

  RevpCaptureImageProgressPercentState(this.percentage);
}

class RevpCaptureImageUploadErrorState extends RevpCaptureImageUploadState {
  String error;

  RevpCaptureImageUploadErrorState(this.error);
}

class RevpCaptureImageUploadBloc
    extends Bloc<RevpCaptureImageUploadEvent, RevpCaptureImageUploadState> {
  CarParkingPenaltyRepo carParkingPenaltyRepo;

  RevpCaptureImageUploadBloc(this.carParkingPenaltyRepo)
      : super(RevpCaptureImageUploadInitialState());

  @override
  Stream<RevpCaptureImageUploadState> mapEventToState(
      RevpCaptureImageUploadEvent event) async* {
    LoginModel user = await SqliteDB.instance.getLoginModelData();
    var id = await getId();
    try {
      // for search button -----
      if (event is RevpCaptureImageUploadButtonEvent) {
        final header = {
          "APIKey": AppConfig.apiKey,
        };

        List list = [];
        List filePathList = [];

        for (var e in event.list) {
          String fileName = e.path.split('/').last;
          var v = await MultipartFile.fromFile(e.path, filename: fileName);
          filePathList.add(fileName);
          list.add(v);
        }
        final prem = {
          "action": AppConfig.uploadRevpImage,
          "tocid": AppConfig.tocId,
          "ssessionId": user.STCONFIG!.SAPPSESSIONID!,
          "macAddress": id!,
          "userID": user.STUSER!.ID!,
          "casenum": event.caseNum,
          "caseimagename": filePathList,
          "caseimage": list
        };
        bool checkInternet = await Utils.checkInternet();
        if (checkInternet) {
          yield RevpCaptureImageUploadLoadingState();
          // locator<DialogService>().showLoader(dismissable: false);
          StreamController<String> streamController = StreamController();
          Response? responseData;
          var formData = FormData.fromMap(prem);

          Dio().post(AppConfig.baseUrl + AppConfig.endPoint, data: formData,
              onSendProgress: (received, total) {
            streamController.add(((received / total) * 100).round().toString());
          }, options: Options(headers: header)).then((Response response) {
            responseData = response;
          }).catchError((ex) {
            //streamController.add(ex.toString());
          }).whenComplete(() {
            streamController.close();
          });

          await for (String p in streamController.stream) {
            yield RevpCaptureImageProgressPercentState(p);
          }

          locator<DialogService>().hideLoader();
          var data = responseData!.data;

          if (responseData!.statusCode == 200 && data is Map) {
            yield RevpCaptureImageUploadSucessState(data);
            locator<ToastService>().showLong(data['MESSAGE'].toString());
            locator<NavigationService>().pushAndRemoveUntil(
                UnPaidFareIssueMainRoute(isOfflineApiRequired: false));

            BlocProvider.of<PCNImageSubmitBloc>(event.context)
                .imageMapList
                .clear();
          } else {
            yield RevpCaptureImageUploadErrorState(data['ERROR'][0]);
          }
        } else {
          List<String> path = [];
          await Future.forEach(event.list, (element) {
            File file = element as File;
            path.add(file.path);
          });
          // save request of UFN
          await SqliteDB.instance.insertAPIImagesRequestData(
              event.caseNum, jsonEncode(path), "", "offline", "PCN", "capture");
          locator<ToastService>()
              .showLong("Image successfully saved in database.");
          locator<NavigationService>().pushAndRemoveUntil(
              UnPaidFareIssueMainRoute(isOfflineApiRequired: false));
        }
      } else if (event is OfflineRevpCaptureImageUploadButtonEvent) {
        final header = {
          "APIKey": AppConfig.apiKey,
        };

        List list = [];
        List filePathList = [];

        for (var e in event.list) {
          String fileName = e.split('/').last;
          var v = await MultipartFile.fromFile(e, filename: fileName);
          filePathList.add(fileName);
          list.add(v);
        }
        final prem = {
          "action": AppConfig.uploadRevpImage,
          "tocid": AppConfig.tocId,
          "ssessionId": user.STCONFIG!.SAPPSESSIONID!,
          "macAddress": id!,
          "userID": user.STUSER!.ID!,
          "casenum": event.caseNum,
          "caseimagename": filePathList,
          "caseimage": list
        };
        bool checkInternet = await Utils.checkInternet();
        if (checkInternet) {
          StreamController<String> streamController = StreamController();
          var formData = FormData.fromMap(prem);

          var response = await Dio().post(
              AppConfig.baseUrl + AppConfig.endPoint,
              queryParameters: prem,
              data: formData, onSendProgress: (received, total) {
            streamController.add(((received / total) * 100).round().toString());
          }, options: Options(headers: header, followRedirects: false));

          var data = response.data;

          if (response.statusCode == 200 && data is Map) {
            await SqliteDB.instance
                .deleteSubSectionsImagesData(event.caseNum, "capture");
          } else {}
        }
      }
    } catch (e, stacktrace) {
      debugPrint("$e : $stacktrace");
      yield RevpCaptureImageUploadErrorState("Something Went Wrong");
    }
  }
}

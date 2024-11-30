import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/intelligence_report/intelligence_successful.dart';
import 'package:railpaytro/Ui/Utils/HelpfullMethods.dart';
import 'package:railpaytro/common/Utils/utils.dart';
import 'package:railpaytro/common/locator/locator.dart';

import '../../Ui/Pages/Role_stationsTeam/intelligence_report/intelligence_printsummary.dart';
import '../../common/router/router.gr.dart';
import '../../common/service/dialog_service.dart';
import '../../common/service/navigation_service.dart';
import '../../common/service/toast_service.dart';
import '../../constants/app_config.dart';
import '../../data/constantes/db_constants.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/auth/login_model.dart';
import '../car_parking_pelanty_bloc/bloc_capture_image_upload.dart';
import 'IR_image_submit_bloc.dart';

class IRSubmitEvent {}

class IRSubmitSubmitEvent extends IRSubmitEvent {
  Map<String, dynamic> data;
  String imageCount;
  BuildContext context;
  String caseNum;

  IRSubmitSubmitEvent(
      {required this.data,
      required this.imageCount,
      required this.context,
      required this.caseNum});
}

class IRSubmitInitEvent extends IRSubmitEvent {
  List<File> imageList = [];
  var Data;
  String current;
  BuildContext context;

  IRSubmitInitEvent(this.Data, this.imageList, this.context, this.current);
}

class IRSubmitOffenceEvent extends IRSubmitEvent {}

class IRSubmitState {}

class IRSubmitInitialState extends IRSubmitState {}

class IRSubmitLoadingState extends IRSubmitState {}

class IRSubmitSuccessState extends IRSubmitState {
  String refCaseId;

  IRSubmitSuccessState(this.refCaseId);
}

class IRSubmitErrorState extends IRSubmitState {
  String error;

  IRSubmitErrorState(this.error);
}

class IRSubmitBloc extends Bloc<IRSubmitEvent, IRSubmitState> {
  String caseReferance = '';
  Map<String, dynamic> reportMap = {};

  IRSubmitBloc() : super(IRSubmitInitialState());

  @override
  Stream<IRSubmitState> mapEventToState(IRSubmitEvent event) async* {
    LoginModel user = await SqliteDB.instance.getLoginModelData();
    var id = await getId();
    try {
      // for search button -----
      if (event is IRSubmitSubmitEvent) {
        Map<String, dynamic> mapData = event.data;
        Map<String, dynamic> dumpMap = {
          'action': AppConfig.revpSubmitIRFareNotice,
          'tocid': AppConfig.tocId,
          'macAddress': user.STUSER?.MACADRESS!,
          'toc': '',
          'rid': '',
          'selectedheadcode': '',
          'ssessionId': user.STCONFIG?.SAPPSESSIONID!,
          'userID': user.STUSER?.ID!,
          'caseNum': event.caseNum,
          'occupation': ''
        };

        mapData.addAll(dumpMap);
        reportMap.addAll(mapData);

        submitIRData(reportMap, event.context, true);
      }
      else if (event is IRSubmitInitEvent) {
        var list = await SqliteDB.instance.getReferenceList();
        var caseNum = '';

        for (var e in list) {
          if (e!.ISUSED == 0 &&
              e.ISLOCKED == 1 &&
              e.CASE_REFERENCE_NO!.toLowerCase().contains('xz')) {
            caseNum = e.CASE_REFERENCE_NO ?? '';
            print('Case matched ${list.length}');
            break;
          }
        }
        caseReferance = caseNum;
        SqliteDB.instance.updateCaseRef(caseReferance);
        yield IRSubmitSuccessState(caseReferance);

        if (caseNum.isNotEmpty) {
          Navigator.push(
              event.context,
              MaterialPageRoute(
                  builder: (context) => IntelligenceReportSummaryPrint(
                      event.Data, event.imageList, caseNum, event.current)));
        } else {
          Fluttertoast.showToast(msg: 'CaseRefrence not find ');
          LoginModel user = await SqliteDB.instance.getLoginModelData();
        }
      }
    } catch (e, stacktrace) {
      debugPrint("$e : $stacktrace");
      yield IRSubmitErrorState("Something Went Wrong");
    }
  }
}

Future submitIRData(
    Map<String, dynamic> body, BuildContext context, bool isOnlineMode) async {
  bool checkInternet = await Utils.checkInternet();
  if (checkInternet) {
    if (isOnlineMode) locator<DialogService>().showLoaderwithHide(dismissable: false);
    try {
      final header = {
        "APIKey": AppConfig.apiKey,
      };

      var formData = FormData.fromMap(body);
      final dio = Dio();
      dio.options = BaseOptions(
        baseUrl: AppConfig.baseUrl,
        receiveTimeout: 5000,
        headers: {
          'APIKey': "00112233",
        },
        followRedirects: true,
      );

      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) async {
          if (error.type == DioErrorType.receiveTimeout) {
            locator<DialogService>().hideLoader();
            if (body['caseNum'] != null && isOnlineMode) {
              // save request of MG11
              await SqliteDB.instance.insertAPIRequestData({
                "id": body['caseNum'],
                "body": jsonEncode(body),
                "request_section": "IR",
                "request_sub_section": "main",
              });
              List<Map<String, dynamic>> imageMapSyncList =
                  BlocProvider.of<IRImageSubmitBloc>(context).imageMapList;
              await Future.forEach(imageMapSyncList, (dynamic request) async {
                // save request of MG11
                await SqliteDB.instance.insertAPIImagesRequestData(
                    body['caseNum'],
                    jsonEncode(request["data"]),
                    request["path"],
                    request["type"],
                    "IR",
                    "main");
              });
              locator<ToastService>()
                  .show("Data has been saved successfully into database");
              //update case number :
              await SqliteDB.instance.updateCaseRef(body['caseNum']);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          IntelligenceSuccessfull(body['caseNum'])));
            }
          }
          return handler.next(error);
        },
      ));
      var response = await dio.post(AppConfig.endPoint, data: formData);

      locator<DialogService>().hideLoader();

      if (response.statusCode == 200) {
        if (response.data is Map) {
          Utils.showToast(response.data['MESSAGE'].toString());
          List<Map<String, dynamic>> results =
              await SqliteDB.instance.getImagesAPIRequestData('');
          if (results != null && results.isNotEmpty) {
            List<String> imagePaths = [];
            for (var element in results) {
              String subSection = element[DBConstants.CL_IMAGES_SECTION];
              String range = element[DBConstants.CL_IMAGES_SUB_SECTION];

              if (subSection == 'IR' && range == 'timeout') {
                dynamic data = element[DBConstants.CL_IMAGES_DATA];
                if (data != null) {
                  List<String> paths = List<String>.from(jsonDecode(data));
                  imagePaths.addAll(paths);
                }
              }
            }
            if (imagePaths.isNotEmpty) {
              BlocProvider.of<RevpCaptureImageUploadBloc>(context).add(
                OfflineRevpCaptureImageUploadButtonEvent(
                    imagePaths, body['caseNum']),
              );
            }
          }
          if (isOnlineMode) {
            await SqliteDB.instance.updateCaseRef(body['caseNum']);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        IntelligenceSuccessfull(body['caseNum'] ?? "")));
          } else {
            await SqliteDB.instance.deleteAPIRequestData(
                caseNum: body['caseNum'], subType: "main");
            await SqliteDB.instance.deleteImagesData(body['caseNum']);
          }
        } else
          Utils.showToast(
              "Case couldn't saved, issue reported to further check");
      } else if (response.statusCode == 501) {
        Utils.showToast(response.data.MESSAGE);
      } else {
        var data = response.data;
        Utils.showToast(data['ERROR'][0]);
        // yield RevpTicketImageUploadErrorState(data['ERROR'][0]);
      }
    } catch (e, stacktrace) {
      locator<DialogService>().hideLoader();
      print(e.toString());
      Utils.showToast(
          "Case couldn't saved, issue reported to further check, error");
    }
  } else {
    if (body['caseNum'] != null) {

      await SqliteDB.instance.insertAPIRequestData({
        "id": body['caseNum'],
        "body": jsonEncode(body),
        "request_section": "IR",
        "request_sub_section": "main",
      });
      List<Map<String, dynamic>> imageMapSyncList =
          BlocProvider.of<IRImageSubmitBloc>(context).imageMapList;
      await Future.forEach(imageMapSyncList, (dynamic request) async {
        // save request of MG11
        await SqliteDB.instance.insertAPIImagesRequestData(
            body['caseNum'],
            jsonEncode(request["data"]),
            request["path"],
            request["type"],
            "IR",
            "main");
      });
      locator<ToastService>()
          .show("Data has been saved successfully into database");
      //update case number :
      await SqliteDB.instance.updateCaseRef(body['caseNum']);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => IntelligenceSuccessfull(body['caseNum'])));
    }
  }
}

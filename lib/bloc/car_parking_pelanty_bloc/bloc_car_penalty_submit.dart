import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:railpaytro/Ui/Utils/HelpfullMethods.dart';
import 'package:railpaytro/common/Utils/utils.dart';
import 'package:railpaytro/common/locator/locator.dart';
import 'package:railpaytro/constants/app_config.dart';
import 'package:railpaytro/data/repo/car_parking_penalty_repo.dart';
import '../../common/service/dialog_service.dart';
import '../../common/service/toast_service.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/auth/login_model.dart';
import 'bloc_image_upload.dart';

class PenaltySubmitEvent {}

class PenaltySubmitSubmitEvent extends PenaltySubmitEvent {
  Map<String, dynamic> data;
  String imageCount;
  BuildContext? context;
  String lat;
  String long;

  PenaltySubmitSubmitEvent({
    required this.data,
    required this.imageCount,
    required this.context,
    required this.lat,
    required this.long,
  });
}

class OfflinePenaltySubmitEvent extends PenaltySubmitEvent {
  Map<String, dynamic> data;

  OfflinePenaltySubmitEvent({
    required this.data,
  });
}

class SetLatLongEvent extends PenaltySubmitEvent {
  String? lat;
  String? long;

  SetLatLongEvent(this.lat, this.long);
}

class GetLatLongEvent extends PenaltySubmitState {
  String? lat;
  String? long;

  GetLatLongEvent(this.lat, this.long);
}

class PenaltySubmitInitEvent extends PenaltySubmitEvent {}

class PenaltySubmitOffenceEvent extends PenaltySubmitEvent {}

class PenaltySubmitState {}

class PenaltySubmitInitialState extends PenaltySubmitState {}

class PenaltySubmitLoadingState extends PenaltySubmitState {}

class PenaltySubmitSuccessState extends PenaltySubmitState {
  String refCaseId;

  PenaltySubmitSuccessState(this.refCaseId);
}

class PenaltySavedSuccessState extends PenaltySubmitState {
  String refCaseId;

  PenaltySavedSuccessState(this.refCaseId);
}

class PenaltySubmitErrorState extends PenaltySubmitState {
  String error;

  PenaltySubmitErrorState(this.error);
}

class PenaltySubmitBloc extends Bloc<PenaltySubmitEvent, PenaltySubmitState> {
  CarParkingPenaltyRepo carParkingPenaltyRepo;
  String caseReferance = '';

  PenaltySubmitBloc(this.carParkingPenaltyRepo)
      : super(PenaltySubmitInitialState());

  @override
  Stream<PenaltySubmitState> mapEventToState(PenaltySubmitEvent event) async* {
    LoginModel user = await SqliteDB.instance.getLoginModelData();
    var id = await getId();

    // for search button -----
    if (event is PenaltySubmitSubmitEvent) {
      bool checkInternet = await Utils.checkInternet();
      Map<String, dynamic> requestData = {
        "action": AppConfig.submitParkingPenaltyData,
        "tocid": AppConfig.tocId,
        "userID": user.STUSER!.ID!,
        "colour": event.data['color'],
        "offence_dt": DateFormat('dd-MMM-yyyy').format(DateFormat("yyyy-MM-dd")
            .parse(event.data['offencetimeRaw'].toString())),
        "offence_hour": event.data['offencetimeRaw'].hour.toString(),
        "offence_minute": event.data['offencetimeRaw'].minute.toString(),
        "location": event.data['location']['carpark_location_id'],
        "fileNames": event.data['fileNames'],
        "s3filepath": event.data['s3filepath'],
        "onlinefilesname": event.data['onlinefilesname'],
        "s3onlinefilesize": event.data['s3onlinefilesize'].toString(),
        "macAddress": id!,
        "filescount": event.data['filescount'].toString(),
        "caseNum": caseReferance,
        "model": event.data['model'],
        "reason": event.data['reason_id'],
        "make": event.data['make'],
        "vreg_no": event.data['vehicle'],
        "ssessionId": user.STCONFIG!.SAPPSESSIONID!,
        "username": user.STUSER!.SUSERNAME!,
        'longitude': event.lat,
        'latitude': event.long,
      };
      try {
        if (checkInternet) {
          locator<DialogService>().showLoader();

          final res = await carParkingPenaltyRepo.submitParkingPenaltyData(
              requestData: requestData);

          locator<DialogService>().hideLoader();

          if (res.isSuccess) {
            if ((res.data.MESSAGE ?? "").isNotEmpty) {
              // locator<ToastService>().showValidationMessage(event.context!,res.data.MESSAGE.toString());
              Fluttertoast.showToast(msg: res.data.MESSAGE.toString());
              SqliteDB.instance.updateCaseRef(caseReferance);
              yield PenaltySubmitSuccessState(caseReferance);
            } else {
              yield PenaltySubmitErrorState("Something went wrong.");
            }
          } else {
            yield PenaltySubmitErrorState("Something went wrong.");
          }
        } else {
          // save request of PCN
          await SqliteDB.instance.insertAPIRequestData({
            "id": caseReferance,
            "body": jsonEncode(requestData),
            "request_section": "PCN",
            "request_sub_section": "main",
          });
          List<Map<String, dynamic>> imageMapSyncList =
              BlocProvider.of<PCNImageSubmitBloc>(event.context!).imageMapList;
          await Future.forEach(imageMapSyncList, (dynamic request) async {
            // save request of UFN
            await SqliteDB.instance.insertAPIImagesRequestData(
                requestData['caseNum'],
                jsonEncode(request["data"]),
                request["path"],
                request["type"],
                "PCN",
                "review");
          });
          SqliteDB.instance.updateCaseRef(caseReferance);
          locator<ToastService>()
              .showLong("PCN Data successfully saved in database.");
          yield PenaltySubmitSuccessState(caseReferance);
        }
      } catch (error) {
        // save request of PCN
        await SqliteDB.instance.insertAPIRequestData({
          "id": caseReferance,
          "body": jsonEncode(requestData),
          "request_section": "PCN",
          "request_sub_section": "main",
        });
        List<Map<String, dynamic>> imageMapSyncList =
            BlocProvider.of<PCNImageSubmitBloc>(event.context!).imageMapList;
        await Future.forEach(imageMapSyncList, (dynamic request) async {
          // save request of UFN
          await SqliteDB.instance.insertAPIImagesRequestData(
              requestData['caseNum'],
              jsonEncode(request["data"]),
              request["path"],
              request["type"],
              "PCN",
              "review");
        });
        SqliteDB.instance.updateCaseRef(caseReferance);
        locator<ToastService>()
            .showLong("PCN Data successfully saved in database.");
        yield PenaltySubmitSuccessState(caseReferance);
      }
      yield PenaltySubmitErrorState("Something Went Wrong");
    } else if (event is OfflinePenaltySubmitEvent) {
      bool checkInternet = await Utils.checkInternet();
      if (checkInternet) {
        final res = await carParkingPenaltyRepo.submitParkingPenaltyData(
            requestData: event.data);

        if (res.isSuccess) {
          if ((res.data.MESSAGE ?? "").isNotEmpty) {
            locator<DialogService>().hideLoader();

            Fluttertoast.showToast(msg: "Case details added successfully.");

            //Clear old history from table
            await SqliteDB.instance.deleteAPIRequestData(
                caseNum: event.data['caseNum'], subType: "main");
            await SqliteDB.instance
                .deleteSubSectionsImagesData(event.data['caseNum'], "review");
          } else {
            yield PenaltySubmitErrorState("Something went wrong.");
          }
        } else {
          //Clear old history from table
          await SqliteDB.instance.deleteAPIRequestData(
              caseNum: event.data['caseNum'], subType: "main");
          await SqliteDB.instance
              .deleteSubSectionsImagesData(event.data['caseNum'], "review");
          yield PenaltySubmitErrorState("Something went wrong.");
        }
      }
    } else if (event is PenaltySubmitInitEvent) {
      var list = await SqliteDB.instance.getReferenceList();
      var caseNum = '';

      for (var e in list) {
        if (e!.ISUSED == 0 &&
            e.ISLOCKED == 1 &&
            e.CASE_REFERENCE_NO!.toLowerCase().contains('pcn')) {
          caseNum = e.CASE_REFERENCE_NO ?? '';
          print('Case matched ${list.length}');
          break;
        }
      }
      caseReferance = caseNum;
    } else if (event is SetLatLongEvent) {
      yield GetLatLongEvent(event.lat, event.long);
    }
  }
}

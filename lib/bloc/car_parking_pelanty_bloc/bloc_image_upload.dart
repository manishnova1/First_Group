// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:railpaytro/common/Utils/utils.dart';
import '../../Ui/Pages/Role_stationsTeam/car_parking_penality/summary_car_parking_penality.dart';
import '../../Ui/Utils/HelpfullMethods.dart';
import '../../common/locator/locator.dart';
import '../../common/service/dialog_service.dart';
import '../../common/service/toast_service.dart';
import '../../constants/app_config.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/auth/login_model.dart';
import '../../data/repo/car_parking_penalty_repo.dart';

class PCNImageSubmitEvent {}

class PCNUploadImageEvent extends PCNImageSubmitEvent {
  File? image;
  BuildContext? context;

  PCNUploadImageEvent({this.image, this.context});
}

class PCNImageDeleteEvent extends PCNImageSubmitEvent {
  int fileIndex;
  List<File> imageslist;

  PCNImageDeleteEvent(this.fileIndex, this.imageslist);
}

class PCNReviewNextButton extends PCNImageSubmitEvent {
  BuildContext? context;
  Map<String, dynamic>? dataobj;
  List<File>? imageslist;

  PCNReviewNextButton({this.context, this.dataobj, this.imageslist});
}

class PCNImageSubmitState {}

class PCNImageSubmitInitialState extends PCNImageSubmitState {}

class PCNImageSubmitLoadingState extends PCNImageSubmitState {}

class PCNImageDeleteSuccessState extends PCNImageSubmitState {
  int index;
  List<File> imageslist;

  PCNImageDeleteSuccessState(this.index, this.imageslist);
}

class PCNImageSubmitUploadImageProgressPercentState
    extends PCNImageSubmitState {
  String percentage;

  PCNImageSubmitUploadImageProgressPercentState(this.percentage);
}

class PCNImageSubmitSuccessState extends PCNImageSubmitState {
  File img;

  PCNImageSubmitSuccessState(this.img);
}

class PCNImageSubmitErrorState extends PCNImageSubmitState {
  String errorMsg;

  PCNImageSubmitErrorState(this.errorMsg);
}

//-----

class PCNImageSubmitBloc
    extends Bloc<PCNImageSubmitEvent, PCNImageSubmitState> {
  CarParkingPenaltyRepo carParkingPenaltyRepo;

  PCNImageSubmitBloc(this.carParkingPenaltyRepo)
      : super(PCNImageSubmitInitialState());

  List<Map<String, dynamic>> imageMapList = [];

  @override
  Stream<PCNImageSubmitState> mapEventToState(
      PCNImageSubmitEvent event) async* {
    LoginModel user = await SqliteDB.instance.getLoginModelData();
    var id = await getId();
    if (event is PCNUploadImageEvent) {
      bool checkInternet = await Utils.checkInternet();
      if (checkInternet) {
        yield PCNImageSubmitLoadingState();
        try {
          final header = {
            "APIKey": AppConfig.apiKey,
          };

          final prem = {
            "action": AppConfig.uploadRevpTicketImage,
            "tocid": AppConfig.tocId,
            "ssessionId": user.STCONFIG!.SAPPSESSIONID!,
            "macAddress": id!,
            "imageFolderName": "parking_penalty_images",
            "userID": user.STUSER!.ID!,
            "username": user.STUSER!.SUSERNAME,
            "ticketImage": await MultipartFile.fromFile(event.image!.path,
                filename: event.image!.path.split('/').last)
          };

          var formData = FormData.fromMap(prem);
          StreamController<String> streamController = StreamController();
          Response? responseData;
          Dio(BaseOptions(receiveTimeout: 5000)).post(
              AppConfig.baseUrl + AppConfig.endPoint,
              queryParameters: prem,
              data: formData, onSendProgress: (received, total) {
            streamController.add(((received / total) * 100).round().toString());
          }, options: Options(headers: header)).then((Response response) {
            responseData = response;
          }).catchError((ex) {
            if (ex.type == DioErrorType.receiveTimeout) {
              streamController.add("receiveTimeout");
            }
          }).whenComplete(() {
            streamController.close();
          });

          await for (String p in streamController.stream) {
            if (p == "receiveTimeout") {
              //Save path in offline case
              imageMapList.add(
                  {"type": "offline", "data": null, "path": event.image!.path});
              yield PCNImageSubmitSuccessState(event.image!);
            } else {
              yield PCNImageSubmitUploadImageProgressPercentState(p);
            }
          }

          var data = responseData!.data;
          if (responseData!.statusCode == 201 && data is Map) {
            imageMapList.add({
              "type": "online",
              "data": data,
              "path": data['TICKETIMAGEPATH']
            });
            locator<ToastService>().showValidationMessage2(
                event.context!, data["MESSAGE"].toString());

            yield PCNImageSubmitSuccessState(event.image!);
          } else {
            var data = responseData!.data;
            locator<ToastService>().showValidationMessage(
                event.context!, data['ERROR'][0].toString());

            yield PCNImageSubmitErrorState(data['ERROR'][0]);
          }
        } catch (e) {}
      } else {
        //Save path in offline case
        imageMapList
            .add({"type": "offline", "data": null, "path": event.image!.path});
        yield PCNImageSubmitSuccessState(event.image!);
      }
    }
    if (event is PCNImageDeleteEvent) {
      try {
        bool checkInternet = await Utils.checkInternet();
        if (checkInternet) {
          Map<String, dynamic> deleteMap = imageMapList[event.fileIndex];
          locator<DialogService>().showLoader();

          var res = await carParkingPenaltyRepo.deleteTicketImage(
              macAddress: user.STUSER!.MACADRESS!,
              ssessionId: user.STCONFIG!.SAPPSESSIONID!,
              userID: user.STUSER!.ID!,
              imagepath: deleteMap["path"]);

          if (res.status == 201) {
            locator<DialogService>().hideLoader();
            Fluttertoast.showToast(msg: res.message!);
            imageMapList.removeAt(event.fileIndex);
            event.imageslist.removeAt(event.fileIndex);
            yield PCNImageDeleteSuccessState(event.fileIndex, event.imageslist);
          } else {
            locator<DialogService>().hideLoader();
          }
        } else {
          Fluttertoast.showToast(msg: "Images successfully deleted");
          imageMapList.removeAt(event.fileIndex);
          event.imageslist.removeAt(event.fileIndex);
          yield PCNImageDeleteSuccessState(event.fileIndex, event.imageslist);
        }
      } catch (e) {
        locator<DialogService>().hideLoader();
      }
    } else if (event is PCNReviewNextButton) {
      var filePath = [];
      var fileSize = [];
      var fileNames = [];

      await Future.forEach(imageMapList, (element) {
        dynamic data = element as Map<String, dynamic>;
        if (data["type"] == 'online') {
          fileNames
              .add(data['data']['TICKETIMAGEPATH'].toString().split('/').last);
          fileSize.add(data['data']['TICKETIMAGESIZE'].toString());
          filePath.add(data['data']['TICKETIMAGEPATH'].toString());
        }
      });

      Map<String, dynamic> dumpMap = {
        'fileNames': '',
        'filescount': imageMapList.length.toString(),
        's3filepath': filePath.join(','),
        'onlinefilesname': fileNames.join(','),
        's3onlinefilesize': fileSize.join(','),
      };
      event.dataobj!.addAll(dumpMap);
      Navigator.push(
          event.context!,
          MaterialPageRoute(
              builder: (context) =>
                  SummaryCarParking(event.dataobj!, event.imageslist!)));
    }
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:railpaytro/common/Utils/utils.dart';
import '../../Ui/Pages/Role_stationsTeam/unpaid_fare_issue/payment_details.dart';
import '../../Ui/Utils/HelpfullMethods.dart';
import '../../common/locator/locator.dart';
import '../../common/service/dialog_service.dart';
import '../../common/service/toast_service.dart';
import '../../constants/app_config.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/auth/login_model.dart';
import '../../data/repo/ufn_repo.dart';
import 'address_screen_bloc.dart';

class ImageSubmitEvent {}

class UploadImageEvent extends ImageSubmitEvent {
  File? image;
  BuildContext? context;

  UploadImageEvent({this.image, this.context});
}

class ImageDeleteEvent extends ImageSubmitEvent {
  int fileIndex;
  List<File> imageslist;

  ImageDeleteEvent(this.fileIndex, this.imageslist);
}

class AttachmentNextButton extends ImageSubmitEvent {
  BuildContext? context;

  AttachmentNextButton({this.context});
}

class ImageSubmitState {}

class ImageSubmitInitialState extends ImageSubmitState {}

class ImageSubmitLoadingState extends ImageSubmitState {}

class ImageDeleteSuccessState extends ImageSubmitState {
  int index;
  List<File> imageslist;

  ImageDeleteSuccessState(this.index, this.imageslist);
}

class ImageUploadProgressPercentState extends ImageSubmitState {
  String percentage;

  ImageUploadProgressPercentState(this.percentage);
}

class ImageSubmitSuccessState extends ImageSubmitState {
  File img;

  ImageSubmitSuccessState(this.img);
}

class ImageSubmitErrorState extends ImageSubmitState {
  String errorMsg;

  ImageSubmitErrorState(this.errorMsg);
}

//-----

class ImageSubmitBloc extends Bloc<ImageSubmitEvent, ImageSubmitState> {
  UfnRepo ufnRepo;

  ImageSubmitBloc(this.ufnRepo) : super(ImageSubmitInitialState());

  List<Map<String, dynamic>> imageMapList = [];

  @override
  Stream<ImageSubmitState> mapEventToState(ImageSubmitEvent event) async* {
    LoginModel user = await SqliteDB.instance.getLoginModelData();
    var id = await getId();
    if (event is UploadImageEvent) {
      bool checkInternet = await Utils.checkInternet();
      if (checkInternet) {
        yield ImageSubmitLoadingState();
        try {
          final header = {
            "APIKey": AppConfig.apiKey,
          };

          final prem = {
            "action": AppConfig.uploadRevpTicketImage,
            "tocid": AppConfig.tocId,
            "ssessionId": user.STCONFIG!.SAPPSESSIONID!,
            "macAddress": id!,
            "imageFolderName": "Revp_case_attachment",
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
              yield ImageSubmitSuccessState(event.image!);
            } else {
              yield ImageUploadProgressPercentState(p);
            }
          }
          locator<DialogService>().hideLoader();
          var data = responseData!.data;
          if (responseData!.statusCode == 201 && data is Map) {
            imageMapList.add({
              "type": "online",
              "data": data,
              "path": data['TICKETIMAGEPATH']
            });
            locator<ToastService>().showValidationMessage2(
                event.context!, data["MESSAGE"].toString());

            yield ImageSubmitSuccessState(event.image!);
          } else {
            var data = responseData!.data;
            locator<ToastService>()
                .showValidationMessage(event.context!, data['ERROR'][0]);

            yield ImageSubmitErrorState(data['ERROR'][0]);
          }
        } catch (e) {}
      } else {
        //Save path in offline case
        imageMapList
            .add({"type": "offline", "data": null, "path": event.image!.path});
        yield ImageSubmitSuccessState(event.image!);
      }
    }
    if (event is ImageDeleteEvent) {
      try {
        bool checkInternet = await Utils.checkInternet();
        if (checkInternet) {
          yield ImageSubmitLoadingState();
          Map<String, dynamic> deleteMap = imageMapList[event.fileIndex];
          // locator<DialogService>().showLoader(dismissable: false);

          var res = await ufnRepo.deleteTicketImage(
              macAddress: user.STUSER!.MACADRESS!,
              ssessionId: user.STCONFIG!.SAPPSESSIONID!,
              userID: user.STUSER!.ID!,
              imagepath: deleteMap["path"]);

          if (res.status == 201) {
            locator<DialogService>().hideLoader();
            Fluttertoast.showToast(msg: res.message!);
            imageMapList.removeAt(event.fileIndex);
            event.imageslist.removeAt(event.fileIndex);
            yield ImageDeleteSuccessState(event.fileIndex, event.imageslist);
          } else {
            locator<DialogService>().hideLoader();
          }
        } else {
          Fluttertoast.showToast(msg: "Images successfully deleted");
          imageMapList.removeAt(event.fileIndex);
          event.imageslist.removeAt(event.fileIndex);
          yield ImageDeleteSuccessState(event.fileIndex, event.imageslist);
        }
      } catch (e) {
        locator<DialogService>().hideLoader();
      }
    } else if (event is AttachmentNextButton) {
      Map<String, dynamic> subMap =
          BlocProvider.of<AddressUfnBloc>(event.context!).submitAddressMap;
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
      subMap.addAll(dumpMap);
      BlocProvider.of<AddressUfnBloc>(event.context!).submitAddressMap = subMap;
      Navigator.push(event.context!,
          MaterialPageRoute(builder: (context) => Unpaid_PaymentDetails()));
    }
  }
}

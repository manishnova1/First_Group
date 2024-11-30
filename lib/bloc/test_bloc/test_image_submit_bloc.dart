// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:railpaytro/bloc/test_bloc/test_address_bloc.dart';
import 'package:railpaytro/common/Utils/utils.dart';
import '../../Ui/Pages/Role_stationsTeam/test_notice_case/test_payment_details.dart';
import '../../Ui/Utils/HelpfullMethods.dart';
import '../../common/locator/locator.dart';
import '../../common/service/dialog_service.dart';
import '../../common/service/toast_service.dart';
import '../../constants/app_config.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/auth/login_model.dart';
import '../../data/repo/ufn_repo.dart';

class TestImageSubmitEvent {}

class TestUploadImageEvent extends TestImageSubmitEvent {
  File? image;
  BuildContext? context;

  TestUploadImageEvent({this.image, this.context});
}

class TestImageDeleteEvent extends TestImageSubmitEvent {
  int fileIndex;
  List<File> imageslist;

  TestImageDeleteEvent(this.fileIndex, this.imageslist);
}

class TestAttachmentNextButton extends TestImageSubmitEvent {
  BuildContext? context;

  TestAttachmentNextButton({this.context});
}

class TestImageSubmitState {}

class TestImageSubmitInitialState extends TestImageSubmitState {}

class TestImageSubmitLoadingState extends TestImageSubmitState {}

class TestImageDeleteSuccessState extends TestImageSubmitState {
  int index;
  List<File> imageslist;

  TestImageDeleteSuccessState(this.index, this.imageslist);
}

class TestImageSubmitSuccessState extends TestImageSubmitState {
  File img;

  TestImageSubmitSuccessState(this.img);
}

class TestImageUploadImageProgressPercentState extends TestImageSubmitState {
  String percentage;

  TestImageUploadImageProgressPercentState(this.percentage);
}

class TestImageSubmitErrorState extends TestImageSubmitState {
  String errorMsg;

  TestImageSubmitErrorState(this.errorMsg);
}

//-----

class TestImageSubmitBloc
    extends Bloc<TestImageSubmitEvent, TestImageSubmitState> {
  UfnRepo ufnRepo;

  TestImageSubmitBloc(this.ufnRepo) : super(TestImageSubmitInitialState());

  List<Map<String, dynamic>> imageMapList = [];

  @override
  Stream<TestImageSubmitState> mapEventToState(
      TestImageSubmitEvent event) async* {
    LoginModel user = await SqliteDB.instance.getLoginModelData();
    var id = await getId();
    if (event is TestUploadImageEvent) {
      bool checkInternet = await Utils.checkInternet();
      if (checkInternet) {
        yield TestImageSubmitLoadingState();

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
        Dio().post(AppConfig.baseUrl + AppConfig.endPoint,
            queryParameters: prem,
            data: formData, onSendProgress: (received, total) {
          streamController.add(((received / total) * 100).round().toString());
        }, options: Options(headers: header)).then((Response response) {
          responseData = response;
        }).catchError((ex) {
          //streamController.add(ex.toString());
        }).whenComplete(() {
          streamController.close();
        });
        await for (String p in streamController.stream) {
          yield TestImageUploadImageProgressPercentState(p);
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
          yield TestImageSubmitSuccessState(event.image!);
        } else {
          var data = responseData!.data;
          Utils.showToast(data['ERROR'][0]);
          yield TestImageSubmitErrorState(data['ERROR'][0]);
        }
      } else {
        //Save path in offline case
        imageMapList
            .add({"type": "offline", "data": null, "path": event.image!.path});
        yield TestImageSubmitSuccessState(event.image!);
      }
    }
    if (event is TestImageDeleteEvent) {
      try {
        bool checkInternet = await Utils.checkInternet();
        if (checkInternet) {
          Map<String, dynamic> deleteMap = imageMapList[event.fileIndex];
          locator<DialogService>().showLoader(dismissable: false);

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
            yield TestImageDeleteSuccessState(
                event.fileIndex, event.imageslist);
          } else {
            locator<DialogService>().hideLoader();
          }
        } else {
          Fluttertoast.showToast(msg: "Images successfully deleted");
          imageMapList.removeAt(event.fileIndex);
          event.imageslist.removeAt(event.fileIndex);
          yield TestImageDeleteSuccessState(event.fileIndex, event.imageslist);
        }
      } catch (e) {
        locator<DialogService>().hideLoader();
      }
    } else if (event is TestAttachmentNextButton) {
      Map<String, dynamic> subMap =
          BlocProvider.of<AddressTestBloc>(event.context!).submitAddressMap;
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
      BlocProvider.of<AddressTestBloc>(event.context!).submitAddressMap =
          subMap;
      Navigator.push(
          event.context!,
          MaterialPageRoute(
              builder: (context) => Test_Unpaid_PaymentDetails()));
    }
  }
}

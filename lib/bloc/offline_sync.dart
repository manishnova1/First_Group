import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/bloc/ufn_luno_bloc/submit_form_bloc.dart';
import 'package:railpaytro/constants/app_config.dart';
import '../Ui/Utils/HelpfullMethods.dart';
import '../common/Utils/utils.dart';
import '../constants/app_utils.dart';
import '../data/constantes/db_constants.dart';
import '../data/local/sqlite.dart';
import '../data/model/auth/login_model.dart';
import 'car_parking_pelanty_bloc/bloc_capture_image_upload.dart';
import 'car_parking_pelanty_bloc/bloc_car_penalty_submit.dart';
import 'intelligent_bloc/bloc_IR_submit.dart';
import 'offender_description_bloc.dart';

class OfflineSyncEvent {}

class OfflineOnlineSyncEvent extends OfflineSyncEvent {
  BuildContext context;

  OfflineOnlineSyncEvent(this.context);
}

class OfflineOnlineCheckInternetStatusEvent extends OfflineSyncEvent {
  bool isInternetAvailable;

  OfflineOnlineCheckInternetStatusEvent(this.isInternetAvailable);
}

class OfflineSyncState {}

class OfflineSyncInitialState extends OfflineSyncState {}

class OfflineSyncLoadingState extends OfflineSyncState {}

class OfflineSyncSuccessState extends OfflineSyncState {
  OfflineSyncSuccessState();
}

class OfflineOnlineCheckInternetStatusState extends OfflineSyncState {
  bool isInternetAvailable;

  OfflineOnlineCheckInternetStatusState(this.isInternetAvailable);
}

class OfflineSyncErrorState extends OfflineSyncState {
  OfflineSyncErrorState();
}

class OfflineSyncBloc extends Bloc<OfflineSyncEvent, OfflineSyncState> {
  OfflineSyncBloc() : super(OfflineSyncInitialState());

  @override
  Stream<OfflineSyncState> mapEventToState(OfflineSyncEvent event) async* {
    bool OffllineStatus = await AppUtils().getoffline();

    if (event is OfflineOnlineCheckInternetStatusEvent) {
      yield OfflineOnlineCheckInternetStatusState(event.isInternetAvailable);
    } else if (event is OfflineOnlineSyncEvent &&  OffllineStatus==false) {
      LoginModel user = await SqliteDB.instance.getLoginModelData();
      var id = await getId();
      bool checkInternet = await Utils.checkInternet();
      if (checkInternet) {
        try {
          final header = {
            "APIKey": AppConfig.apiKey,
          };
          // Get request :
          List<Map<String, dynamic>> getRequestData =
              await SqliteDB.instance.getAPIRequestsData();
          await Future.forEach(getRequestData, (element) async {
            //   locator<DialogService>().showLoader(message: 'Uploading offline data, Please wait..');
            Map<String, dynamic> requestData = element as Map<String, dynamic>;
            Map<String, dynamic> bodyRequestData =
                jsonDecode(requestData[DBConstants.CL_REQUEST_DATA]);
            if (requestData[DBConstants.CL_REQUEST_SECTION_NAME] == "UFN" &&
                requestData[DBConstants.CL_REQUEST_SUB_SECTION_NAME] ==
                    "main") {
              //Get Images
              List<Map<String, dynamic>> getImagesData = await SqliteDB.instance
                  .getImagesAPIRequestData(
                      requestData[DBConstants.CL_API_REQUEST_ID] ?? "None");
              var filePath = [];
              var fileSize = [];
              var fileNames = [];

              await Future.forEach(getImagesData, (element) async {
                Map<String, dynamic> imageRequestData =
                    element as Map<String, dynamic>;

                if (imageRequestData[DBConstants.CL_IMAGES_TYPE] == "online") {
                  dynamic uploadedImageData =
                      jsonDecode(imageRequestData[DBConstants.CL_IMAGES_DATA]);
                  fileNames.add(uploadedImageData['TICKETIMAGEPATH']
                      .toString()
                      .split('/')
                      .last);
                  fileSize.add(uploadedImageData['TICKETIMAGESIZE']);
                  filePath.add(uploadedImageData['TICKETIMAGEPATH']);
                } else {
                  final prem = {
                    "action": AppConfig.uploadRevpTicketImage,
                    "tocid": AppConfig.tocId,
                    "ssessionId": user.STCONFIG!.SAPPSESSIONID!,
                    "macAddress": id!,
                    "imageFolderName": "Revp_case_attachment",
                    "userID": user.STUSER!.ID!,
                    "ticketImage": await MultipartFile.fromFile(
                        imageRequestData[DBConstants.CL_IMAGES_PATH],
                        filename: imageRequestData[DBConstants.CL_IMAGES_PATH])
                  };

                  var formData = FormData.fromMap(prem);

                  var response = await Dio().post(
                      AppConfig.baseUrl + AppConfig.endPoint,
                      queryParameters: prem,
                      data: formData,
                      options: Options(headers: header));

                  if (response.statusCode == 201) {
                    var data = response.data;
                    fileNames.add(
                        data['TICKETIMAGEPATH'].toString().split('/').last);
                    fileSize.add(data['TICKETIMAGESIZE']);
                    filePath.add(data['TICKETIMAGEPATH']);
                  }
                }
              });
              try {
                Map<String, dynamic> dumpMap = {
                  'fileNames': '',
                  'filescount': filePath.length,
                  's3filepath': filePath.join(','),
                  'onlinefilesname': fileNames.join(','),
                  's3onlinefilesize': fileSize.join(','),
                };
                bodyRequestData.addAll(dumpMap);

                await submitUfnData(bodyRequestData, event.context, false);
              } catch (e) {
                Utils.showToast(
                    "Case couldn't saved, issue reported to further check, error");
              }
            } else if (requestData[DBConstants.CL_REQUEST_SECTION_NAME] ==
                    "UFN(HT)" &&
                requestData[DBConstants.CL_REQUEST_SUB_SECTION_NAME] ==
                    "offender") {
              BlocProvider.of<SubmitFormBloc>(event.context).add(
                  OfflineOffenderDescriptionEvent(
                      context: event.context, offlineRequest: bodyRequestData));
              AppUtils().setoffline(true);

            }

            if (requestData[DBConstants.CL_REQUEST_SECTION_NAME] ==
                    "UFN(LUNO)" &&
                requestData[DBConstants.CL_REQUEST_SUB_SECTION_NAME] ==
                    "main") {
              //Get Images
              List<Map<String, dynamic>> getImagesData = await SqliteDB.instance
                  .getImagesAPIRequestData(
                      requestData[DBConstants.CL_API_REQUEST_ID] ?? "None");
              var filePath = [];
              var fileSize = [];
              var fileNames = [];

              await Future.forEach(getImagesData, (element) async {
                Map<String, dynamic> imageRequestData =
                    element as Map<String, dynamic>;

                if (imageRequestData[DBConstants.CL_IMAGES_TYPE] == "online") {
                  dynamic uploadedImageData =
                      jsonDecode(imageRequestData[DBConstants.CL_IMAGES_DATA]);
                  fileNames.add(uploadedImageData['TICKETIMAGEPATH']
                      .toString()
                      .split('/')
                      .last);
                  fileSize.add(uploadedImageData['TICKETIMAGESIZE']);
                  filePath.add(uploadedImageData['TICKETIMAGEPATH']);
                } else {
                  final prem = {
                    "action": AppConfig.uploadRevpTicketImage,
                    "tocid": AppConfig.tocId,
                    "ssessionId": user.STCONFIG!.SAPPSESSIONID!,
                    "macAddress": id!,
                    "imageFolderName": "Revp_case_attachment",
                    "userID": user.STUSER!.ID!,
                    "ticketImage": await MultipartFile.fromFile(
                        imageRequestData[DBConstants.CL_IMAGES_PATH],
                        filename: imageRequestData[DBConstants.CL_IMAGES_PATH])
                  };

                  var formData = FormData.fromMap(prem);

                  var response = await Dio().post(
                      AppConfig.baseUrl + AppConfig.endPoint,
                      queryParameters: prem,
                      data: formData,
                      options: Options(headers: header));

                  if (response.statusCode == 201) {
                    var data = response.data;
                    fileNames.add(
                        data['TICKETIMAGEPATH'].toString().split('/').last);
                    fileSize.add(data['TICKETIMAGESIZE']);
                    filePath.add(data['TICKETIMAGEPATH']);
                  }
                }
              });
              try {
                Map<String, dynamic> dumpMap = {
                  'fileNames': '',
                  'filescount': filePath.length,
                  's3filepath': filePath.join(','),
                  'onlinefilesname': fileNames.join(','),
                  's3onlinefilesize': fileSize.join(','),
                };
                bodyRequestData.addAll(dumpMap);

                await submitUfnData(bodyRequestData, event.context, false);
              } catch (e) {
                Utils.showToast(
                    "Case couldn't saved, issue reported to further check, error");
              }
            } else if (requestData[DBConstants.CL_REQUEST_SECTION_NAME] ==
                    "UFN(LUNO)" &&
                requestData[DBConstants.CL_REQUEST_SUB_SECTION_NAME] ==
                    "offender") {
              BlocProvider.of<SubmitFormBloc>(event.context).add(
                  OfflineOffenderDescriptionEvent(
                      context: event.context, offlineRequest: bodyRequestData));
              AppUtils().setoffline(true);

            }
         else if (requestData[DBConstants.CL_REQUEST_SECTION_NAME] ==
                    "MG11" &&
                requestData[DBConstants.CL_REQUEST_SUB_SECTION_NAME] ==
                    "offender") {
              BlocProvider.of<OffenderDescriptionBloc>(event.context).add(
                  OfflineOffenderDescriptionDataEvent(
                      context: event.context, offlineRequest: bodyRequestData));
            }  else if (requestData[DBConstants.CL_REQUEST_SECTION_NAME] ==
                    "PF" &&
                requestData[DBConstants.CL_REQUEST_SUB_SECTION_NAME] ==
                    "offender") {
              BlocProvider.of<OffenderDescriptionBloc>(event.context).add(
                  OfflineOffenderDescriptionDataEvent(
                      context: event.context, offlineRequest: bodyRequestData));
            } else if (requestData[DBConstants.CL_REQUEST_SECTION_NAME] ==
                    "IR" &&
                requestData[DBConstants.CL_REQUEST_SUB_SECTION_NAME] ==
                    "main") {
              //Get Images
              List<Map<String, dynamic>> getImagesData = await SqliteDB.instance
                  .getImagesAPIRequestData(
                      requestData[DBConstants.CL_API_REQUEST_ID] ?? "None");
              var filePath = [];
              var fileSize = [];
              var fileNames = [];

              await Future.forEach(getImagesData, (element) async {
                Map<String, dynamic> imageRequestData =
                    element as Map<String, dynamic>;

                if (imageRequestData[DBConstants.CL_IMAGES_TYPE] == "online") {
                  dynamic uploadedImageData =
                      jsonDecode(imageRequestData[DBConstants.CL_IMAGES_DATA]);
                  fileNames.add(uploadedImageData['TICKETIMAGEPATH']
                      .toString()
                      .split('/')
                      .last);
                  fileSize.add(uploadedImageData['TICKETIMAGESIZE']);
                  filePath.add(uploadedImageData['TICKETIMAGEPATH']);
                } else {
                  final prem = {
                    "action": AppConfig.uploadRevpTicketImage,
                    "tocid": AppConfig.tocId,
                    "ssessionId": user.STCONFIG!.SAPPSESSIONID!,
                    "macAddress": id!,
                    "imageFolderName": "Revp_case_attachment",
                    "userID": user.STUSER!.ID!,
                    "ticketImage": await MultipartFile.fromFile(
                        imageRequestData[DBConstants.CL_IMAGES_PATH],
                        filename: imageRequestData[DBConstants.CL_IMAGES_PATH])
                  };

                  var formData = FormData.fromMap(prem);

                  var response = await Dio().post(
                      AppConfig.baseUrl + AppConfig.endPoint,
                      queryParameters: prem,
                      data: formData,
                      options: Options(headers: header));

                  if (response.statusCode == 201) {
                    var data = response.data;
                    fileNames.add(
                        data['TICKETIMAGEPATH'].toString().split('/').last);
                    fileSize.add(data['TICKETIMAGESIZE']);
                    filePath.add(data['TICKETIMAGEPATH']);
                  }
                }
              });
              try {
                Map<String, dynamic> dumpMap = {
                  'fileNames': '',
                  'filescount': filePath.length.toString(),
                  's3filepath': filePath.join(','),
                  'onlinefilesname': fileNames.join(','),
                  's3onlinefilesize': fileSize.join(','),
                };
                bodyRequestData.addAll(dumpMap);

                await submitIRData(bodyRequestData, event.context, false);
              } catch (e) {
                // locator<DialogService>().hideLoader();
                Utils.showToast(
                    "Case couldn't saved, issue reported to further check, error");
              }
            } else if (requestData[DBConstants.CL_REQUEST_SECTION_NAME] ==
                "PCN") {
              var filePath = [];
              var fileSize = [];
              var fileNames = [];
              //Get Images
              List<Map<String, dynamic>> getImagesData = await SqliteDB.instance
                  .getImagesAPIRequestData(
                      requestData[DBConstants.CL_API_REQUEST_ID] ?? "None");
              await Future.forEach(getImagesData, (element) async {
                Map<String, dynamic> imageRequestData =
                    element as Map<String, dynamic>;
                if (imageRequestData[DBConstants.CL_IMAGES_SUB_SECTION] ==
                    "review") {
                  if (imageRequestData[DBConstants.CL_IMAGES_TYPE] ==
                      "offline") {
                    final prem = {
                      "action": AppConfig.uploadRevpTicketImage,
                      "tocid": AppConfig.tocId,
                      "ssessionId": user.STCONFIG!.SAPPSESSIONID!,
                      "macAddress": id!,
                      "imageFolderName": "parking_penalty_images",
                      "userID": user.STUSER!.ID!,
                      "username": user.STUSER!.SUSERNAME,
                      "ticketImage": await MultipartFile.fromFile(
                          imageRequestData[DBConstants.CL_IMAGES_PATH],
                          filename: imageRequestData[DBConstants.CL_IMAGES_PATH]
                              .toString()
                              .split('/')
                              .last)
                    };

                    var formData = FormData.fromMap(prem);

                    var response = await Dio().post(
                        AppConfig.baseUrl + AppConfig.endPoint,
                        queryParameters: prem,
                        data: formData,
                        options: Options(headers: header));
                    if (response.statusCode == 201) {
                      var data = response.data;
                      fileNames.add(
                          data['TICKETIMAGEPATH'].toString().split('/').last);
                      fileSize.add(data['TICKETIMAGESIZE']);
                      filePath.add(data['TICKETIMAGEPATH']);
                    }
                  } else {
                    dynamic uploadedImageData = jsonDecode(
                        imageRequestData[DBConstants.CL_IMAGES_DATA]);
                    fileNames.add(uploadedImageData['TICKETIMAGEPATH']
                        .toString()
                        .split('/')
                        .last);
                    fileSize.add(uploadedImageData['TICKETIMAGESIZE']);
                    filePath.add(uploadedImageData['TICKETIMAGEPATH']);
                  }
                } else if (imageRequestData[DBConstants.CL_IMAGES_TYPE] ==
                        "offline" &&
                    imageRequestData[DBConstants.CL_IMAGES_SUB_SECTION] ==
                        "capture") {
                  List<dynamic> imageList =
                      jsonDecode(imageRequestData[DBConstants.CL_IMAGES_DATA]);
                  //Upload Capture images
                  BlocProvider.of<RevpCaptureImageUploadBloc>(event.context)
                      .add(OfflineRevpCaptureImageUploadButtonEvent(
                          imageList, bodyRequestData['caseNum'] ?? ""));
                }
              });

              Map<String, dynamic> dumpMap = {
                'fileNames': '',
                'filescount': filePath.length.toString(),
                's3filepath': filePath.join(','),
                'onlinefilesname': fileNames.join(','),
                's3onlinefilesize': fileSize.join(','),
              };
              bodyRequestData.addAll(dumpMap);
              BlocProvider.of<PenaltySubmitBloc>(event.context)
                  .add(OfflinePenaltySubmitEvent(
                data: bodyRequestData,
              ));
            }
          });
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
        }
        yield OfflineSyncSuccessState();
      }
    }
  }
}

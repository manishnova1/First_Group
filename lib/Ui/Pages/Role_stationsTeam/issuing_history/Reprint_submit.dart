// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Utils/Utillities.dart';

import '../../../../bloc/ufn_luno_bloc/address_screen_bloc.dart';
import '../../../../common/locator/locator.dart';
import '../../../../common/service/dialog_service.dart';
import '../../../../constants/app_config.dart';
import '../../../../data/local/sqlite.dart';
import '../../../../data/model/auth/login_model.dart';
import '../../Role_transTeam/Reprint_common_screen.dart';


class ReprintSubmitEvent {}

class issuingButtonReprintPressed extends ReprintSubmitEvent {
  BuildContext? context;

  String caseID;
  String caseNum;

  issuingButtonReprintPressed(
      {required this.context,
        required this.caseID,
        required this.caseNum,
      });
}

class IssuingSubmitReprintState {}

class IssuingSubmitFormInitialState extends IssuingSubmitReprintState {}

class IssuingSubmitFormLoadingState extends IssuingSubmitReprintState {}

class IssuingImageDeleteSuccessState extends IssuingSubmitReprintState {}

class IssuingSubmitFormSuccessState extends IssuingSubmitReprintState {
  String? fileName;
  String? fileSize;
  String? filePath;

  IssuingSubmitFormSuccessState({this.fileName, this.fileSize, this.filePath});
}

class IssuingFormErrorState extends IssuingSubmitReprintState {
  String errorMsg;

  IssuingFormErrorState(this.errorMsg);
}


class  IssuingSubmitReprintBloc
    extends Bloc<ReprintSubmitEvent, IssuingSubmitReprintState> {
  IssuingSubmitReprintBloc() : super(IssuingSubmitFormLoadingState());

  @override
  Stream<IssuingSubmitReprintState> mapEventToState(ReprintSubmitEvent event) async* {
    if (event is issuingButtonReprintPressed) {
      LoginModel user = await SqliteDB.instance.getLoginModelData();

      Map<String, dynamic> dumpMap = {
        'action': AppConfig.revpSubmitIssuingReprint,
        'tocid': AppConfig.tocId,
        'macAddress': user.STUSER?.MACADRESS!,
        'ssessionId': user.STCONFIG?.SAPPSESSIONID!,
        'userID': user.STUSER?.ID!,
        'caseID': event.caseID,
        'caseNum':event.caseNum
      };
      submitIssuingCancelReprintData(dumpMap, event.context!);
    }
  }

  Future submitIssuingCancelReprintData(
      Map<String, dynamic> body, BuildContext context) async {
    locator<DialogService>().showLoader();

    final header = {
      "APIKey": AppConfig.apiKey,
    };

    var formData = FormData.fromMap(body);

    var response = await Dio().post(AppConfig.baseUrl + AppConfig.endPoint,
        data: formData, options: Options(headers: header));

    locator<DialogService>().hideLoader();

    if (response.statusCode == 200) {
      try {

        Map<String, dynamic> subMap = BlocProvider.of<AddressUfnBloc>(context).submitAddressMap;
        Map<String, dynamic> responseData = response.data;

        if (response.statusCode == 200 &&  responseData.containsKey('STCASEDETAILS')) {
          print(responseData['STCASEDETAILS'][0]["CASE_REF_NUMBER"]);

          dynamic stCaseDetailsString = responseData['STCASEDETAILS'][0];
          subMap.addAll({"stCaseDetails": stCaseDetailsString});
          print(subMap['stCaseDetails']['CASE_REF_NUMBER']);
          String prefix = subMap['stCaseDetails']['CASE_REF_NUMBER'].split("/")[1];

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>  Reprint_section(caseNumber: subMap['stCaseDetails']['CASE_REF_NUMBER'])));
          BlocProvider.of<AddressUfnBloc>(context).submitAddressMap = subMap;
        } else {
        }
      } catch (error) {
        print('Error decoding response: $error');
      }
    }

    else {
      var data = response.data;
      Dialogs.showValidationMessage(context,data['ERROR'][0]);
      // yield RevpTicketImageUploadErrorState(data['ERROR'][0]);
    }
  }
}

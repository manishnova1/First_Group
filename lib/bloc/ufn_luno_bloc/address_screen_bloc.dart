// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/test_notice_case/test_identity_check.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/unpaid_fare_Ht/identity_check.dart';
import 'package:railpaytro/common/service/toast_service.dart';
import 'package:railpaytro/data/model/station/revp_station_model.dart';
import 'package:railpaytro/data/model/ufn/FullAddressListModel.dart';
import 'package:railpaytro/data/repo/ufn_repo.dart';
import '../../Ui/Pages/Role_stationsTeam/unpaid_fare_issue/identity_check.dart';
import '../../common/Utils/utils.dart';
import '../../common/locator/locator.dart';
import '../../common/service/dialog_service.dart';
import '../../constants/app_config.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/auth/login_model.dart';
import '../../data/model/ufn/AddressListModel.dart';

class AddressUfnEvent {}

class AddressUfnRefreshEvent extends AddressUfnEvent {
  String? postCode;
  String? container;

  AddressUfnRefreshEvent({this.postCode, this.container});
}

class AddressUfnInitializeEvent extends AddressUfnEvent {
  AddressUfnInitializeEvent();
}

class AddressUfnSelectionEvent extends AddressUfnEvent {
  String id;
  BuildContext context;

  AddressUfnSelectionEvent(
    this.id,
    this.context,
  );
}

class AddressUfnIdentityCheck extends AddressUfnEvent {
  BuildContext context;

  AddressUfnIdentityCheck(this.context);
}

class AddressUfnIdentityCheckHt extends AddressUfnEvent {
  BuildContext context;

  AddressUfnIdentityCheckHt(this.context);
}

class AddressPfnIdentityCheck extends AddressUfnEvent {
  BuildContext context;
  bool paidCheck;

  AddressPfnIdentityCheck(this.context, this.paidCheck);
}

class AddressPfnSaveCaseNumber extends AddressUfnEvent {
  String? caseNumber;

  AddressPfnSaveCaseNumber(this.caseNumber);
}

class AddressIdentityCheckmg11 extends AddressUfnEvent {
  BuildContext context;

  AddressIdentityCheckmg11(this.context);
}

class AddressTestIdentityCheck2 extends AddressUfnEvent {
  BuildContext context;

  AddressTestIdentityCheck2(this.context);
}

class OnFullAddressSelectEvent extends AddressUfnEvent {
  BuildContext context;
  DataFullAddress dataFullAddress;

  OnFullAddressSelectEvent(this.context, this.dataFullAddress);
}

class OfflineAddressSavedEvent extends AddressUfnEvent {
  BuildContext context;
  String postcode;
  String address1;
  String address2;
  String city;
  String language;

  OfflineAddressSavedEvent(this.context, this.postcode, this.address1,
      this.address2, this.city, this.language);
}

class AddressUfnState {}

class AddressUfnInitialState extends AddressUfnState {}

class AddressUfnLoadingState extends AddressUfnState {}

class AddressUfnSuccessState extends AddressUfnState {
  AddressUfnSuccessState();
}

class AddressUfnErrorState extends AddressUfnState {
  String errorMsg;

  AddressUfnErrorState(this.errorMsg);
}

//For Revp Station List State
class StationRevpListSuccessState extends AddressUfnState {
  RevpStationModel listData;

  StationRevpListSuccessState(this.listData);
}

class StationRevpListErrorState extends AddressUfnState {
  String errorMsg;

  StationRevpListErrorState(this.errorMsg);
}
//-----

class AddressUfnBloc extends Bloc<AddressUfnEvent, AddressUfnState> {
  UfnRepo ufnRepo;
  List<DataAddress>? addressList;
  List<DataFullAddress>? fullAddressList;
  Map<String, dynamic> mapAddress = {};
  Map<String, dynamic> submitAddressMap = {};
  dynamic caseNumber = '';

  AddressUfnBloc(this.ufnRepo) : super(AddressUfnLoadingState());

  @override
  Stream<AddressUfnState> mapEventToState(AddressUfnEvent event) async* {
    LoginModel user = await SqliteDB.instance.getLoginModelData();

    if (event is AddressUfnInitializeEvent) {
      addressList = [];
      fullAddressList = [];
      yield AddressUfnSuccessState();
    } else if (event is AddressUfnRefreshEvent) {
      try {
        var res = await ufnRepo.getAddressList(
            userId: user.STUSER!.ID!,
            postCode: event.postCode ?? "",
            container: event.container ?? "",
            sessionId: user.STCONFIG!.SAPPSESSIONID!,
            macAddress: user.STUSER!.MACADRESS!);
        if (res.isSuccess) {
          Iterable listAddress = res.data;
          addressList =
              listAddress.map((e) => DataAddress.fromJson(e)).toList();
          yield AddressUfnSuccessState();
        } else {
          yield AddressUfnErrorState("Something went Wrong");
        }
      } catch (e, stacktrace) {
        debugPrint("$e : $stacktrace");
        yield AddressUfnErrorState("Something Went Wrong");
      }
    } else if (event is AddressUfnSelectionEvent) {
      var res = await ufnRepo.getFullAddressList(
          userId: user.STUSER!.ID!,
          sessionId: user.STCONFIG!.SAPPSESSIONID!,
          macAddress: user.STUSER!.MACADRESS!,
          id: event.id);
      if (res.isSuccess) {
        Iterable listAddress = res.data;
        fullAddressList =
            listAddress.map((e) => DataFullAddress.fromJson(e)).toList();

        yield AddressUfnSuccessState();
      } else {
        yield AddressUfnErrorState("Something went Wrong");
      }
    } else if (event is OnFullAddressSelectEvent) {
      mapAddress['action'] = AppConfig.revpSubmitUnpaidFareNotice;
      mapAddress['tocid'] = AppConfig.tocId;
      mapAddress['macAddress'] = user.STUSER?.MACADRESS!;
      mapAddress['toc'] = '';
      mapAddress['rid'] = '';
      mapAddress['selectedheadcode'] = '';
      mapAddress['ssessionId'] = user.STCONFIG?.SAPPSESSIONID!;
      mapAddress['userID'] = user.STUSER?.ID!;
      mapAddress['user_name'] = user.STUSER?.SUSERNAME;

      mapAddress['address_1'] = event.dataFullAddress.line1;
      submitAddressMap['address_1'] = event.dataFullAddress.line1;
      mapAddress['address_2'] = event.dataFullAddress.line2;
      submitAddressMap['address_2'] = event.dataFullAddress.line2;
      mapAddress['city'] = event.dataFullAddress.city;
      submitAddressMap['locality'] = event.dataFullAddress.city;
      mapAddress['locality'] = '';
      mapAddress['street'] = event.dataFullAddress.street;
      mapAddress['post_code'] = event.dataFullAddress.postalcode;
      submitAddressMap['post_code'] = event.dataFullAddress.postalcode;
      mapAddress['buildingname'] = event.dataFullAddress.buildingname;
      mapAddress['buildingnumber'] = event.dataFullAddress.buildingnumber;
      mapAddress['country'] = event.dataFullAddress.countryname;
      mapAddress['province'] = event.dataFullAddress.provincename;
      submitAddressMap['postcode_details'] = event.dataFullAddress.postalcode;
    } else if (event is OfflineAddressSavedEvent) {
      mapAddress['action'] = AppConfig.revpSubmitUnpaidFareNotice;
      mapAddress['tocid'] = AppConfig.tocId;
      mapAddress['macAddress'] = user.STUSER?.MACADRESS!;
      mapAddress['toc'] = '';
      mapAddress['rid'] = '';
      mapAddress['selectedheadcode'] = '';
      mapAddress['ssessionId'] = user.STCONFIG?.SAPPSESSIONID!;
      mapAddress['userID'] = user.STUSER?.ID!;
      mapAddress['user_name'] = user.STUSER?.SUSERNAME;

      mapAddress['address_1'] = event.address1;
      submitAddressMap['address_1'] = event.address1;
      mapAddress['address_2'] = event.address2;
      submitAddressMap['address_2'] = event.address2;
      mapAddress['city'] = event.city;
      submitAddressMap['locality'] = event.city;
      mapAddress['locality'] = '';
      mapAddress['street'] = null;
      mapAddress['post_code'] = event.postcode;
      submitAddressMap['post_code'] = event.postcode;
      mapAddress['buildingname'] = null;
      mapAddress['buildingnumber'] = null;
      mapAddress['country'] = null;
      mapAddress['province'] = null;
      submitAddressMap['postcode_details'] = event.postcode;
    } else if (event is AddressUfnIdentityCheckHt) {
      try {
        bool checkInternet = await Utils.checkInternet();
        if (checkInternet) {
          locator<DialogService>().showLoader();

          if (mapAddress != null) {
            var res = await ufnRepo.validateIdentity(
                userId: user.STUSER!.ID!,
                sessionId: user.STCONFIG!.SAPPSESSIONID!,
                macAddress: user.STUSER!.MACADRESS!,
                country: mapAddress['country'],
                locality: mapAddress['locality'],
                street: mapAddress['buildingnumber'],
                address_1: mapAddress['buildingnumber'],
                buildingname: mapAddress['buildingnumber'],
                postCode: mapAddress['buildingnumber'],
                address_2: mapAddress['buildingnumber'],
                buildingnumber: mapAddress['buildingnumber'],
                province: mapAddress['province']);
            if (res.isSuccess) {
              locator<DialogService>().hideLoader();
              Navigator.push(
                  event.context,
                  MaterialPageRoute(
                      builder: (context) => IdentityCheckScreenHt(
                            revpidentityarray: res.data.revpidentityarray ?? [],
                          )));
            } else {
              locator<DialogService>().hideLoader();
              locator<ToastService>()
                  .showValidationMessage(event.context!, res.error);
            }
          }
        } else {
          locator<DialogService>().hideLoader();
          locator<ToastService>()
              .showValidationMessage(event.context!, "Internet not available");
        }
      } catch (e) {
        locator<DialogService>().hideLoader();
      }
    } else if (event is AddressUfnIdentityCheck) {
      try {
        bool checkInternet = await Utils.checkInternet();
        if (checkInternet) {
          locator<DialogService>().showLoader();

          if (mapAddress != null) {
            var res = await ufnRepo.validateIdentity(
                userId: user.STUSER!.ID!,
                sessionId: user.STCONFIG!.SAPPSESSIONID!,
                macAddress: user.STUSER!.MACADRESS!,
                country: mapAddress['country'],
                locality: mapAddress['locality'],
                street: mapAddress['buildingnumber'],
                address_1: mapAddress['buildingnumber'],
                buildingname: mapAddress['buildingnumber'],
                postCode: mapAddress['buildingnumber'],
                address_2: mapAddress['buildingnumber'],
                buildingnumber: mapAddress['buildingnumber'],
                province: mapAddress['province']);
            if (res.isSuccess) {
              locator<DialogService>().hideLoader();
              Navigator.push(
                  event.context,
                  MaterialPageRoute(
                      builder: (context) => IdentityCheckScreen(
                            revpidentityarray: res.data.revpidentityarray ?? [],
                          )));
            } else {
              locator<DialogService>().hideLoader();
              locator<ToastService>()
                  .showValidationMessage(event.context!, res.error);
            }
          }
        } else {
          locator<DialogService>().hideLoader();
          locator<ToastService>()
              .showValidationMessage(event.context!, "Internet not available");
        }
      } catch (e) {
        locator<DialogService>().hideLoader();
      }
    } else if (event is AddressTestIdentityCheck2) {
      try {
        bool checkInternet = await Utils.checkInternet();
        if (checkInternet) {
          locator<DialogService>().showLoader();

          if (mapAddress != null) {
            var res = await ufnRepo.validateIdentity(
                userId: user.STUSER!.ID!,
                sessionId: user.STCONFIG!.SAPPSESSIONID!,
                macAddress: user.STUSER!.MACADRESS!,
                country: mapAddress['country'],
                locality: mapAddress['locality'],
                street: mapAddress['buildingnumber'],
                address_1: mapAddress['buildingnumber'],
                buildingname: mapAddress['buildingnumber'],
                postCode: mapAddress['buildingnumber'],
                address_2: mapAddress['buildingnumber'],
                buildingnumber: mapAddress['buildingnumber'],
                province: mapAddress['province']);
            if (res.isSuccess) {
              locator<DialogService>().hideLoader();
              Navigator.push(
                  event.context,
                  MaterialPageRoute(
                      builder: (context) => TestIdentityCheckScreen(
                            revpidentityarray: res.data.revpidentityarray ?? [],
                          )));
            } else {
              locator<DialogService>().hideLoader();
              locator<ToastService>()
                  .showValidationMessage(event.context!, res.error);
            }
          }
        } else {
          locator<DialogService>().hideLoader();
          locator<ToastService>()
              .showValidationMessage(event.context!, "Internet not available");
        }
      } catch (e) {
        locator<DialogService>().hideLoader();
      }
    }
    else if (event is AddressPfnSaveCaseNumber) {
      caseNumber = event.caseNumber;

    }
  }
}

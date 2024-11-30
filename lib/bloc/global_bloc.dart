import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/common/Utils/utils.dart';
import 'package:railpaytro/common/service/toast_service.dart';
import 'package:railpaytro/data/model/Affected_toc_Model.dart';
import 'package:railpaytro/data/model/Issuing_History_Model.dart';
import 'package:railpaytro/data/model/issuing_history_IR.dart';
import 'package:railpaytro/data/model/revpirDetailMode.dart';
import 'package:railpaytro/data/repo/base/global_repo.dart';
import 'package:railpaytro/data/repo/issuing_history_repo.dart';
import '../Ui/Utils/HelpfullMethods.dart';
import '../common/locator/locator.dart';
import '../common/service/dialog_service.dart';
import '../constants/app_utils.dart';
import '../data/local/sqlite.dart';
import '../data/model/auth/cms_variables_model.dart';
import '../data/model/auth/login_model.dart';
import '../data/model/car_parking_penalty/case_reference_model.dart';
import '../data/model/car_parking_penalty/location_car_park.dart';
import '../data/model/case_detail_model.dart' as cd;
import '../data/model/case_details_print_model.dart' as fd;
import '../data/model/lookup_model.dart';
import '../data/model/print_template_ditales.dart';
import '../data/model/station/revp_station_model.dart';
import '../data/model/station/station_list_model.dart';
import '../data/model/ufn/revp_card_type.dart';
import '../data/repo/auth_repo.dart';
import '../data/repo/base/on_train_repo.dart';
import '../data/repo/base/station_repo.dart';
import '../data/repo/car_parking_penalty_repo.dart';
import '../data/repo/ufn_repo.dart';

class GlobalEvent {}

class GlobalSetStationEvent extends GlobalEvent {
  String stationName;
  String type;

  GlobalSetStationEvent(this.stationName, this.type);
}

class GlobalInsertCMSVariableDataEvent extends GlobalEvent {
  GlobalInsertCMSVariableDataEvent();
}

class GlobalInsertOfflineDataEvent extends GlobalEvent {
  GlobalInsertOfflineDataEvent();
}

class GlobalCheckInternetStatusEvent extends GlobalEvent {
  bool isInternetAvailable;

  GlobalCheckInternetStatusEvent(this.isInternetAvailable);
}

class GlobalGetPrinterCommand extends GlobalEvent {
  String type;

  GlobalGetPrinterCommand(this.type);
}

class GlobalGetCMSVariableData extends GlobalEvent {
  GlobalGetCMSVariableData();
}

class GlobalCheckUserSessionStatusEvent extends GlobalEvent {
  GlobalCheckUserSessionStatusEvent();
}

class GlobalGetLoginData extends GlobalEvent {
  GlobalGetLoginData();
}

class GlobalGetCommonDataBaseDataEvent extends GlobalEvent {
  GlobalGetCommonDataBaseDataEvent();
}

class GlobalState {}

class GlobalInitialState extends GlobalState {}

class GlobalLoadingState extends GlobalState {}

class GlobalSuccessState extends GlobalState {
  GlobalSuccessState();
}

class GlobalCommonDataInsertedState extends GlobalState {
  GlobalCommonDataInsertedState();
}

class GlobalCommonDataFetchedState extends GlobalState {
  GlobalCommonDataFetchedState();
}

class GlobalCMSDataFetchedState extends GlobalState {
  GlobalCMSDataFetchedState();
}

class GlobalSelectStationState extends GlobalState {
  String type;
  String station;

  GlobalSelectStationState(this.station, this.type);
}

class GlobalErrorState extends GlobalState {
  GlobalErrorState();
}

class GlobalCheckStatusState extends GlobalState {
  GlobalCheckStatusState();
}

class GlobalCheckStatusOfflineState extends GlobalState {
  GlobalCheckStatusOfflineState();
}

class GlobalLoaderState extends GlobalState {
  GlobalLoaderState();
}

class GlobalPrinterTemplateState extends GlobalState {
  String printerTemplate;

  GlobalPrinterTemplateState(this.printerTemplate);
}

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalRepo _globalRepo;
  AuthRepo _authRepo;
  StationRepo _stationRepo;
  OnTrainRepo _onTrainRepo;
  UfnRepo _ufnRepo;
  CarParkingPenaltyRepo _carParkingPenaltyRepo;
  IssuingHistoryRepo _issuing_history_repo;
  CMSVARIABLESBean? cmsVariable;
  LoginModel? loginModel;
  List<ASTATIONBean?> stationList = [];
  List<AREVPSTATIONBean?> revpStationList = [];
  List<PRINTTEMPLATEBean?> printTemplateList = [];
  List<REVPREFERENCESARRAYBean?> revpReferenceArray = [];
  List<REVPTOCLISTARRAY?> revpAffectedTOCLIST = [];
  List<REVPIRDETAILSARRAY?> revpirDetailLIST = [];
  List<STCASEDETAILS?> issuingHistoryList = [];
  List<STCASEDETAILS_IR?> issuingHistoryListIR = [];
  List<cd.STCASEDETAILS?> caseDetailsList = [];
  List<fd.STCASEDETAILSPRINT?> caseDetailsPrintList = [];
  LookupModel? lookupModel;

  // List<REVPPARKINGLOCATIONSARRAYBean?> carparklocationlistmodel = [];
  List<REVPRAILCARDTYPEARRAYBean?> revpCardTypeList = [];

  GlobalBloc(
      this._globalRepo,
      this._authRepo,
      this._stationRepo,
      this._onTrainRepo,
      this._ufnRepo,
      this._carParkingPenaltyRepo,
      this._issuing_history_repo)
      : super(GlobalInitialState());

  @override
  Stream<GlobalState> mapEventToState(GlobalEvent event) async* {
    if (event is GlobalSetStationEvent) {
      yield GlobalSelectStationState(event.stationName, event.type);
    }
    if (event is GlobalCheckUserSessionStatusEvent) {
      bool checkInternet = await Utils.checkInternet();
      if (checkInternet) {
        try {
          LoginModel user = await SqliteDB.instance.getLoginModelData();
          final res = await _authRepo.checkUserSessionStatus(
              ssessionId: user.STCONFIG!.SAPPSESSIONID.toString(),
              userID: user.STUSER!.ID!,
              macAddress: user.STUSER!.MACADRESS!);
          if (res.isSuccess &&
              res.data["SESSIONSTATUS"].toString().contains("InActive")) {
            AppUtils().logoutUser();
            yield GlobalCheckStatusState();
          } else {
            yield GlobalCheckStatusOfflineState();
          }
        } catch (e) {
          AppUtils().logoutUser();
          yield GlobalCheckStatusState();
        }
      } else {
        yield GlobalCheckStatusOfflineState();
      }
    } else if (event is GlobalInsertCMSVariableDataEvent) {
      try {
        final res = await _authRepo.getVariablesSettings();
        if (res.isSuccess) {
          await SqliteDB.instance.insertCMSVariable(res.data.CMSVARIABLES!);
          yield GlobalCMSDataFetchedState();
        } else {
          locator<ToastService>()
              .showLong("Unable to save CMS variable data into DB");
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        locator<ToastService>()
            .showLong("Unable to save CMS variable data into DB");
      }
    } else if (event is GlobalInsertOfflineDataEvent) {
      locator<DialogService>().showLoader(
          dismissable: false, message: "Checking for updates. Please wait.");
      LoginModel user = await SqliteDB.instance.getLoginModelData();
      var id = await getId();
      try {
        final response = await Future.wait([
          _globalRepo.getPrintTemplateDataList(
              ssessionId: user.STCONFIG!.SAPPSESSIONID!,
              userID: user.STUSER!.ID!,
              macAddress: id!),
          _stationRepo.getStationList(
              ssessionId: user.STCONFIG!.SAPPSESSIONID.toString(),
              userID: user.STUSER!.ID!,
              macAddress: user.STUSER!.MACADRESS!),
          _stationRepo.getRevpStationList(
              ssessionId: user.STCONFIG!.SAPPSESSIONID.toString(),
              userID: user.STUSER!.ID!,
              macAddress: user.STUSER!.MACADRESS!),
          _carParkingPenaltyRepo.getRevpCaseReferences(
              sessionId: user.STCONFIG!.SAPPSESSIONID!,
              macAddress: id!,
              userID: user.STUSER!.ID!,
              username: user.STUSER!.SUSERNAME!),
          _globalRepo.getLookUpData(
            userID: user.STUSER!.ID!,
            macAddress: user.STUSER!.MACADRESS!,
            sessionId: user.STCONFIG!.SAPPSESSIONID.toString(),
          ),
          _stationRepo.getParkingLocationList(
              ssessionId: user.STCONFIG!.SAPPSESSIONID.toString(),
              userID: user.STUSER!.ID!,
              macAddress: user.STUSER!.MACADRESS!),
          _ufnRepo.getRevpCardType(
              macAddress: user.STUSER!.MACADRESS!,
              sessionId: user.STCONFIG!.SAPPSESSIONID.toString(),
              userId: user.STUSER!.ID!),
          _carParkingPenaltyRepo.revpListAffectedTOC(
              sessionId: user.STCONFIG!.SAPPSESSIONID!,
              macAddress: id!,
              userID: user.STUSER!.ID!),
          _carParkingPenaltyRepo.getRevpirDetails(
              sessionId: user.STCONFIG!.SAPPSESSIONID!,
              macAddress: id!,
              userID: user.STUSER!.ID!,
              username: user.STUSER!.SUSERNAME!),
          _issuing_history_repo.getIssuingHistoryList(
              sessionId: user.STCONFIG!.SAPPSESSIONID!,
              macAddress: id!,
              userID: user.STUSER!.ID!),
          _issuing_history_repo.getIssuingHistoryListIR(
              sessionId: user.STCONFIG!.SAPPSESSIONID!,
              macAddress: id!,
              userID: user.STUSER!.ID!),
          _authRepo.getCases(
            reload: 1,
            userID: user.STUSER!.ID!,
            ssessionId: user.STCONFIG!.SAPPSESSIONID!,
          ),
          _authRepo.getPrintCases(
            reload: 1,
            userID: user.STUSER!.ID!,
            ssessionId: user.STCONFIG!.SAPPSESSIONID!,
          ),
        ]);
        callApi();
        callApiprint();
        PrintTemplateDitales printTemplateDitales =
            response[0].data as PrintTemplateDitales;

        StationListModel stationListModel =
            response[1].data as StationListModel;

        RevpStationModel revpStationModel =
            response[2].data as RevpStationModel;

        CaseReferenceModel caseReferenceModel =
            response[3].data as CaseReferenceModel;

        List<REVPREFERENCESARRAYBean>? list = [];
        list = caseReferenceModel.REVPREFERENCESARRAY ?? [];
        LookupModel lookupModel = response[4].data as LookupModel;
        Carparklocationmodel carparklocationmodel =
            response[5].data as Carparklocationmodel;
        RevpCardType revpCardType = response[6].data as RevpCardType;
        affectedTOC affectedtoc = response[7].data as affectedTOC;
        revpirDetailsModel revpirDetailModel =
            response[8].data as revpirDetailsModel;
        Issuing_History issuing_historyModel =
            response[9].data as Issuing_History;
        IssuingHistoryIRModel issuing_historyIR =
            response[10].data as IssuingHistoryIRModel;
        cd.StCaseDetails caseDetails = response[11].data as cd.StCaseDetails;
        fd.StCaseDetailsPrint caseDetailsPrintList =
            response[12].data as fd.StCaseDetailsPrint;

        await Future.wait([
          SqliteDB.instance.insertPrintTemplateDataList(
              printTemplateDitales.PRINTTEMPLATE ?? []),
          SqliteDB.instance.insertStationList(stationListModel.ASTATION ?? []),
          SqliteDB.instance
              .insertRevpStationList(revpStationModel.ASTATION ?? []),
          SqliteDB.instance.insertReferenceList(list),
          SqliteDB.instance.insertLookUpData(lookupModel),
          SqliteDB.instance.insertCarParkingList(
              carparklocationmodel.REVPPARKINGLOCATIONSARRAY ?? []),
          SqliteDB.instance
              .insertCarTypeList(revpCardType.REVPRAILCARDTYPEARRAY ?? []),
          SqliteDB.instance
              .insertAffectedList(affectedtoc.rEVPTOCLISTARRAY ?? []),
          SqliteDB.instance
              .insertRevpirDetail(revpirDetailModel.rEVPIRDETAILSARRAY ?? []),
          SqliteDB.instance
              .insertIssuingHistory(issuing_historyModel.sTCASEDETAILS ?? []),
          SqliteDB.instance
              .insertIssuingHistoryIR(issuing_historyIR.sTCASEDETAILS_IR ?? []),
          SqliteDB.instance
              .insertCaseDetailList(caseDetails.sTCASEDETAILS ?? []),
          SqliteDB.instance.insertCaseDetailPrintList(
              caseDetailsPrintList.sTCASEDETAILSPRINT ?? []),
        ]);

        AppUtils().setOfflineDataGet(true);
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        AppUtils().setOfflineDataGet(false);
      }

      locator<DialogService>().hideLoader();
      yield GlobalCommonDataInsertedState();
    }
    /*
    * Get Data
    * */
    else if (event is GlobalGetPrinterCommand) {
      printTemplateList =
          await SqliteDB.instance.getPrintTemplateDataList(event.type);
      yield GlobalPrinterTemplateState(printTemplateList[0]?.CONTENTS ?? "");
    } else if (event is GlobalGetCMSVariableData) {
      cmsVariable = await SqliteDB.instance.getCMSVariableList();
    } else if (event is GlobalGetLoginData) {
      loginModel = await SqliteDB.instance.getLoginModelData();
    } else if (event is GlobalGetCommonDataBaseDataEvent) {
      try {
        stationList = await SqliteDB.instance.getStationList();
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        locator<ToastService>()
            .showLong("Unable to fetch station list from DB");
      }
      try {
        revpStationList = await SqliteDB.instance.getRevpStationList("LOGON");
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        locator<ToastService>()
            .showLong("Unable to fetch Revp Station list from DB");
      }
      try {
        revpReferenceArray = await SqliteDB.instance.getReferenceList();
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        locator<ToastService>()
            .showLong("Unable to fetch reference list list from DB");
      }
      try {
        revpAffectedTOCLIST = await SqliteDB.instance.getTOCList();
      } catch (e) {
        locator<ToastService>().showLong(e.toString());
        if (kDebugMode) {
          print(e.toString());
        }
        locator<ToastService>().showLong("Unable to fetch TOC List from DB");
      }
      try {
        issuingHistoryList = await SqliteDB.instance.getIssuingHistory();
      } catch (e) {
        locator<ToastService>().showLong(e.toString());
        if (kDebugMode) {
          print(e.toString());
        }
        locator<ToastService>()
            .showLong("Unable to fetch Issuing History list from DB");
      }
      try {
        issuingHistoryListIR = await SqliteDB.instance.getIssuingHistoryIR();
      } catch (e) {
        locator<ToastService>().showLong(e.toString());
        if (kDebugMode) {
          print(e.toString());
        }
        locator<ToastService>()
            .showLong("Unable to fetch IR Report History list from DB");
      }
      try {
        revpirDetailLIST = await SqliteDB.instance.gerevpirDetail();
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        locator<ToastService>()
            .showLong("Unable to fetch reference list list from DB999");
      }
      try {
        lookupModel = await SqliteDB.instance.getLookUpData();
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        locator<ToastService>().showLong("Unable to fetch lookup data from DB");
      }
      try {
        caseDetailsList = await SqliteDB.instance.getCaseDetails();
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        locator<ToastService>().showLong("Unable to fetch case data from DB");
      }
      try {
        caseDetailsPrintList = await SqliteDB.instance.getCaseDetailsPrint();
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        locator<ToastService>().showLong("Unable to fetch case print data");
      }
      try {
        revpCardTypeList = await SqliteDB.instance.getCarTypeList();
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        locator<ToastService>()
            .showLong("Unable to fetch car type list data from DB");
      }
      yield GlobalCommonDataFetchedState();
    }
  }

  callApi() async {
    LoginModel user = await SqliteDB.instance.getLoginModelData();
    try {
      var apa = _authRepo.getCases(
        reload: 1,
        userID: user.STUSER!.ID!,
        ssessionId: user.STCONFIG!.SAPPSESSIONID!,
      );
      print(apa);
    } catch (e) {
      print(e);
    }
  }

  callApiprint() async {
    LoginModel user = await SqliteDB.instance.getLoginModelData();
    try {
      var apa = _authRepo.getPrintCases(
        reload: 1,
        userID: user.STUSER!.ID!,
        ssessionId: user.STCONFIG!.SAPPSESSIONID!,
      );
      print(apa);
    } catch (e) {
      print(e);
    }
  }
}

// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';

import 'package:railpaytro/data/constantes/db_constants.dart';
import 'package:railpaytro/data/local/database_helper.dart';
import 'package:railpaytro/data/model/Affected_toc_Model.dart';
import 'package:railpaytro/data/model/lookup_model.dart';
import 'package:railpaytro/data/model/revpirDetailMode.dart';
import 'package:railpaytro/data/model/station/revp_station_model.dart';
import 'package:sqflite/sqflite.dart';

import '../model/Issuing_History_Model.dart';
import '../model/auth/cms_variables_model.dart';
import '../model/auth/login_model.dart';
import '../model/car_parking_penalty/case_reference_model.dart';
import '../model/car_parking_penalty/location_car_park.dart';
import '../model/case_detail_model.dart' as caseDetails;
import '../model/case_details_print_model.dart' as caseprintDetails;
import '../model/issuing_history_IR.dart';
import '../model/print_template_ditales.dart';
import '../model/station/station_list_model.dart';
import '../model/ufn/revp_card_type.dart';
import '../offline/auth_offline/auth_offline_status.dart';

class SqliteDB {
  SqliteDB._privateConstructor();

  static final SqliteDB instance = SqliteDB._privateConstructor();

  static late Database _database;

  Future<Database> get database async {
    _database = await DatabaseHelper.initDatabase();
    return _database;
  }

  Future<void> insertCMSVariable(CMSVARIABLESBean cmsVariable) async {
    Database? db = await SqliteDB.instance.database;
    final map = {
      DBConstants.CL_CMS_VARIABLE_DATA: jsonEncode(cmsVariable),
    };
    db.insert(DBConstants.TB_CMS_VARIABLES_LIST, map);
  }

  Future<CMSVARIABLESBean?> getCMSVariableList() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results =
        await db.query(DBConstants.TB_CMS_VARIABLES_LIST);
    if (results.isNotEmpty) {
      CMSVARIABLESBean data = CMSVARIABLESBean.fromJson(
          jsonDecode(results[0][DBConstants.CL_CMS_VARIABLE_DATA]));
      return data;
    } else {
      return null;
    }
  }

  Future<void> insertLoginModel(LoginModel login) async {
    Database db = await instance.database;
    await cleanSingleTable(DBConstants.TB_LOGIN_LIST);
    final map = {
      DBConstants.CL_VARIABLE_DATA: jsonEncode(login),
    };
    db.insert(DBConstants.TB_LOGIN_LIST, map);
  }

  getLoginModelData() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results =
        await db.query(DBConstants.TB_LOGIN_LIST);
    if (results.isNotEmpty) {
      LoginModel data = LoginModel.fromJson(
          jsonDecode(results[0][DBConstants.CL_VARIABLE_DATA]));
      return data;
    } else {
      return null;
    }
  }

  Future<void> insertStationList(List<ASTATIONBean?> list) async {
    Database db = await instance.database;
    await cleanSingleTable(DBConstants.TB_LIST_LOOK_UP_DATA);
    await Future.forEach(list, (dynamic element) async {
      ASTATIONBean astationBean = element as ASTATIONBean;
      final map = {
        DBConstants.CL_CODE: astationBean.code ?? '',
        DBConstants.CL_VALUE: astationBean.value ?? '',
        DBConstants.CL_TOC: astationBean.toc ?? '',
      };
      await db.insert(DBConstants.TB_GOG_STATION_LIST, map);
    });
  }

  Future<List<ASTATIONBean?>> getStationList() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results =
        await db.query(DBConstants.TB_GOG_STATION_LIST);
    List<ASTATIONBean?> list = [];
    await Future.forEach(results, (dynamic element) {
      list.add(ASTATIONBean(
          code: element[DBConstants.CL_CODE] ?? "",
          toc: element[DBConstants.CL_TOC] ?? "",
          value: element[DBConstants.CL_VALUE] ?? " "));
    });
    return list;
  }

  Future<void> insertRevpStationList(List<AREVPSTATIONBean?> list) async {
    Database db = await instance.database;
    await cleanSingleTable(DBConstants.TB_REVP_STATION_LIST);
    await Future.forEach(list, (var element) async {
      AREVPSTATIONBean arevpstationBean = element as AREVPSTATIONBean;
      final map = {
        DBConstants.CL_STATION_NAME: arevpstationBean.STATION_NAME ?? '',
        DBConstants.CL_ORDER:
            int.tryParse((arevpstationBean.ORDER).toString()) ?? 0,
        DBConstants.CL_CRS_CODE: arevpstationBean.CRS_CODE ?? '',
        DBConstants.CL_CASETYPES: arevpstationBean.CASETYPES ?? '',
        DBConstants.CL_NLC_CODE: arevpstationBean.NLC_CODE ?? ''
      };
      await db.insert(DBConstants.TB_REVP_STATION_LIST, map);
    });
  }

  Future<List<AREVPSTATIONBean?>> getRevpStationList(String caseType) async {
    Database db = await instance.database;
/*    List<Map<String, dynamic>> whereEqualResults =
        await db.query(DBConstants.TB_REVP_STATION_LIST,
          where:  "${DBConstants.CL_CASETYPES} = ?",
          whereArgs: [caseType] , orderBy: "${DBConstants.CL_ORDER} ASC"  );*/
    List<Map<String, dynamic>> whereLikeResults = await db.query(
        DBConstants.TB_REVP_STATION_LIST,
        where: "${DBConstants.CL_CASETYPES} LIKE ?",
        whereArgs: ['%$caseType%'],
        orderBy: "${DBConstants.CL_ORDER} ASC");
    List<AREVPSTATIONBean?> list = [];
/*    List<Map<String, dynamic>> results = [];
    results.addAll(whereEqualResults);
    results.addAll(whereLikeResults);
    results.toSet().toList();*/

    await Future.forEach(whereLikeResults, (dynamic element) {
      list.add(AREVPSTATIONBean(
          CASETYPES: element[DBConstants.CL_CASETYPES] ?? "",
          CRS_CODE: element[DBConstants.CL_CRS_CODE] ?? "",
          NLC_CODE: element[DBConstants.CL_NLC_CODE] ?? "",
          ORDER: element[DBConstants.CL_ORDER],
          STATION_NAME: element[DBConstants.CL_STATION_NAME] ?? ""));
    });
    return list;
  }

  Future<void> insertPrintTemplateDataList(
      List<PRINTTEMPLATEBean?> list) async {
    Database db = await instance.database;
    await cleanSingleTable(DBConstants.TB_PRINT_TEMPLATE_DATA_LIST);
    await Future.forEach(list, (var element) async {
      PRINTTEMPLATEBean printtemplateBean = element as PRINTTEMPLATEBean;
      final map = {
        DBConstants.CL_ACTIVE: printtemplateBean.ACTIVE ?? '',
        DBConstants.CL_CONTENTS: printtemplateBean.CONTENTS ?? '',
        DBConstants.CL_TITLE: printtemplateBean.TITLE ?? '',
        DBConstants.CL_CASETYPES: printtemplateBean.CASETYPE ?? '',
      };
      await db.insert(DBConstants.TB_PRINT_TEMPLATE_DATA_LIST, map);
    });
  }

  Future<List<PRINTTEMPLATEBean?>> getPrintTemplateDataList(
      String casetype) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query(
        DBConstants.TB_PRINT_TEMPLATE_DATA_LIST,
        where: '${DBConstants.CL_CASETYPES} = ?',
        whereArgs: [casetype],
        limit: 1);
    List<PRINTTEMPLATEBean?> list = [];
    await Future.forEach(results, (dynamic results) {
      list.add(PRINTTEMPLATEBean(
          ACTIVE: results[DBConstants.CL_ACTIVE],
          CASETYPE: results[DBConstants.CL_CASETYPES],
          CONTENTS: results[DBConstants.CL_CONTENTS],
          TITLE: results[DBConstants.CL_TITLE]));
    });
    return list;
  }

  Future<void> insertReferenceList(List<REVPREFERENCESARRAYBean?> list) async {
    Database db = await instance.database;
    await cleanSingleTable(DBConstants.TB_CASE_REFRENCE);
    await Future.forEach(list, (var element) async {
      REVPREFERENCESARRAYBean e = element as REVPREFERENCESARRAYBean;
      final map = {
        DBConstants.CL_ISLOCKED: e.ISLOCKED.toString(),
        DBConstants.CL_ISUSED: e.ISUSED.toString(),
        DBConstants.CL_CASE_REFERENCE_NO: e.CASE_REFERENCE_NO ?? '',
      };
      await db.insert(DBConstants.TB_CASE_REFRENCE, map);
    });
  }

  Future<List<REVPREFERENCESARRAYBean?>> getReferenceList() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results =
        await db.query(DBConstants.TB_CASE_REFRENCE);
    List<REVPREFERENCESARRAYBean?> list = [];
    await Future.forEach(results, (dynamic element) {
      list.add(REVPREFERENCESARRAYBean(
        CASE_REFERENCE_NO: element[DBConstants.CL_CASE_REFERENCE_NO],
        ISLOCKED: int.parse(element[DBConstants.CL_ISLOCKED]),
        ISUSED: int.parse(element[DBConstants.CL_ISUSED]),
      ));
    });
    return list;
  }

  Future<void> insertCarTypeList(List<REVPRAILCARDTYPEARRAYBean?> list) async {
    Database db = await instance.database;
    await cleanSingleTable(DBConstants.TB_CAR_TYPE_LIST);
    await Future.forEach(list, (var element) async {
      REVPRAILCARDTYPEARRAYBean e = element as REVPRAILCARDTYPEARRAYBean;
      final map = {
        DBConstants.CL_REVP_RAIL_CARD: e.revpRailcard,
        DBConstants.CL_REVP_RAIL_CARD_ID: e.revpRailcardID,
        DBConstants.CL_REVP_RAIL_CARD_TYPE_ID: e.revpRailCardTypeID,
        DBConstants.CL_REVP_RAIL_CARD_TYPE: e.revpRailCardType
      };
      await db.insert(DBConstants.TB_CAR_TYPE_LIST, map);
    });
  }

  Future<void> insertAffectedList(List<REVPTOCLISTARRAY?> list) async {
    Database db = await instance.database;
    await cleanSingleTable(DBConstants.TB_AFFECTED_TOC_LIST);
    await Future.forEach(list, (var element) async {
      REVPTOCLISTARRAY e = element as REVPTOCLISTARRAY;
      final map = {
        DBConstants.CL_TOC_NAME: e.tocName,
      };
      await db.insert(DBConstants.TB_AFFECTED_TOC_LIST, map);
    });
  }

  Future<void> insertRevpirDetail(List<REVPIRDETAILSARRAY?> list) async {
    Database db = await instance.database;
    await cleanSingleTable(DBConstants.TB_RevpirDetail);
    await Future.forEach(list, (var element) async {
      REVPIRDETAILSARRAY e = element as REVPIRDETAILSARRAY;
      final map = {
        DBConstants.CL_EMAILADDRESS: e.emailAddress,
        DBConstants.CL_PRECONFERMATIONMESSAGE: e.preConfermationMessage,
        DBConstants.CL_CONFERMATIONMESSAGE: e.confermationMessage,
        DBConstants.CL_tOCID: e.tOCID,
        DBConstants.CL_IDD: e.iD
      };
      await db.insert(DBConstants.TB_RevpirDetail, map);
    });
  }

  Future<void> insertIssuingHistory(List<STCASEDETAILS?> list) async {
    Database db = await instance.database;
    await cleanSingleTable(DBConstants.TB_IssuingHistory);
    await Future.forEach(list, (var element) async {
      STCASEDETAILS e = element as STCASEDETAILS;
      final map = {
        DBConstants.CL_cREATEDDT: e.cREATEDDT,
        DBConstants.CL_cASECREATEDTIMEDIFF: e.cASECREATEDTIMEDIFF.toString(),
        DBConstants.CL_cASEACTION: e.cASEACTION,
        DBConstants.CL_sTATUSDESC: e.sTATUSDESC,
        DBConstants.CL_cASEID: e.cASEID,
        DBConstants.CL_cASETYPE: e.cASETYPE,
        DBConstants.CL_cREATEDTIME: e.cREATEDTIME,
        DBConstants.CL_cASENUM: e.cASENUM
      };
      await db.insert(DBConstants.TB_IssuingHistory, map);
    });
  }

  Future<void> insertIssuingHistoryIR(List<STCASEDETAILS_IR?> list) async {
    Database db = await instance.database;
    await cleanSingleTable(DBConstants.TB_IssuingHistoryIR);
    await Future.forEach(list, (var element) async {
      STCASEDETAILS_IR e = element as STCASEDETAILS_IR;
      final map = {
        DBConstants.CL_cREATEDDT_IR: e.cREATEDDT,
        DBConstants.CL_cASECREATEDTIMEDIFF_IR: e.cASECREATEDTIMEDIFF.toString(),
        DBConstants.CL_cASEACTION_IR: e.cASEACTION,
        DBConstants.CL_REPORT_IR: e.pEPORT,
        DBConstants.CL_cASEID_IR: e.cASEID,
        DBConstants.CL_cREATEDTIME_IR: e.cREATEDTIME,
        DBConstants.CL_cASENUM_IR: e.cASENUM
      };
      await db.insert(DBConstants.TB_IssuingHistoryIR, map);
    });
  }

  Future<void> insertCaseDetailList(
      List<caseDetails.STCASEDETAILS> list) async {
    Database db = await instance.database;
    await cleanSingleTable(DBConstants.TB_CASE_DETAILS_LIST);
    await Future.forEach(list, (var element) async {
      caseDetails.STCASEDETAILS e = element as caseDetails.STCASEDETAILS;
      final map = {
        DBConstants.CL_CASETYPEID: e.cASETYPEID,
        DBConstants.CL_CASETYPECODE: e.cASETYPECODE.toString(),
        DBConstants.CL_ENABLESTATTUS: e.eNABLESTATTUS
      };
      await db.insert(DBConstants.TB_CASE_DETAILS_LIST, map);
    });
  }

  Future<List<caseDetails.STCASEDETAILS?>> getCaseDetails() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results =
        await db.query(DBConstants.TB_CASE_DETAILS_LIST);
    List<caseDetails.STCASEDETAILS?> list = [];
    await Future.forEach(results, (dynamic element) {
      list.add(caseDetails.STCASEDETAILS?.fromJson(element));
    });
    return list;
  }

  Future<List<STCASEDETAILS?>> getIssuingHistory() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results =
        await db.query(DBConstants.TB_IssuingHistory);
    List<STCASEDETAILS?> list = [];
    await Future.forEach(results, (dynamic element) {
      list.add(STCASEDETAILS?.fromJson(element));
    });
    return list;
  }

  Future<List<STCASEDETAILS_IR?>> getIssuingHistoryIR() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results =
        await db.query(DBConstants.TB_IssuingHistoryIR);
    List<STCASEDETAILS_IR?> list = [];
    await Future.forEach(results, (dynamic element) {
      list.add(STCASEDETAILS_IR?.fromJson(element));
    });
    return list;
  }

  Future<List<REVPIRDETAILSARRAY?>> gerevpirDetail() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results =
        await db.query(DBConstants.TB_RevpirDetail);
    List<REVPIRDETAILSARRAY?> list = [];
    await Future.forEach(results, (dynamic element) {
      list.add(REVPIRDETAILSARRAY.fromJson(element));
    });
    return list;
  }

  Future<List<REVPTOCLISTARRAY?>> getTOCList() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results =
        await db.query(DBConstants.TB_AFFECTED_TOC_LIST);
    List<REVPTOCLISTARRAY?> list = [];
    await Future.forEach(results, (dynamic element) {
      list.add(REVPTOCLISTARRAY.fromJson(element));
    });
    return list;
  }

  Future<void> insertLookUpData(LookupModel lookUp) async {
    Database db = await instance.database;
    final map = {
      DBConstants.CL_LOOK_UP_DATA: jsonEncode(lookUp),
    };
    await cleanSingleTable(DBConstants.TB_LIST_LOOK_UP_DATA);
    await db.insert(DBConstants.TB_LIST_LOOK_UP_DATA, map);
  }

  Future<LookupModel> getLookUpData() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results =
        await db.query(DBConstants.TB_LIST_LOOK_UP_DATA);
    LookupModel data = LookupModel.fromJson(
        jsonDecode(results[0][DBConstants.CL_LOOK_UP_DATA]));
    return data;
  }

  Future<void> insertAPIRequestData(Map<String, dynamic> apiRequest) async {
    Database db = await instance.database;
    final map = {
      DBConstants.CL_API_REQUEST_ID: apiRequest["id"],
      DBConstants.CL_REQUEST_DATA: apiRequest["body"],
      DBConstants.CL_REQUEST_SECTION_NAME: apiRequest["request_section"],
      DBConstants.CL_REQUEST_SUB_SECTION_NAME:
          apiRequest["request_sub_section"],
    };
    await db.insert(DBConstants.TB_API_REQUEST, map);
  }

  Future<List<REVPRAILCARDTYPEARRAYBean?>> getCarTypeList() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results =
        await db.query(DBConstants.TB_CAR_TYPE_LIST);
    List<REVPRAILCARDTYPEARRAYBean?> list = [];
    await Future.forEach(results, (dynamic element) {
      list.add(REVPRAILCARDTYPEARRAYBean(
        revpRailCardType: element[DBConstants.CL_REVP_RAIL_CARD_TYPE],
        revpRailCardTypeID: element[DBConstants.CL_REVP_RAIL_CARD_TYPE_ID],
        revpRailcardID: element[DBConstants.CL_REVP_RAIL_CARD_ID],
        revpRailcard: element[DBConstants.CL_REVP_RAIL_CARD],
      ));
    });
    return list;
  }

  Future<void> insertCarParkingList(
      List<REVPPARKINGLOCATIONSARRAYBean?> list) async {
    Database db = await instance.database;
    await cleanSingleTable(DBConstants.TB_PARKING_LIST);
    await Future.forEach(list, (var element) async {
      REVPPARKINGLOCATIONSARRAYBean e =
          element as REVPPARKINGLOCATIONSARRAYBean;
      final map = {
        DBConstants.CL_CARPARK_LOCATION_ID: e.carpark_location_id,
        DBConstants.CL_LOCATION_NAME: e.location_name,
        DBConstants.CL_CARPARK_STATION_ID: e.station_id,
        DBConstants.CL_CARPARK_STATION_NAME: e.station_name,
        DBConstants.CL_CARPARK_ORDER: int.tryParse((e.order).toString()) ?? 0
      };
      await db.insert(DBConstants.TB_PARKING_LIST, map);
    });
  }

  Future<List<REVPPARKINGLOCATIONSARRAYBean?>> getCarParkingListList(
      String stationName) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query(
        DBConstants.TB_PARKING_LIST,
        where: "${DBConstants.CL_CARPARK_STATION_NAME} = ?",
        whereArgs: [stationName],
        orderBy: "${DBConstants.CL_CARPARK_ORDER} ASC");
    List<REVPPARKINGLOCATIONSARRAYBean?> list = [];
    await Future.forEach(results, (dynamic element) {
      list.add(REVPPARKINGLOCATIONSARRAYBean(
        location_name: element[DBConstants.CL_LOCATION_NAME],
        carpark_location_id: element[DBConstants.CL_CARPARK_LOCATION_ID],
        station_name: element[DBConstants.CL_CARPARK_STATION_NAME],
        station_id: element[DBConstants.CL_CARPARK_STATION_ID],
        order: element[DBConstants.CL_CARPARK_ORDER],
      ));
    });
    return list;
  }

  Future<void> updateCaseRef(String caseRef) async {
    Database db = await instance.database;
    await db.update(
        DBConstants.TB_CASE_REFRENCE,
        {
          DBConstants.CL_ISUSED: 1,
        },
        where: '${DBConstants.CL_CASE_REFERENCE_NO} = ?',
        whereArgs: [caseRef]);
  }

  Future<void> interruptRequestWhileSendingOfflineData(
      Map<String, dynamic> apiRequest) async {
    Database db = await instance.database;
    final map = {
      DBConstants.CL_API_REQUEST_ID: apiRequest["id"],
      DBConstants.CL_REQUEST_DATA: apiRequest["body"],
      DBConstants.CL_REQUEST_SECTION_NAME: apiRequest["request_section"],
    };
    await db.insert(DBConstants.TB_API_REQUEST, map);
  }

  Future<void> insertCaseDetailPrintList(
      List<caseprintDetails.STCASEDETAILSPRINT> list) async {
    Database db = await instance.database;
    await cleanSingleTable(DBConstants.TB_CASE_DETAILS_LIST_PRINT);
    await Future.forEach(list, (var element) async {
      caseprintDetails.STCASEDETAILSPRINT e =
          element as caseprintDetails.STCASEDETAILSPRINT;
      final map = {
        DBConstants.CL_CASETYPEID_PRINT: e.cASETYPEIDPRINT,
        DBConstants.CL_CASETYPECODE_PRINT: e.cASETYPECODEPRINT.toString(),
        DBConstants.CL_ENABLESTATTUS_PRINT: e.eNABLESTATTUSPRINT
      };
      await db.insert(DBConstants.TB_CASE_DETAILS_LIST_PRINT, map);
    });
  }

  Future<List<caseprintDetails.STCASEDETAILSPRINT?>>
      getCaseDetailsPrint() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results =
        await db.query(DBConstants.TB_CASE_DETAILS_LIST_PRINT);
    List<caseprintDetails.STCASEDETAILSPRINT?> list = [];
    await Future.forEach(results, (dynamic element) {
      list.add(caseprintDetails.STCASEDETAILSPRINT?.fromJson(element));
    });
    return list;
  }

  Future<List<Map<String, dynamic>>> getAPIRequestsData() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query(
        DBConstants.TB_API_REQUEST,
        orderBy: "${DBConstants.CL_API_REQUEST_SERIAL_ID} ASC");
    return results;
  }

  Future<int> deleteAPIRequestData({String? caseNum, String? subType}) async {
    Database db = await instance.database;
    dynamic results = await db.delete(DBConstants.TB_API_REQUEST,
        where:
            "${DBConstants.CL_API_REQUEST_ID} LIKE ? and ${DBConstants.CL_REQUEST_SUB_SECTION_NAME} = ?",
        whereArgs: ['%$caseNum%', subType]);
    return results;
  }

  Future<void> insertAPIImagesRequestData(
      String caseNum,
      dynamic apiRequest,
      String filePath,
      String imageType,
      String imageSection,
      String imageSubSection) async {
    Database db = await instance.database;
    final map = {
      DBConstants.CL_IMAGES_CASE_ID: caseNum,
      DBConstants.CL_IMAGES_DATA: apiRequest,
      DBConstants.CL_IMAGES_PATH: filePath,
      DBConstants.CL_IMAGES_TYPE: imageType,
      DBConstants.CL_IMAGES_SECTION: imageSection,
      DBConstants.CL_IMAGES_SUB_SECTION: imageSubSection,
    };
    await db.insert(DBConstants.TB_IMAGES_REQUEST, map);
  }

  Future<List<Map<String, dynamic>>> getImagesAPIRequestData(
      String caseNum) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query(
        DBConstants.TB_IMAGES_REQUEST,
        where: "${DBConstants.CL_IMAGES_CASE_ID} LIKE ?",
        whereArgs: ['%$caseNum%'],
        orderBy: "${DBConstants.CL_API_REQUEST_SERIAL_ID} ASC");
    return results;
  }

  Future<int> deleteImagesData(String caseNum) async {
    Database db = await instance.database;
    dynamic results = await db.delete(DBConstants.TB_IMAGES_REQUEST,
        where: "${DBConstants.CL_IMAGES_CASE_ID} LIKE ?",
        whereArgs: ['%$caseNum%']);
    return results;
  }

  Future<int> deleteSubSectionsImagesData(
      String caseNum, String subSection) async {
    Database db = await instance.database;
    dynamic results = await db.delete(DBConstants.TB_IMAGES_REQUEST,
        where:
            "${DBConstants.CL_IMAGES_CASE_ID} LIKE ? and ${DBConstants.CL_IMAGES_SUB_SECTION} = ?",
        whereArgs: ['%$caseNum%', subSection]);
    return results;
  }

  Future<void> deleteSingleTable(String tableName) async {
    Database db = await instance.database;
    await db.delete(tableName);
  }

  Future<void> cleanSingleTable(String tableName) async {
    Database db = await instance.database;
    await db.rawDelete("Delete from $tableName");
  }

  Future close() async {
    Database db = await instance.database;
    db.close();
  }
}

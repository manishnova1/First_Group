// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:railpaytro/data/constantes/db_constants.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<Database> initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DBConstants.DATABASE_NAME);
    // return openDatabase(join(await getDatabasesPath(), DBConstants.DATABASE_NAME),
    return openDatabase(path, onCreate: (db, version) {
      //Create Login table
      db.execute("CREATE TABLE ${DBConstants.TB_LOGIN_LIST}"
          "(${DBConstants.CL_VARIABLE_DATA} TEXT)");
      //Create CMS Variable table
      db.execute("CREATE TABLE ${DBConstants.TB_CMS_VARIABLES_LIST}"
          "(${DBConstants.CL_CMS_VARIABLE_KEY} TEXT, "
          "${DBConstants.CL_CMS_VARIABLE_DATA} TEXT)");
      db.execute("CREATE TABLE ${DBConstants.TB_PRINT_TEMPLATE_DATA_LIST}"
          "(${DBConstants.CL_ACTIVE} TEXT, "
          "${DBConstants.CL_CONTENTS} TEXT, "
          "${DBConstants.CL_TITLE} TEXT, "
          "${DBConstants.CL_CASETYPES} TEXT)");

      db.execute("CREATE TABLE ${DBConstants.TB_PARKING_LIST}"
          "(${DBConstants.CL_CARPARK_LOCATION_ID} TEXT, "
          "${DBConstants.CL_LOCATION_NAME}  INTEGER, "
          "${DBConstants.CL_CARPARK_STATION_ID} TEXT, "
          "${DBConstants.CL_CARPARK_STATION_NAME} TEXT, "
          "${DBConstants.CL_CARPARK_ORDER} INTEGER)");

      db.execute("CREATE TABLE ${DBConstants.TB_AFFECTED_TOC_LIST}"
          "(${DBConstants.CL_TOC_NAME} TEXT)");
      db.execute("CREATE TABLE ${DBConstants.TB_RevpirDetail} "
          "(${DBConstants.CL_EMAILADDRESS} TEXT,"
          "${DBConstants.CL_PRECONFERMATIONMESSAGE} TEXT,"
          "${DBConstants.CL_CONFERMATIONMESSAGE} TEXT,"
          "${DBConstants.CL_tOCID} TEXT,"
          "${DBConstants.CL_IDD} TEXT)");

      db.execute("CREATE TABLE ${DBConstants.TB_CAR_TYPE_LIST}"
          "(${DBConstants.CL_REVP_RAIL_CARD_TYPE} TEXT, "
          "${DBConstants.CL_REVP_RAIL_CARD_TYPE_ID} TEXT, "
          "${DBConstants.CL_REVP_RAIL_CARD_ID} TEXT, "
          "${DBConstants.CL_REVP_RAIL_CARD} TEXT)");

      db.execute("CREATE TABLE ${DBConstants.TB_CASE_DETAILS_LIST}"
          "(${DBConstants.CL_CASETYPEID} TEXT, "
          "${DBConstants.CL_CASETYPECODE} TEXT, "
          "${DBConstants.CL_ENABLESTATTUS} TEXT)");

      db.execute("CREATE TABLE ${DBConstants.TB_CASE_DETAILS_LIST_PRINT}"
          "(${DBConstants.CL_CASETYPEID_PRINT} TEXT, "
          "${DBConstants.CL_CASETYPECODE_PRINT} TEXT, "
          "${DBConstants.CL_ENABLESTATTUS_PRINT} TEXT)");

      //Create rvmp_station_list table
      db.execute("CREATE TABLE ${DBConstants.TB_REVP_STATION_LIST}"
          "(${DBConstants.CL_STATION_NAME} TEXT, "
          "${DBConstants.CL_ORDER}  INTEGER, "
          "${DBConstants.CL_CRS_CODE} TEXT, "
          "${DBConstants.CL_NLC_CODE} TEXT, "
          "${DBConstants.CL_CASETYPES} TEXT)");
      //Create gog_station_list table
      db.execute("CREATE TABLE ${DBConstants.TB_GOG_STATION_LIST}"
          "(${DBConstants.CL_CODE} TEXT, "
          "${DBConstants.CL_VALUE} TEXT, "
          "${DBConstants.CL_TOC} TEXT)");

      //Create case refrence table
      db.execute("CREATE TABLE ${DBConstants.TB_CASE_REFRENCE}"
          "(${DBConstants.CL_ISLOCKED} TEXT, "
          "${DBConstants.CL_ISUSED} TEXT, "
          "${DBConstants.CL_CASE_REFERENCE_NO} TEXT)");
      db.execute("CREATE TABLE ${DBConstants.TB_IssuingHistory}"
          "(${DBConstants.CL_cREATEDDT} TEXT, "
          "${DBConstants.CL_cASECREATEDTIMEDIFF} TEXT, "
          "${DBConstants.CL_cASEACTION} TEXT, "
          "${DBConstants.CL_sTATUSDESC} TEXT, "
          "${DBConstants.CL_cASEID} TEXT, "
          "${DBConstants.CL_cASETYPE} TEXT, "
          "${DBConstants.CL_cREATEDTIME} TEXT, "
          "${DBConstants.CL_cASENUM} TEXT)");
      db.execute("CREATE TABLE ${DBConstants.TB_IssuingHistoryIR}"
          "(${DBConstants.CL_cREATEDDT_IR} TEXT, "
          "${DBConstants.CL_cASECREATEDTIMEDIFF_IR} TEXT, "
          "${DBConstants.CL_cASEACTION_IR} TEXT, "
          "${DBConstants.CL_REPORT_IR} TEXT, "
          "${DBConstants.CL_cASEID_IR} TEXT, "
          "${DBConstants.CL_cREATEDTIME_IR} TEXT, "
          "${DBConstants.CL_cASENUM_IR} TEXT)");

      db.execute("CREATE TABLE ${DBConstants.TB_LIST_LOOK_UP_DATA}"
          "(${DBConstants.CL_LOOK_UP_DATA} TEXT)");

      db.execute("CREATE TABLE ${DBConstants.TB_API_REQUEST}"
          "(${DBConstants.CL_API_REQUEST_SERIAL_ID} INTEGER PRIMARY KEY, "
          "${DBConstants.CL_API_REQUEST_ID} TEXT, "
          "${DBConstants.CL_REQUEST_SECTION_NAME} TEXT, "
          "${DBConstants.CL_REQUEST_SUB_SECTION_NAME} TEXT, "
          "${DBConstants.CL_REQUEST_DATA} TEXT)");
      db.execute("CREATE TABLE ${DBConstants.TB_API_INTERRUPT_REQUEST}"
          "(${DBConstants.CL_API_REQUEST_SERIAL_ID} INTEGER PRIMARY KEY, "
          "${DBConstants.CL_API_REQUEST_ID} TEXT, "
          "${DBConstants.CL_REQUEST_SECTION_NAME} TEXT, "
          "${DBConstants.CL_REQUEST_SUB_SECTION_NAME} TEXT, "
          "${DBConstants.CL_REQUEST_DATA} TEXT)");

      db.execute("CREATE TABLE ${DBConstants.TB_IMAGES_REQUEST}"
          "(${DBConstants.CL_API_REQUEST_SERIAL_ID} INTEGER PRIMARY KEY, "
          "${DBConstants.CL_IMAGES_CASE_ID} TEXT, "
          "${DBConstants.CL_IMAGES_TYPE} TEXT, "
          "${DBConstants.CL_IMAGES_PATH} TEXT, "
          "${DBConstants.CL_IMAGES_SECTION} TEXT, "
          "${DBConstants.CL_IMAGES_SUB_SECTION} TEXT, "
          "${DBConstants.CL_IMAGES_DATA} TEXT)");
    }, version: DBConstants.DATABASE_VERSION);
  }
}

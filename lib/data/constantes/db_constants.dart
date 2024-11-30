// ignore_for_file: constant_identifier_names

class DBConstants {
  static const String DATABASE_NAME = "railpay.db";
  static const int DATABASE_VERSION = 2;

  /*TABLES NAME*/
  static const String TB_LIST_OFFENCES = "list_offences";
  static const String TB_REVP_STATION_LIST = "revp_station_list";
  static const String TB_GOG_STATION_LIST = "gog_station_list";
  static const String TB_LOGIN_LIST = "login";
  static const String TB_CMS_VARIABLES_LIST = "cms_variable";
  static const String TB_LIST_LOOK_UP_DATA = "list_look_up_data";
  static const String TB_PRINT_TEMPLATE_DATA_LIST = "print_template_list";
  static const String TB_CASE_REFRENCE = "case_refrence";
  static const String TB_PARKING_LIST = "car_parking_list";
  static const String TB_CAR_TYPE_LIST = "car_type_list";
  static const String TB_API_INTERRUPT_REQUEST = "api_interrupt_request";
  static const String TB_API_REQUEST = "api_request";
  static const String TB_IMAGES_REQUEST = "images_request";
  static const String TB_AFFECTED_TOC_LIST = "affected_toc_list";
  static const String TB_RevpirDetail = "revpir_detail";
  static const String TB_IssuingHistoryIR = "user_history_IR";
  static const String TB_IssuingHistory = "user_history";
  static const String TB_CASE_DETAILS_LIST = "case_detail";
  static const String TB_CASE_DETAILS_LIST_PRINT = "case_detail_print";

  /*
  * case_refrence table column
  * */
  static const String CL_ISUSED = "is_isused";
  static const String CL_ISLOCKED = "is_locked";
  static const String CL_CASE_REFERENCE_NO = "case_refrence_no";

  /*
  * list_offences table column
  * */
  static const String CL_OFFENCE_UNIQUE_ID = "id";
  static const String CL_DESCRIPTION = "description";
  static const String CL_OFFENCE_ID = "offence_id";

  /*
  * revp_station_list table column
  * */
  static const String CL_REVP_STATION_ID = "id";
  static const String CL_STATION_NAME = "station_name";
  static const String CL_ORDER = "orders";
  static const String CL_CRS_CODE = "crs_code";
  static const String CL_CASETYPES = "casetypes";
  static const String CL_NLC_CODE = "nlc_code";

  /*
  * gog_station_list table column
  * */
  static const String CL_GOG_STATION_ID = "id";
  static const String CL_CODE = "code";
  static const String CL_VALUE = "value";
  static const String CL_TOC = "toc";

  /*
  * login_data table column
  * */
  static const String CL_ID = "id";
  static const String CL_VARIABLE_KEY = "variable_key";
  static const String CL_VARIABLE_DATA = "variable_data";

  /*
  * cms_data table column
  * */
  static const String CL_CMS_VAR_ID = "id";
  static const String CL_CMS_VARIABLE_KEY = "variable_key";
  static const String CL_CMS_VARIABLE_DATA = "variable_data";

/*
  * print template table column
  * */
  static const String CL_ACTIVE = "active";
  static const String CL_CONTENTS = "content";
  static const String CL_TITLE = "title";
  static const String CL_CASETYPE = "casetype";

/*
  * car parking list
  *  table column
  * */
  static const String CL_CARPARK_LOCATION_ID = "carpark_location_id";
  static const String CL_LOCATION_NAME = "location_name";
  static const String CL_CARPARK_STATION_ID = "station_id";
  static const String CL_CARPARK_STATION_NAME = "station_name";
  static const String CL_CARPARK_ORDER = "orders";

/*
  * car type list list
  *  table column
  * */
  static const String CL_REVP_RAIL_CARD_TYPE = "revpRailCardType";
  static const String CL_REVP_RAIL_CARD_TYPE_ID = "revpRailCardTypeID";
  static const String CL_REVP_RAIL_CARD_ID = "revpRailcardID";
  static const String CL_REVP_RAIL_CARD = "revpRailcard";

/*
  * affected Toc list
  *  table column
  * */
  static const String CL_TOC_NAME = "toc_name";

/*
  * detail Toc list
  *  table column
  * */
  static const String CL_EMAILADDRESS = "EmailAddress";
  static const String CL_PRECONFERMATIONMESSAGE = "PreConfermationMessage";
  static const String CL_CONFERMATIONMESSAGE = "ConfermationMessage";
  static const String CL_tOCID = "TOC_ID";
  static const String CL_IDD = "ID";

/*
  * user history list
  *  table column
  * */

  static const String CL_cREATEDDT = "CREATEDDT";
  static const String CL_cASECREATEDTIMEDIFF = "CASECREATEDTIMEDIFF";
  static const String CL_cASEACTION = "CASEACTION";
  static const String CL_sTATUSDESC = "STATUSDESC";
  static const String CL_cASEID = "CASEID";
  static const String CL_cASETYPE = "CASETYPE";
  static const String CL_cREATEDTIME = "CREATEDTIME";
  static const String CL_cASENUM = "CASENUM";

  ///intelligent report issuign history
  static const String CL_cREATEDDT_IR = "CREATEDDT";
  static const String CL_cASECREATEDTIMEDIFF_IR = "CASECREATEDTIMEDIFF";
  static const String CL_cASEACTION_IR = "CASEACTION";
  static const String CL_REPORT_IR = "PEPORT";
  static const String CL_cASEID_IR = "CASEID";
  static const String CL_cREATEDTIME_IR = "CREATEDTIME";
  static const String CL_cASENUM_IR = "CASENUM";

  ///case details list
  static const String CL_CASETYPECODE = "CASETYPECODE";
  static const String CL_CASETYPEID = "CASETYPEID";
  static const String CL_ENABLESTATTUS = "ENABLESTATTUS";

  ///case details list print
  static const String CL_CASETYPECODE_PRINT = "CASETYPECODE";
  static const String CL_CASETYPEID_PRINT = "CASETYPEID";
  static const String CL_ENABLESTATTUS_PRINT = "ENABLESTATTUS";

  /*
  * list_look_up_data table column
  *
  * */

  // static const String CL_LOOK_UP_ID = "id";
  static const String CL_LOOK_UP_DATA = "lookup_data";

  /*
  * api_request table column
  *
  * */
  static const String CL_API_REQUEST_SERIAL_ID = "s_id";
  static const String CL_API_REQUEST_ID = "id";
  static const String CL_REQUEST_DATA = "request_data";
  static const String CL_REQUEST_SECTION_NAME = "request_section_name";
  static const String CL_REQUEST_SUB_SECTION_NAME = "request_sub_section_name";

  /*
  * image_request table column
  *
  * */
  static const String CL_IMAGES_CASE_ID = "id";
  static const String CL_IMAGES_DATA = "images_data";
  static const String CL_IMAGES_PATH = "images_path";
  static const String CL_IMAGES_TYPE = "images_type";
  static const String CL_IMAGES_SECTION = "section";
  static const String CL_IMAGES_SUB_SECTION = "sub_section";
}

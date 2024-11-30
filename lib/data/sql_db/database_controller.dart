import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:railpaytro/data/model/auth/cms_variables_model.dart';
import 'package:railpaytro/data/model/auth/login_model.dart';

import '../model/station/revp_station_model.dart';
import '../model/station/station_list_model.dart';
import '../offline/auth_offline/auth_offline_status.dart';
import 'database_helper.dart';

class DbController {
  // final _dbHelper = DatabaseHelper.instance;
  //
  // //For cms variable
  // void setCmsVarToDb(cms) async {
  //
  //   Map<String, dynamic> row = {
  //     DatabaseHelper.columnName:"",
  //     DatabaseHelper.cmsVar: cms,
  //     DatabaseHelper.stationList: "",
  //     DatabaseHelper.revpStationList: "",
  //     DatabaseHelper.caseRef: "",
  //   };
  //   final id = await _dbHelper.insert(row);
  //   AuthOfflineStatus().setCmsVarOfflineStatus(true);
  //   debugPrint('inserted row id: $id');
  // }

  // getCmsFromDb() async{
  //   final allRows = await _dbHelper.queryAllRows();
  //   var cmsData = allRows[0][DatabaseHelper.cmsVar];
  //   // CmsVariablesModel data = CmsVariablesModel.fromJson(jsonDecode(cmsData));
  //   debugPrint(cmsData.toString());
  //   // return data;
  // }

  // For Login Data
  // Future setUserToDb(user) async{
  //   // row to update
  //   debugPrint('setUserToDb');
  //   Map<String, dynamic> row = {
  //     DatabaseHelper.columnId: 1,
  //     DatabaseHelper.columnName: user,
  //   };
  //   final rowsAffected = await _dbHelper.update(row);
  //   debugPrint('updated $rowsAffected row(s)');
  // }
  //
  // Future<LoginModel> getUserFromDb() async{
  //   final allRows = await _dbHelper.queryAllRows();
  //   var userData = allRows[0]['user'];
  //   LoginModel data = LoginModel.fromJson(jsonDecode(userData));
  //   // debugPrint(data.toJson().toString());
  //   return data;
  // }

  //For stationList

  // void setStationListToDb(stationList) async {
  //   // row to update
  //   Map<String, dynamic> row = {
  //     DatabaseHelper.columnId: 1,
  //     DatabaseHelper.stationList: stationList,
  //   };
  //   final rowsAffected = await _dbHelper.update(row);
  //   debugPrint('updated $rowsAffected row(s)');
  // }
  // getStationListFromDb() async{
  //   final allRows = await _dbHelper.queryAllRows();
  //   var cmsData = allRows[0][DatabaseHelper.stationList];
  //   StationListModel data = StationListModel.fromJson(jsonDecode(cmsData));
  //   return data;
  // }

  // //For revpStationList
  // void setRevpStationListToDb(revpStationList) async {
  //   // row to update
  //   debugPrint(' revpStationList');
  //   Map<String, dynamic> row = {
  //     DatabaseHelper.columnId: 1,
  //     DatabaseHelper.revpStationList: revpStationList,
  //   };
  //   final rowsAffected = await _dbHelper.update(row);
  //   debugPrint('updated $rowsAffected row(s)');
  // }
  // getRevpStationListFromDb() async{
  //   final allRows = await _dbHelper.queryAllRows();
  //   var cmsData = allRows[0][DatabaseHelper.revpStationList];
  //   RevpStationModel data = RevpStationModel.fromJson(jsonDecode(cmsData));
  //   return data;
  // }

  // //For offenceList
  // void setOffenceListToDb(offenceList) async {
  //   // row to update
  //   debugPrint(' revpStationList');
  //   Map<String, dynamic> row = {
  //     DatabaseHelper.columnId: 1,
  //     DatabaseHelper.offenceList: offenceList,
  //   };
  //   final rowsAffected = await _dbHelper.update(row);
  //   debugPrint('updated $rowsAffected row(s)');
  // }
  //
  // getOffenceListFromDb() async{
  //   final allRows = await _dbHelper.queryAllRows();
  //   var cmsData = allRows[0][DatabaseHelper.offenceList];
  //   OffenceListModel data = OffenceListModel.fromJson(jsonDecode(cmsData));
  //   return data;
  // }

  //
  // Future insert() async {
  //   // row to insert
  //   Map<String, dynamic> row = {
  //     DatabaseHelper.columnName: 'Bob',
  //   };
  //   final id = await _dbHelper.insert(row);
  //   print('inserted row id: $id');
  // }

  // void query() async {
  //   final allRows = await _dbHelper.queryAllRows();
  //   print('query all rows:');
  //   allRows.forEach(print);
  // if(allRows != null && allRows.isNotEmpty){
  //   print(allRows[0]['user']);
  // }else{
  //   print('Empty Data');
  // }
  // }

  // void update() async {
  //   // row to update
  //   Map<String, dynamic> row = {
  //     DatabaseHelper.columnId: 1,
  //     DatabaseHelper.cmsVar: 'Mary',
  //   };
  //   final rowsAffected = await _dbHelper.update(row);
  //   print('updated $rowsAffected row(s)');
  // }

  // void delete() async {
  //   // Assuming that the number of rows is the id for the last row.
  //   final id = await _dbHelper.queryRowCount();
  //   final rowsDeleted = await _dbHelper.delete(id!);
  //   // debugPrint('deleted $rowsDeleted row(s): row $id');
  // }

}

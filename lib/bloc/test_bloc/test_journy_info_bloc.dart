// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../Ui/Pages/Role_stationsTeam/test_notice_case/test_attachments.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/auth/login_model.dart';
import '../../../../bloc/ufn_luno_bloc/address_screen_bloc.dart';

class TestJournyInfoEvent {}

class TestInfoJournyButtonEvent extends TestJournyInfoEvent {
  String origin,
      destination,
      travelClass,
      travelClassId,
      issueAt,
      reasonId,
      reason,
      cardType,
      otherReason;
  DateTime issueDateTime;
  BuildContext context;

  TestInfoJournyButtonEvent(
      {required this.context,
      required this.otherReason,
      required this.origin,
      required this.destination,
      required this.reason,
      required this.travelClassId,
      required this.travelClass,
      required this.issueAt,
      required this.reasonId,
      required this.cardType,
      required this.issueDateTime});
}

class TestJournyInfoState {}

class TestJournyInfoInitialState extends TestJournyInfoState {}

class TestJournyInfoLoadingState extends TestJournyInfoState {}

class TestJournyInfoSuccessState extends TestJournyInfoState {}

class TestJournyInfoErrorState extends TestJournyInfoState {
  String errorMsg;

  TestJournyInfoErrorState(this.errorMsg);
}

//-----

class TestJournyInfoBloc
    extends Bloc<TestJournyInfoEvent, TestJournyInfoState> {
  TestJournyInfoBloc() : super(TestJournyInfoLoadingState());

  Map<String, dynamic> tempMap = {};

  @override
  Stream<TestJournyInfoState> mapEventToState(
      TestJournyInfoEvent event) async* {
    LoginModel user = await SqliteDB.instance.getLoginModelData();
    if (event is TestInfoJournyButtonEvent) {
      Map<String, dynamic> subMap =
          BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap;

      print(event);
      Map<String, dynamic> dumpMap = {
        'boarded_at': event.origin,
        'alighted_at': event.destination,
        'class': event.travelClassId,
        'otherClasses': event.travelClass,
        'issued_at': event.issueAt,
        'reason': event.reasonId,
        'otherReason': event.otherReason,
        'reason_Title': event.reason,
        'offence_dt': DateFormat('dd-MM-yyyy').format(event.issueDateTime),
        'offence_time': DateFormat.Hm().format(event.issueDateTime).toString(),
        'railCard': event.cardType,
        "username": user.STUSER!.SUSERNAME,
      };

      subMap.addAll(dumpMap);
      BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap = subMap;

      Navigator.push(event.context,
          MaterialPageRoute(builder: (context) => TestUnpaid_attachments()));
    }
  }
}

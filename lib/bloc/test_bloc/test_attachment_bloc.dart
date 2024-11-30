// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:railpaytro/bloc/test_bloc/test_address_bloc.dart';
import '../../Ui/Pages/Role_stationsTeam/test_notice_case/test_attachments.dart';

class TestAttachmentUfnEvent {}

class TestInfoJournyButtonEvent extends TestAttachmentUfnEvent {
  String origin, destination, travelClass, issueAt, reasonId, cardType;
  DateTime issueDateTime;
  BuildContext context;

  TestInfoJournyButtonEvent(
      {required this.context,
      required this.origin,
      required this.destination,
      required this.travelClass,
      required this.issueAt,
      required this.reasonId,
      required this.cardType,
      required this.issueDateTime});
}

class TestAttachmentUfnState {}

class TestAttachmentUfnInitialState extends TestAttachmentUfnState {}

class TestAttachmentUfnLoadingState extends TestAttachmentUfnState {}

class TestAttachmentUfnSuccessState extends TestAttachmentUfnState {}

class TestAttachmentUfnErrorState extends TestAttachmentUfnState {
  String errorMsg;

  TestAttachmentUfnErrorState(this.errorMsg);
}

//-----

class TestAttachmentUfnBloc
    extends Bloc<TestAttachmentUfnEvent, TestAttachmentUfnState> {
  TestAttachmentUfnBloc() : super(TestAttachmentUfnLoadingState());

  @override
  Stream<TestAttachmentUfnState> mapEventToState(
      TestAttachmentUfnEvent event) async* {
    if (event is TestInfoJournyButtonEvent) {
      Map<String, dynamic> subMap =
          BlocProvider.of<AddressTestBloc>(event.context).submitAddressMap;

      Map<String, dynamic> dumpMap = {
        'boarded_at': event.origin,
        'alighted_at': event.destination,
        'class': event.travelClass,
        'otherClasses': '',
        'issued_at': event.issueAt,
        'reason': event.reasonId,
        'otherReason': '',
        'offence_dt': DateFormat('dd-MM-yyyy').format(event.issueDateTime),
        'railCard': event.cardType,
      };

      subMap.addAll(dumpMap);
      BlocProvider.of<AddressTestBloc>(event.context).submitAddressMap = subMap;

      Navigator.push(event.context,
          MaterialPageRoute(builder: (context) => TestUnpaid_attachments()));
    }
  }
}

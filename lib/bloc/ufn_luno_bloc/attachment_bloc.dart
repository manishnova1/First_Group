// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../Ui/Pages/Role_stationsTeam/unpaid_fare_issue/attachments.dart';
import 'address_screen_bloc.dart';

class AttachmentUfnEvent {}

class InfoJournyButtonEvent extends AttachmentUfnEvent {
  String origin, destination, travelClass, issueAt, reasonId, cardType;
  DateTime issueDateTime;
  BuildContext context;

  InfoJournyButtonEvent(
      {required this.context,
      required this.origin,
      required this.destination,
      required this.travelClass,
      required this.issueAt,
      required this.reasonId,
      required this.cardType,
      required this.issueDateTime});
}

class AttachmentUfnState {}

class AttachmentUfnInitialState extends AttachmentUfnState {}

class AttachmentUfnLoadingState extends AttachmentUfnState {}

class AttachmentUfnSuccessState extends AttachmentUfnState {}

class AttachmentUfnErrorState extends AttachmentUfnState {
  String errorMsg;

  AttachmentUfnErrorState(this.errorMsg);
}

//-----

class AttachmentUfnBloc extends Bloc<AttachmentUfnEvent, AttachmentUfnState> {
  AttachmentUfnBloc() : super(AttachmentUfnLoadingState());

  @override
  Stream<AttachmentUfnState> mapEventToState(AttachmentUfnEvent event) async* {
    if (event is InfoJournyButtonEvent) {
      Map<String, dynamic> subMap =
          BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap;

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
      BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap = subMap;

      Navigator.push(event.context,
          MaterialPageRoute(builder: (context) => Unpaid_attachments()));
    }
  }
}

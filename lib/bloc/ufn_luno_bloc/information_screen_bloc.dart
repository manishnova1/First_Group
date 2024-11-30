// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/unpaid_fare_issue/missing_customer_information_address.dart';
import 'package:railpaytro/data/repo/ufn_repo.dart';
import '../../Ui/Pages/Role_stationsTeam/unpaid_fare_issue/journey_details.dart';
import 'address_screen_bloc.dart';

class InfoAddressEvent {}

class InfoAddressRefreshEvent extends InfoAddressEvent {}

class InfoPersonalButtonEvent extends InfoAddressEvent {
  String title, name, surname, dobString, parent;
  BuildContext context;

  InfoPersonalButtonEvent(
      {required this.context,
      required this.title,
      required this.name,
      required this.surname,
      required this.dobString,
      required this.parent});
}

class InfoContactButtonEvent extends InfoAddressEvent {
  String email, telephone, postcode;
  BuildContext context;

  InfoContactButtonEvent({
    required this.context,
    required this.postcode,
    required this.email,
    required this.telephone,
  });
}

class InfoAddressMissingButtonEvent extends InfoAddressEvent {
  String email, telephone, postcode;
  BuildContext context;

  InfoAddressMissingButtonEvent({
    required this.context,
    required this.postcode,
    required this.email,
    required this.telephone,
  });
}

class InfoAddressState {}

class InfoAddressInitialState extends InfoAddressState {}

class InfoAddressLoadingState extends InfoAddressState {}

class InfoAddressSuccessState extends InfoAddressState {}

class InfoAddressErrorState extends InfoAddressState {
  String errorMsg;

  InfoAddressErrorState(this.errorMsg);
}

//-----

class InfoAddressBloc extends Bloc<InfoAddressEvent, InfoAddressState> {
  UfnRepo ufnRepo;

  InfoAddressBloc(this.ufnRepo) : super(InfoAddressLoadingState());

  @override
  Stream<InfoAddressState> mapEventToState(InfoAddressEvent event) async* {
    if (event is InfoPersonalButtonEvent) {
      Map<String, dynamic> subMap =
          BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap;

      Map<String, dynamic> dumpMap = {
        'title': event.title,
        'otherTitle': '',
        'forename': event.name,
        'surname': event.surname,
        'dateofbirth': DateFormat('dd/MM/yyyy')
            .format(DateFormat("dd MMMM, yyyy").parse(event.dobString)),
        'parent': event.parent,
      };

      subMap.addAll(dumpMap);
      BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap = subMap;

      Navigator.push(
          event.context,
          MaterialPageRoute(
              builder: (context) => const MissingCustomerInformationAddress()));
    } else if (event is InfoContactButtonEvent) {
      Map<String, dynamic> subMap =
          BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap;

      Map<String, dynamic> dumpMap = {
        'email': event.email,
        'telephone': event.telephone,
        // 'post_code': event.postcode
        'post_code': subMap['post_code']
      };

      subMap.addAll(dumpMap);
      BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap = subMap;

      Navigator.push(event.context,
          MaterialPageRoute(builder: (context) => JourneyDetails()));
    }
  }
}

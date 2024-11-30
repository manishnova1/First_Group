// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:railpaytro/data/repo/ufn_repo.dart';
import '../../Ui/Pages/Role_stationsTeam/test_notice_case/test_journey_details.dart';
import '../../Ui/Pages/Role_stationsTeam/test_notice_case/test_missing_Customer_info_address.dart';
import '../ufn_luno_bloc/address_screen_bloc.dart';

class TestInfoAddressEvent {}

class TestInfoAddressRefreshEvent extends TestInfoAddressEvent {}

class TestInfoPersonalButtonEvent extends TestInfoAddressEvent {
  String title, name, surname, dobString, parent;
  BuildContext context;

  TestInfoPersonalButtonEvent(
      {required this.context,
      required this.title,
      required this.name,
      required this.surname,
      required this.dobString,
      required this.parent});
}

class TestInfoContactButtonEvent extends TestInfoAddressEvent {
  String email, telephone, postcode;
  BuildContext context;

  TestInfoContactButtonEvent({
    required this.context,
    required this.postcode,
    required this.email,
    required this.telephone,
  });
}

class TestInfoAddressState {}

class TestInfoAddressInitialState extends TestInfoAddressState {}

class TestInfoAddressLoadingState extends TestInfoAddressState {}

class TestInfoAddressSuccessState extends TestInfoAddressState {}

class TestInfoAddressErrorState extends TestInfoAddressState {
  String errorMsg;

  TestInfoAddressErrorState(this.errorMsg);
}

//-----

class TestInfoAddressBloc
    extends Bloc<TestInfoAddressEvent, TestInfoAddressState> {
  UfnRepo ufnRepo;

  TestInfoAddressBloc(this.ufnRepo) : super(TestInfoAddressLoadingState());

  @override
  Stream<TestInfoAddressState> mapEventToState(
      TestInfoAddressEvent event) async* {
    if (event is TestInfoPersonalButtonEvent) {
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
              builder: (context) =>
                  const MissingCustomerInformationAddressTest()));
    } else if (event is TestInfoContactButtonEvent) {
      Map<String, dynamic> subMap =
          BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap;

      Map<String, dynamic> dumpMap = {
        'email': event.email,
        'telephone': event.telephone,
        'post_code': subMap['post_code']
      };

      subMap.addAll(dumpMap);
      BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap = subMap;

      Navigator.push(event.context,
          MaterialPageRoute(builder: (context) => TestJourneyDetails()));
    }
  }
}

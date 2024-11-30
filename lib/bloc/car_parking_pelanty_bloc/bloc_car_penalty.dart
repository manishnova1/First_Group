import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Utils/HelpfullMethods.dart';
import 'package:railpaytro/common/locator/locator.dart';
import 'package:railpaytro/data/model/station/service_list_mdel.dart';
import 'package:railpaytro/data/repo/car_parking_penalty_repo.dart';

import '../../common/Utils/utils.dart';
import '../../common/service/dialog_service.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/auth/login_model.dart';
import '../../data/model/car_parking_penalty/car_parking_penalty.dart';
import '../../data/model/car_parking_penalty/reason_for_issue_list_model.dart';

class CarPenaltyEvent {}

class CarPenaltySearchEvent extends CarPenaltyEvent {
  String? regId;

  CarPenaltySearchEvent({
    this.regId,
  });
}

class CarPenaltyOffenceEvent extends CarPenaltyEvent {}

class CarPenaltyState {}

class CarPenaltyInitialState extends CarPenaltyState {}

class CarPenaltyLoadingState extends CarPenaltyState {}

class VehicleFoundSuccessfully extends CarPenaltyState {
  REVPVEHICLEDATAARRAYBean data;

  VehicleFoundSuccessfully(this.data);
}

class VehicleFoundErrorState extends CarPenaltyState {
  String error;

  VehicleFoundErrorState(this.error);
}

class CarPenaltySuccessState extends CarPenaltyState {
  ServiceListMdel data;

  CarPenaltySuccessState(this.data);
}

class CarPenaltyErrorState extends CarPenaltyState {
  CarPenaltyErrorState();
}

class CarPenaltyBloc extends Bloc<CarPenaltyEvent, CarPenaltyState> {
  CarParkingPenaltyRepo carParkingPenaltyRepo;
  ServiceListMdel? data;
  ReasonForIssueModel? offenceModel;

  CarPenaltyBloc(this.carParkingPenaltyRepo) : super(CarPenaltyInitialState());

  @override
  Stream<CarPenaltyState> mapEventToState(CarPenaltyEvent event) async* {
    LoginModel user = await SqliteDB.instance.getLoginModelData();
    var id = await getId();
    try {
      // for search button -----
      if (event is CarPenaltySearchEvent) {
        bool checkInternet = await Utils.checkInternet();
        if (checkInternet) {
          locator<DialogService>().showLoader();

          final res = await carParkingPenaltyRepo.getVehicleDetails(
              regNo: event.regId!,
              uniqeId: id!,
              ssessionId: user.STCONFIG!.SAPPSESSIONID!,
              username: user.STUSER!.SUSERNAME!,
              userID: user.STUSER!.ID!);

          locator<DialogService>().hideLoader();

          if (res.isSuccess) {
            try {
              if (res.data.REVPVEHICLEDATAARRAY!.isNotEmpty &&
                  ((res.data.REVPVEHICLEDATAARRAY![0].MAKE != "UNKNOWN") &&
                      (res.data.REVPVEHICLEDATAARRAY![0].MODEL != "UNKNOWN") &&
                      (res.data.REVPVEHICLEDATAARRAY![0].COLOUR !=
                          "UNKNOWN"))) {
                yield VehicleFoundSuccessfully(
                    res.data.REVPVEHICLEDATAARRAY![0]);
              } else {
                yield VehicleFoundErrorState(res.error);
              }
            } catch (e, stacktrace) {
              debugPrint("$e : $stacktrace");
              final res = await carParkingPenaltyRepo.getVehicleDetails(
                  regNo: event.regId!,
                  uniqeId: id!,
                  ssessionId: user.STCONFIG!.SAPPSESSIONID!,
                  username: user.STUSER!.SUSERNAME!,
                  userID: user.STUSER!.ID!);
              yield VehicleFoundErrorState(res.error);
            }
          } else {
            final res = await carParkingPenaltyRepo.getVehicleDetails(
                regNo: event.regId!,
                uniqeId: id!,
                ssessionId: user.STCONFIG!.SAPPSESSIONID!,
                username: user.STUSER!.SUSERNAME!,
                userID: user.STUSER!.ID!);
            locator<DialogService>().hideLoader();
            yield VehicleFoundErrorState(res.error);
          }

          // for init event -----
        } else if (event is CarPenaltyOffenceEvent) {
          final res = await carParkingPenaltyRepo.revpListOffences(
              sessionId: user.STCONFIG!.SAPPSESSIONID!,
              userID: user.STUSER!.ID!,
              macAddress: id!);
          if (res.isSuccess) {
            offenceModel = res.data;
          }
        } else {
          yield CarPenaltyErrorState();
        }
      }
    } catch (e, stacktrace) {
      debugPrint("$e : $stacktrace");
      yield CarPenaltyErrorState();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:railpaytro/common/locator/locator.dart';
import 'package:railpaytro/common/router/router.gr.dart';
import 'package:railpaytro/data/model/station/service_list_mdel.dart';
import '../../common/service/dialog_service.dart';
import '../../common/service/navigation_service.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/auth/login_model.dart';
import '../../data/repo/base/on_train_repo.dart';

class OnStationEvent {}

class OnStationRefreshEvent extends OnStationEvent {
  String? startLocation;
  String? endLocation;
  String? time;
  DateTime? selectedDateTime;

  OnStationRefreshEvent({
    this.startLocation,
    this.endLocation,
    this.time,
    this.selectedDateTime,
  });
}

class OnStationEarlyEvent extends OnStationEvent {
  String? startLocation;
  String? endLocation;
  DateTime selectedDateTime;

  OnStationEarlyEvent({
    this.startLocation,
    this.endLocation,
    required this.selectedDateTime,
  });
}

class OnStationLaterEvent extends OnStationEvent {
  String? startLocation;
  String? endLocation;
  DateTime selectedDateTime;

  OnStationLaterEvent({
    required this.startLocation,
    required this.endLocation,
    required this.selectedDateTime,
  });
}

class OnStationState {}

class OnStationInitialState extends OnStationState {}

class OnStationLoadingState extends OnStationState {}

class OnStationSuccessState extends OnStationState {
  ServiceListMdel data;

  OnStationSuccessState(this.data);
}

class OnStationErrorState extends OnStationState {
  OnStationErrorState();
}

class OnStationBloc extends Bloc<OnStationEvent, OnStationState> {
  OnTrainRepo onTrainRepo;
  ServiceListMdel? data;
  DateTime? selectedDateTime;

  OnStationBloc(this.onTrainRepo) : super(OnStationInitialState());

  @override
  Stream<OnStationState> mapEventToState(OnStationEvent event) async* {
    try {
      LoginModel user = await SqliteDB.instance.getLoginModelData();
      if (event is OnStationRefreshEvent) {
        selectedDateTime = event.selectedDateTime;
        locator<DialogService>().showLoader(dismissable: false);
        final res = await getResponce(
            onTrainRepo, event.startLocation!, event.endLocation!, event.time!);
        locator<DialogService>().hideLoader();

        if (res.isSuccess) {
          Iterable list = res.data.ASERVICELIST!;
          if (list.isNotEmpty) {
            locator<NavigationService>().popAndPush(TrainSelectionRoute(
                origin: event.startLocation!,
                destination: event.endLocation!,
                time: event.time!,
                selectedTime: event.selectedDateTime!));
            locator<DialogService>().hideLoader();
            yield OnStationSuccessState(res.data);
            locator<DialogService>().hideLoader();
            //     msg: "Api Hit Successfully !! ", backgroundColor: Colors.black);
          } else {
            Fluttertoast.showToast(
                msg: "No Station Found", backgroundColor: Colors.black);
          }
        } else {
          Fluttertoast.showToast(msg: res.error, backgroundColor: Colors.black);
          yield OnStationErrorState();
        }
      } else if (event is OnStationEarlyEvent) {
        yield OnStationLoadingState();
        var earlyTime =
            event.selectedDateTime.subtract(const Duration(minutes: 30));
        selectedDateTime = earlyTime;

        var time = "${earlyTime.hour} : ${earlyTime.minute}";
        final res = await getResponce(
            onTrainRepo, event.startLocation!, event.endLocation!, time);
        if (res.isSuccess) {
          Iterable list = res.data.ASERVICELIST!;
          if (list.isNotEmpty) {
            yield OnStationSuccessState(res.data);
            locator<DialogService>().hideLoader();
            //     msg: "Api Hit Successfully !! ", backgroundColor: Colors.black);
          } else {
            Fluttertoast.showToast(
                msg: "No Station Found", backgroundColor: Colors.black);
          }
        } else {
          Fluttertoast.showToast(msg: res.error, backgroundColor: Colors.black);
          yield OnStationErrorState();
        }
      } else if (event is OnStationLaterEvent) {
        yield OnStationLoadingState();
        var laterTIme = event.selectedDateTime.add(const Duration(hours: 1));
        selectedDateTime = laterTIme;
        var time = "${laterTIme.hour} : ${laterTIme.minute}";
        final res = await getResponce(
            onTrainRepo, event.startLocation!, event.endLocation!, time);
        if (res.isSuccess) {
          Iterable list = res.data.ASERVICELIST!;
          if (list.isNotEmpty) {
            yield OnStationSuccessState(res.data);
            locator<DialogService>().hideLoader();
            //     msg: "Api Hit Successfully !! ", backgroundColor: Colors.black);
          } else {
            Fluttertoast.showToast(
                msg: "No Station Found", backgroundColor: Colors.black);
          }
        } else {
          Fluttertoast.showToast(msg: res.error, backgroundColor: Colors.black);
          yield OnStationErrorState();
        }
      }
    } catch (e, stacktrace) {
      debugPrint("$e : $stacktrace");
      yield OnStationErrorState();
    }
  }

  getResponce(OnTrainRepo onTrainRepo, startLocation, endLocation, time) async {
    LoginModel user = await SqliteDB.instance.getLoginModelData();

    var data = await onTrainRepo.getServiceList(
        userID: user.STUSER!.ID!,
        ssessionId: user.STCONFIG!.SAPPSESSIONID!,
        macAddress: user.STUSER!.MACADRESS!,
        depTime: time,
        startLocation: startLocation,
        endLocation: endLocation);
    locator<DialogService>().hideLoader();
    return data;
  }
}

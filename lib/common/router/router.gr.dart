// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i18;
import 'package:flutter/material.dart' as _i19;

import '../../Ui/Pages/change_current_password.dart' as _i11;
import '../../Ui/Pages/change_password.dart' as _i16;
import '../../Ui/Pages/CurrentLocationScreen.dart' as _i12;
import '../../Ui/Pages/ForgotPassword.dart' as _i4;
import '../../Ui/Pages/HomeScreen.dart' as _i10;
import '../../Ui/Pages/LandingScreen.dart' as _i2;
import '../../Ui/Pages/LoginScreen.dart' as _i3;
import '../../Ui/Pages/Lookup/pcn_lookup_list.dart' as _i6;
import '../../Ui/Pages/Role_stationsTeam/car_parking_penality/images_car_parking_penality.dart'
    as _i17;
import '../../Ui/Pages/Role_stationsTeam/car_parking_penality/main_car_paring_penality.dart'
    as _i9;
import '../../Ui/Pages/Role_stationsTeam/homescreen_issue_screen.dart' as _i8;
import '../../Ui/Pages/Role_stationsTeam/station_screen.dart' as _i7;
import '../../Ui/Pages/Role_stationsTeam/stations_list_screen.dart' as _i5;
import '../../Ui/Pages/Role_transTeam/train_selection.dart' as _i15;
import '../../Ui/Pages/Role_transTeam/train_team_main.dart' as _i14;
import '../../Ui/Pages/SplashScreen.dart' as _i1;
import '../../Ui/Pages/verify_otp.dart' as _i13;

class AppRouter extends _i18.RootStackRouter {
  AppRouter([_i19.GlobalKey<_i19.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i18.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashScreen(),
      );
    },
    LandingScreenRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LandingScreen(),
      );
    },
    LoginScreenRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.LoginScreen(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.ForgotPassword(),
      );
    },
    StationsListScreenRoute.name: (routeData) {
      final args = routeData.argsAs<StationsListScreenRouteArgs>();
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.StationsListScreen(
          args.caseType,
          key: args.key,
        ),
      );
    },
    PcnLookupListRoute.name: (routeData) {
      final args = routeData.argsAs<PcnLookupListRouteArgs>();
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.PcnLookupList(
          args.caseType,
          args.categoryList,
          args.exrta,
          key: args.key,
        ),
      );
    },
    StationScreenRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.StationScreen(),
      );
    },
    UnPaidFareIssueMainRoute.name: (routeData) {
      final args = routeData.argsAs<UnPaidFareIssueMainRouteArgs>();
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.UnPaidFareIssueMain(
            isOfflineApiRequired: args.isOfflineApiRequired),
      );
    },
    CarParkingPenalityMainRoute.name: (routeData) {
      final args = routeData.argsAs<CarParkingPenalityMainRouteArgs>();
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.CarParkingPenalityMain(
          args.issueTitle,
          key: args.key,
        ),
      );
    },
    HomescreenRoute.name: (routeData) {
      final args = routeData.argsAs<HomescreenRouteArgs>();
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.Homescreen(isOfflineApiRequired: args.isOfflineApiRequired),
      );
    },
    ChangeCurrentPasswordRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.ChangeCurrentPassword(),
      );
    },
    CurrentLocationScreenRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.CurrentLocationScreen(),
      );
    },
    VerifyOtpWidgetRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyOtpWidgetRouteArgs>();
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.VerifyOtpWidget(
          key: args.key,
          tag: args.tag,
        ),
      );
    },
    TrainTeamMainRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.TrainTeamMain(),
      );
    },
    TrainSelectionRoute.name: (routeData) {
      final args = routeData.argsAs<TrainSelectionRouteArgs>();
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i15.TrainSelection(
          key: args.key,
          origin: args.origin,
          destination: args.destination,
          time: args.time,
          selectedTime: args.selectedTime,
        ),
      );
    },
    ChangePasswordWidgetRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i16.ChangePasswordWidget(),
      );
    },
    CarParkingPenalityIImagesRoute.name: (routeData) {
      final args = routeData.argsAs<CarParkingPenalityIImagesRouteArgs>();
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i17.CarParkingPenalityIImages(args.dataobj),
      );
    },
  };

  @override
  List<_i18.RouteConfig> get routes => [
        _i18.RouteConfig(
          SplashScreenRoute.name,
          path: '/',
        ),
        _i18.RouteConfig(
          LandingScreenRoute.name,
          path: '/landing-screen',
        ),
        _i18.RouteConfig(
          LoginScreenRoute.name,
          path: '/login-screen',
        ),
        _i18.RouteConfig(
          ForgotPasswordRoute.name,
          path: '/forgot-password',
        ),
        _i18.RouteConfig(
          StationsListScreenRoute.name,
          path: '/stations-list-screen',
        ),
        _i18.RouteConfig(
          PcnLookupListRoute.name,
          path: '/pcn-lookup-list',
        ),
        _i18.RouteConfig(
          StationScreenRoute.name,
          path: '/station-screen',
        ),
        _i18.RouteConfig(
          UnPaidFareIssueMainRoute.name,
          path: '/un-paid-fare-issue-main',
        ),
        _i18.RouteConfig(
          CarParkingPenalityMainRoute.name,
          path: '/car-parking-penality-main',
        ),
        _i18.RouteConfig(
          HomescreenRoute.name,
          path: '/Homescreen',
        ),
        _i18.RouteConfig(
          ChangeCurrentPasswordRoute.name,
          path: '/change-current-password',
        ),
        _i18.RouteConfig(
          CurrentLocationScreenRoute.name,
          path: '/current-location-screen',
        ),
        _i18.RouteConfig(
          VerifyOtpWidgetRoute.name,
          path: '/verify-otp-widget',
        ),
        _i18.RouteConfig(
          TrainTeamMainRoute.name,
          path: '/train-team-main',
        ),
        _i18.RouteConfig(
          TrainSelectionRoute.name,
          path: '/train-selection',
        ),
        _i18.RouteConfig(
          ChangePasswordWidgetRoute.name,
          path: '/change-password-widget',
        ),
        _i18.RouteConfig(
          CarParkingPenalityIImagesRoute.name,
          path: '/car-parking-penality-iImages',
        ),
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashScreenRoute extends _i18.PageRouteInfo<void> {
  const SplashScreenRoute()
      : super(
          SplashScreenRoute.name,
          path: '/',
        );

  static const String name = 'SplashScreenRoute';
}

/// generated route for
/// [_i2.LandingScreen]
class LandingScreenRoute extends _i18.PageRouteInfo<void> {
  const LandingScreenRoute()
      : super(
          LandingScreenRoute.name,
          path: '/landing-screen',
        );

  static const String name = 'LandingScreenRoute';
}

/// generated route for
/// [_i3.LoginScreen]
class LoginScreenRoute extends _i18.PageRouteInfo<void> {
  const LoginScreenRoute()
      : super(
          LoginScreenRoute.name,
          path: '/login-screen',
        );

  static const String name = 'LoginScreenRoute';
}

/// generated route for
/// [_i4.ForgotPassword]
class ForgotPasswordRoute extends _i18.PageRouteInfo<void> {
  const ForgotPasswordRoute()
      : super(
          ForgotPasswordRoute.name,
          path: '/forgot-password',
        );

  static const String name = 'ForgotPasswordRoute';
}

/// generated route for
/// [_i5.StationsListScreen]
class StationsListScreenRoute
    extends _i18.PageRouteInfo<StationsListScreenRouteArgs> {
  StationsListScreenRoute({
    required String caseType,
    _i19.Key? key,
  }) : super(
          StationsListScreenRoute.name,
          path: '/stations-list-screen',
          args: StationsListScreenRouteArgs(
            caseType: caseType,
            key: key,
          ),
        );

  static const String name = 'StationsListScreenRoute';
}

class StationsListScreenRouteArgs {
  const StationsListScreenRouteArgs({
    required this.caseType,
    this.key,
  });

  final String caseType;

  final _i19.Key? key;

  @override
  String toString() {
    return 'StationsListScreenRouteArgs{caseType: $caseType, key: $key}';
  }
}

/// generated route for
/// [_i6.PcnLookupList]
class PcnLookupListRoute extends _i18.PageRouteInfo<PcnLookupListRouteArgs> {
  PcnLookupListRoute({
    required String caseType,
    required String categoryList,
    required String exrta,
    _i19.Key? key,
  }) : super(
          PcnLookupListRoute.name,
          path: '/pcn-lookup-list',
          args: PcnLookupListRouteArgs(
            caseType: caseType,
            categoryList: categoryList,
            exrta: exrta,
            key: key,
          ),
        );

  static const String name = 'PcnLookupListRoute';
}

class PcnLookupListRouteArgs {
  const PcnLookupListRouteArgs({
    required this.caseType,
    required this.categoryList,
    required this.exrta,
    this.key,
  });

  final String caseType;

  final String categoryList;

  final String exrta;

  final _i19.Key? key;

  @override
  String toString() {
    return 'PcnLookupListRouteArgs{caseType: $caseType, categoryList: $categoryList, exrta: $exrta, key: $key}';
  }
}

/// generated route for
/// [_i7.StationScreen]
class StationScreenRoute extends _i18.PageRouteInfo<void> {
  const StationScreenRoute()
      : super(
          StationScreenRoute.name,
          path: '/station-screen',
        );

  static const String name = 'StationScreenRoute';
}

/// generated route for
/// [_i8.UnPaidFareIssueMain]
class UnPaidFareIssueMainRoute
    extends _i18.PageRouteInfo<UnPaidFareIssueMainRouteArgs> {
  UnPaidFareIssueMainRoute({required bool? isOfflineApiRequired})
      : super(
          UnPaidFareIssueMainRoute.name,
          path: '/un-paid-fare-issue-main',
          args: UnPaidFareIssueMainRouteArgs(
              isOfflineApiRequired: isOfflineApiRequired),
        );

  static const String name = 'UnPaidFareIssueMainRoute';
}

class UnPaidFareIssueMainRouteArgs {
  const UnPaidFareIssueMainRouteArgs({required this.isOfflineApiRequired});

  final bool? isOfflineApiRequired;

  @override
  String toString() {
    return 'UnPaidFareIssueMainRouteArgs{isOfflineApiRequired: $isOfflineApiRequired}';
  }
}

/// generated route for
/// [_i9.CarParkingPenalityMain]
class CarParkingPenalityMainRoute
    extends _i18.PageRouteInfo<CarParkingPenalityMainRouteArgs> {
  CarParkingPenalityMainRoute({
    required String issueTitle,
    _i19.Key? key,
  }) : super(
          CarParkingPenalityMainRoute.name,
          path: '/car-parking-penality-main',
          args: CarParkingPenalityMainRouteArgs(
            issueTitle: issueTitle,
            key: key,
          ),
        );

  static const String name = 'CarParkingPenalityMainRoute';
}

class CarParkingPenalityMainRouteArgs {
  const CarParkingPenalityMainRouteArgs({
    required this.issueTitle,
    this.key,
  });

  final String issueTitle;

  final _i19.Key? key;

  @override
  String toString() {
    return 'CarParkingPenalityMainRouteArgs{issueTitle: $issueTitle, key: $key}';
  }
}

/// generated route for
/// [_i10.Homescreen]
class HomescreenRoute extends _i18.PageRouteInfo<HomescreenRouteArgs> {
  HomescreenRoute({required bool? isOfflineApiRequired})
      : super(
          HomescreenRoute.name,
          path: '/Homescreen',
          args: HomescreenRouteArgs(isOfflineApiRequired: isOfflineApiRequired),
        );

  static const String name = 'HomescreenRoute';
}

class HomescreenRouteArgs {
  const HomescreenRouteArgs({required this.isOfflineApiRequired});

  final bool? isOfflineApiRequired;

  @override
  String toString() {
    return 'HomescreenRouteArgs{isOfflineApiRequired: $isOfflineApiRequired}';
  }
}

/// generated route for
/// [_i11.ChangeCurrentPassword]
class ChangeCurrentPasswordRoute extends _i18.PageRouteInfo<void> {
  const ChangeCurrentPasswordRoute()
      : super(
          ChangeCurrentPasswordRoute.name,
          path: '/change-current-password',
        );

  static const String name = 'ChangeCurrentPasswordRoute';
}

/// generated route for
/// [_i12.CurrentLocationScreen]
class CurrentLocationScreenRoute extends _i18.PageRouteInfo<void> {
  const CurrentLocationScreenRoute()
      : super(
          CurrentLocationScreenRoute.name,
          path: '/current-location-screen',
        );

  static const String name = 'CurrentLocationScreenRoute';
}

/// generated route for
/// [_i13.VerifyOtpWidget]
class VerifyOtpWidgetRoute
    extends _i18.PageRouteInfo<VerifyOtpWidgetRouteArgs> {
  VerifyOtpWidgetRoute({
    _i19.Key? key,
    required String tag,
  }) : super(
          VerifyOtpWidgetRoute.name,
          path: '/verify-otp-widget',
          args: VerifyOtpWidgetRouteArgs(
            key: key,
            tag: tag,
          ),
        );

  static const String name = 'VerifyOtpWidgetRoute';
}

class VerifyOtpWidgetRouteArgs {
  const VerifyOtpWidgetRouteArgs({
    this.key,
    required this.tag,
  });

  final _i19.Key? key;

  final String tag;

  @override
  String toString() {
    return 'VerifyOtpWidgetRouteArgs{key: $key, tag: $tag}';
  }
}

/// generated route for
/// [_i14.TrainTeamMain]
class TrainTeamMainRoute extends _i18.PageRouteInfo<void> {
  const TrainTeamMainRoute()
      : super(
          TrainTeamMainRoute.name,
          path: '/train-team-main',
        );

  static const String name = 'TrainTeamMainRoute';
}

/// generated route for
/// [_i15.TrainSelection]
class TrainSelectionRoute extends _i18.PageRouteInfo<TrainSelectionRouteArgs> {
  TrainSelectionRoute({
    _i19.Key? key,
    required String origin,
    required String destination,
    required String time,
    required DateTime selectedTime,
  }) : super(
          TrainSelectionRoute.name,
          path: '/train-selection',
          args: TrainSelectionRouteArgs(
            key: key,
            origin: origin,
            destination: destination,
            time: time,
            selectedTime: selectedTime,
          ),
        );

  static const String name = 'TrainSelectionRoute';
}

class TrainSelectionRouteArgs {
  const TrainSelectionRouteArgs({
    this.key,
    required this.origin,
    required this.destination,
    required this.time,
    required this.selectedTime,
  });

  final _i19.Key? key;

  final String origin;

  final String destination;

  final String time;

  final DateTime selectedTime;

  @override
  String toString() {
    return 'TrainSelectionRouteArgs{key: $key, origin: $origin, destination: $destination, time: $time, selectedTime: $selectedTime}';
  }
}

/// generated route for
/// [_i16.ChangePasswordWidget]
class ChangePasswordWidgetRoute extends _i18.PageRouteInfo<void> {
  const ChangePasswordWidgetRoute()
      : super(
          ChangePasswordWidgetRoute.name,
          path: '/change-password-widget',
        );

  static const String name = 'ChangePasswordWidgetRoute';
}

/// generated route for
/// [_i17.CarParkingPenalityIImages]
class CarParkingPenalityIImagesRoute
    extends _i18.PageRouteInfo<CarParkingPenalityIImagesRouteArgs> {
  CarParkingPenalityIImagesRoute({required Map<String, dynamic> dataobj})
      : super(
          CarParkingPenalityIImagesRoute.name,
          path: '/car-parking-penality-iImages',
          args: CarParkingPenalityIImagesRouteArgs(dataobj: dataobj),
        );

  static const String name = 'CarParkingPenalityIImagesRoute';
}

class CarParkingPenalityIImagesRouteArgs {
  const CarParkingPenalityIImagesRouteArgs({required this.dataobj});

  final Map<String, dynamic> dataobj;

  @override
  String toString() {
    return 'CarParkingPenalityIImagesRouteArgs{dataobj: $dataobj}';
  }
}

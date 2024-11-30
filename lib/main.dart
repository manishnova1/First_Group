import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/data/repo/auth_repo.dart';
import 'package:railpaytro/data/repo/base/global_repo.dart';
import 'package:railpaytro/data/repo/base/on_train_repo.dart';
import 'package:railpaytro/data/repo/base/station_repo.dart';
import 'package:railpaytro/data/repo/issuing_history_repo.dart';
import 'package:railpaytro/data/repo/ufn_repo.dart';
import 'package:sizer/sizer.dart';
import 'Ui/Pages/Role_stationsTeam/issuing_history/Reprint_submit.dart';
import 'bloc/UFN_HT_BLoc/attachment_bloc.dart';
import 'bloc/UFN_HT_BLoc/image_submit_bloc.dart';
import 'bloc/UFN_HT_BLoc/information_screen_bloc.dart';
import 'bloc/UFN_HT_BLoc/journy_info_bloc.dart';
import 'bloc/UFN_HT_BLoc/submit_form_bloc.dart';
import 'bloc/auth_bloc/audit_bloc.dart';
import 'bloc/auth_bloc/auth_bloc.dart';
import 'bloc/auth_bloc/change_password_bloc.dart';
import 'bloc/auth_bloc/forgot_pass_bloc.dart';
import 'bloc/auth_bloc/landing_bloc.dart';
import 'bloc/auth_bloc/logout_summary_bloc.dart';
import 'bloc/auth_bloc/setting_bloc.dart';
import 'bloc/auth_bloc/verify_otp_bloc.dart';
import 'bloc/car_parking_pelanty_bloc/bloc_capture_image_upload.dart';
import 'bloc/car_parking_pelanty_bloc/bloc_car_penalty.dart';
import 'bloc/car_parking_pelanty_bloc/bloc_car_penalty_submit.dart';
import 'bloc/car_parking_pelanty_bloc/bloc_image_upload.dart';
import 'bloc/global_bloc.dart';
import 'bloc/intelligent_bloc/IR_image_submit_bloc.dart';
import 'bloc/intelligent_bloc/bloc_IR_submit.dart';
import 'bloc/issuing_bloc/issuing_history_list.dart';
import 'bloc/issuing_bloc/issuing_submit.dart';
import 'bloc/offender_description_bloc.dart';
import 'bloc/offline_sync.dart';
import 'bloc/on_station_bloc/bloc_in_station.dart';
import 'bloc/printer_bloc/Reprint_bloc.dart';
import 'bloc/printer_bloc/printer_bloc.dart';
import 'bloc/station_bloc/bloc_station_list.dart';
import 'bloc/test_bloc/test_address_bloc.dart';
import 'bloc/test_bloc/test_image_submit_bloc.dart';
import 'bloc/test_bloc/test_information_screen_bloc.dart';
import 'bloc/test_bloc/test_journy_info_bloc.dart';
import 'bloc/test_bloc/test_submit_form_bloc.dart';
import 'bloc/ufn_luno_bloc/address_screen_bloc.dart';
import 'bloc/ufn_luno_bloc/image_submit_bloc.dart';
import 'bloc/ufn_luno_bloc/information_screen_bloc.dart';
import 'bloc/ufn_luno_bloc/journy_info_bloc.dart';
import 'bloc/ufn_luno_bloc/submit_form_bloc.dart';
import 'common/locator/locator.dart';
import 'common/router/router.gr.dart';
import 'constants/app_config.dart';
import 'constants/strings.dart';
import 'data/repo/car_parking_penalty_repo.dart';
import 'localization/language_constants.dart';

Future<void> main() async {
  Map<String, dynamic> body = {};
  // CatcherOptions debugOptions =
  // CatcherOptions(SilentReportMode(), [ConsoleHandler(
  // ),
  //   HttpHandler(HttpRequestType.post,
  //
  //     Uri.parse("${AppConfig.mainUrl}/www/index.cfm?action=revp.appLog&TOC_ID=${AppConfig.tocId}"),
  //     headers:{
  //       'APIKey': "00112233",
  //     },
  //
  //     printLogs: true,)
  // ],);






  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());

}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale = const Locale('en');
  final AuthRepo _authRepo = locator<AuthRepo>();
  final IssuingHistoryRepo historyRepo = locator<IssuingHistoryRepo>();
  final StationRepo _stationRepo = locator<StationRepo>();
  final OnTrainRepo _onTrainRepo = locator<OnTrainRepo>();
  final UfnRepo _ufnRepo = locator<UfnRepo>();
  final GlobalRepo _globalRepo = locator<GlobalRepo>();
  final IssuingHistoryRepo _issuing_history_repo =
      locator<IssuingHistoryRepo>();
  final CarParkingPenaltyRepo _carParkingPenaltyRepo =
      locator<CarParkingPenaltyRepo>();

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiBlocProvider(
        providers: [
          /*   BlocProvider<SplashBloc>(
            create: (context) => SplashBloc(_stationRepo),
          ),*/
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(_authRepo),
          ),
          BlocProvider<LandingBloc>(
            create: (context) => LandingBloc(_authRepo),
          ),
          BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc(_authRepo),
          ),
          BlocProvider<StationListBloc>(
            create: (context) => StationListBloc(_stationRepo),
          ),
          BlocProvider<ForgotPassBloc>(
            create: (context) => ForgotPassBloc(_authRepo),
          ),
          BlocProvider<OnStationBloc>(
            create: (context) => OnStationBloc(_onTrainRepo),
          ),
          BlocProvider<VerifyOtpBloc>(
            create: (context) => VerifyOtpBloc(_authRepo),
          ),
          BlocProvider<ChangePasswordBloc>(
            create: (context) => ChangePasswordBloc(_authRepo),
          ),
          BlocProvider<AuditLogBloc>(
            create: (context) => AuditLogBloc(_authRepo),
          ),
          BlocProvider<CarPenaltyBloc>(
            create: (context) => CarPenaltyBloc(_carParkingPenaltyRepo),
          ),
          BlocProvider<PCNImageSubmitBloc>(
            create: (context) => PCNImageSubmitBloc(_carParkingPenaltyRepo),
          ),
          BlocProvider<PenaltySubmitBloc>(
            create: (context) => PenaltySubmitBloc(_carParkingPenaltyRepo),
          ),
          BlocProvider<AddressUfnBloc>(
            create: (context) => AddressUfnBloc(_ufnRepo),
          ),
          BlocProvider<InfoAddressBloc>(
            create: (context) => InfoAddressBloc(_ufnRepo),
          ),
          BlocProvider<JournyInfoBloc>(
            create: (context) => JournyInfoBloc(),
          ),
          BlocProvider<ImageSubmitBloc>(
            create: (context) => ImageSubmitBloc(_ufnRepo),
          ),
          BlocProvider<SubmitFormBloc>(
            create: (context) => SubmitFormBloc(_ufnRepo),
          ),

          BlocProvider<IRSubmitBloc>(
            create: (context) => IRSubmitBloc(),
          ),
          BlocProvider<IRImageSubmitBloc>(
            create: (context) => IRImageSubmitBloc(_ufnRepo),
          ),

          BlocProvider<PrinterBloc>(
            create: (context) => PrinterBloc(),
          ),

          BlocProvider<TestImageSubmitBloc>(
            create: (context) => TestImageSubmitBloc(_ufnRepo),
          ),
          BlocProvider<TestInfoAddressBloc>(
            create: (context) => TestInfoAddressBloc(_ufnRepo),
          ),
          BlocProvider<TestJournyInfoBloc>(
            create: (context) => TestJournyInfoBloc(),
          ),
          BlocProvider<AddressTestBloc>(
            create: (context) => AddressTestBloc(_ufnRepo),
          ),
          BlocProvider<TestSubmitFormBloc>(
            create: (context) => TestSubmitFormBloc(_ufnRepo),
          ),
          BlocProvider<IssuingSubmitFormBloc>(
            create: (context) => IssuingSubmitFormBloc(),
          ),
          BlocProvider<IssuingHistoryBloc>(
            create: (context) => IssuingHistoryBloc(_issuing_history_repo),
          ),
          BlocProvider<RevpCaptureImageUploadBloc>(
            create: (context) =>
                RevpCaptureImageUploadBloc(_carParkingPenaltyRepo),
          ),
          BlocProvider<GlobalBloc>(
            create: (context) => GlobalBloc(
                _globalRepo,
                _authRepo,
                _stationRepo,
                _onTrainRepo,
                _ufnRepo,
                _carParkingPenaltyRepo,
                historyRepo),
          ),
          BlocProvider<OfflineSyncBloc>(
            create: (context) => OfflineSyncBloc(),
          ),
          BlocProvider<LogoutSummaryFormBloc>(
            create: (context) => LogoutSummaryFormBloc(),
          ),
          BlocProvider<OffenderDescriptionBloc>(
            create: (context) => OffenderDescriptionBloc(),
          ),
          BlocProvider<AttachmentUfn_HTBloc>(
            create: (context) => AttachmentUfn_HTBloc(),
          ),
          BlocProvider<ImageSubmitBlocHTHT>(
            create: (context) => ImageSubmitBlocHTHT(_ufnRepo),
          ),
          BlocProvider<InfoAddressBlocHT>(
            create: (context) => InfoAddressBlocHT(_ufnRepo),
          ),
          BlocProvider<JournyInfoBlocHT>(
            create: (context) => JournyInfoBlocHT(),
          ),
          BlocProvider<SubmitFormBlocHTHT>(
            create: (context) => SubmitFormBlocHTHT(_ufnRepo),
          ),
          BlocProvider<PrinterReprintBloc>(
            create: (context) => PrinterReprintBloc(),
          ),
          BlocProvider<IssuingSubmitReprintBloc>(
            create: (context) => IssuingSubmitReprintBloc(),
          ),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp.router(
            useInheritedMediaQuery: true,
            title: appName,
            debugShowCheckedModeBanner: false,
            routerDelegate: locator<AppRouter>().delegate(),
            routeInformationParser: locator<AppRouter>().defaultRouteParser(),
          ); //
        }));
  }
}

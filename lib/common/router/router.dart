import 'package:auto_route/auto_route.dart';
import 'package:railpaytro/Ui/Pages/Lookup/pcn_lookup_list.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/car_parking_penality/main_car_paring_penality.dart';
import 'package:railpaytro/Ui/Pages/Role_transTeam/train_selection.dart';
import 'package:railpaytro/Ui/Pages/Role_transTeam/train_team_main.dart';
import '../../Ui/Pages/CurrentLocationScreen.dart';
import '../../Ui/Pages/ForgotPassword.dart';
import '../../Ui/Pages/HomeScreen.dart';
import '../../Ui/Pages/LandingScreen.dart';
import '../../Ui/Pages/LoginScreen.dart';
import '../../Ui/Pages/change_current_password.dart';
import '../../Ui/Pages/change_password.dart';
import '../../Ui/Pages/Role_stationsTeam/car_parking_penality/images_car_parking_penality.dart';
import '../../Ui/Pages/Role_stationsTeam/homescreen_issue_screen.dart';
import '../../Ui/Pages/Role_stationsTeam/station_screen.dart';
import '../../Ui/Pages/Role_stationsTeam/stations_list_screen.dart';
import '../../Ui/Pages/verify_otp.dart';
import '../../Ui/Pages/SplashScreen.dart';

@MaterialAutoRouter(
    routes: (<AutoRoute>[
  MaterialRoute(page: SplashScreen, initial: true),
  MaterialRoute(page: LandingScreen),
  MaterialRoute(page: LoginScreen),
  MaterialRoute(page: ForgotPassword),
  MaterialRoute(page: StationsListScreen),
  MaterialRoute(page: PcnLookupList),
  MaterialRoute(page: StationScreen),
  MaterialRoute(page: UnPaidFareIssueMain),
  MaterialRoute(page: CarParkingPenalityMain),
  MaterialRoute(page: Homescreen),
  MaterialRoute(page: ChangeCurrentPassword),
  MaterialRoute(page: CurrentLocationScreen),
  MaterialRoute(page: VerifyOtpWidget),
  MaterialRoute(page: TrainTeamMain),
  MaterialRoute(page: TrainSelection),
  MaterialRoute(page: ChangePasswordWidget),
  MaterialRoute(page: CarParkingPenalityIImages),
]))
class $AppRouter {}

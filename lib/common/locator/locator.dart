import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:railpaytro/main.dart';
import '../router/router.gr.dart';
import 'locator.config.dart';

final locator = GetIt.instance;

@injectableInit
Future<void> setupLocator() async {
  _init(locator);
  $initGetIt(locator);
}

Future<void> _init(GetIt locator) async {
  locator.registerLazySingleton<AppRouter>(() => AppRouter(navigatorKey));
}

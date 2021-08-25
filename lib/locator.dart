import 'package:get_it/get_it.dart';
import 'package:nirmitee/core/services/calender_client.dart';
import 'package:nirmitee/core/view_models/auth_view_model.dart';
import 'package:nirmitee/core/view_models/calender_view_model.dart';

import 'core/services/api.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => AuthViewModel());
  locator.registerLazySingleton(() => CalenderViewModel());
  locator.registerLazySingleton(() => CalendarClient());
}

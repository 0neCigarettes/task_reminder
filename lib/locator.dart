import 'package:get_it/get_it.dart';
import 'package:task_reminder/services/alert_service.dart';
import 'package:task_reminder/services/navigation_service.dart';
import 'package:task_reminder/services/notification_service.dart';
import 'package:task_reminder/services/schedule_reminder_service.dart';
import 'package:task_reminder/services/shared_preference_service.dart';

GetIt locator = GetIt.instance;
void setUpLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => SharedPreferenceService());
  locator.registerLazySingleton(() => NotificationService());
  locator.registerLazySingleton(() => AlertService());
  locator.registerLazySingleton(() => ScheduleReminderService());
}

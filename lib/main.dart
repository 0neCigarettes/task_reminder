import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:task_reminder/locator.dart';
import 'package:task_reminder/routes/route_name.dart';
import 'package:task_reminder/routes/router.dart';
import 'package:task_reminder/services/background_service.dart';
import 'package:task_reminder/services/navigation_service.dart';
import 'package:task_reminder/services/notification_service.dart';
import 'package:task_reminder/views/start_up_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await NotificationService().initialize();
  await initializeBackroundService();
  setUpLocator();
  runZoned(() {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AwesomeNotifications().actionStream.listen((action) async {
      await FlutterRingtonePlayer.stop();
      locator<NavigationService>().replaceToCurrentRoute(homeView);
    });
    return MaterialApp(
      title: 'Task Reminder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartUpView(),
      onGenerateRoute: generateRoute,
      navigatorKey: locator<NavigationService>().navigationKey,
      debugShowCheckedModeBanner: false,
    );
  }
}

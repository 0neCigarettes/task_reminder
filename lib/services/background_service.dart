import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:task_reminder/services/schedule_reminder_service.dart';
import 'package:task_reminder/services/shared_preference_service.dart';

Future<void> initializeBackroundService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: false,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: false,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
  // service.startService();
}

// to ensure this executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();

  return true;
}

void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  if (service is AndroidServiceInstance) {
    service.setForegroundNotificationInfo(
      title: "Arsi",
      content: "Aplikasi reminder presensi aktif ",
    );

    // service.setAutoStartOnBootMode(true);
  }

  Timer.periodic(const Duration(seconds: 10), (timer) async {
    // print("Periodic : ${DateTime.now().toString()}");
    final TimeOfDay nowTOD = TimeOfDay.now();

    await SharedPreferenceService().getBool('isSnooze').then((value) async {
      if (value == null) {
        await SharedPreferenceService().setBool('isSnooze', false);
      }
    });

    await SharedPreferenceService()
        .getBool('isMorningPresent')
        .then((value) async {
      if (value == null) {
        await SharedPreferenceService().setBool('isMorningPresent', false);
      }
    });

    await SharedPreferenceService()
        .getBool('isAfternoonPresent')
        .then((value) async {
      if (value == null) {
        await SharedPreferenceService().setBool('isAfternoonPresent', false);
      }
    });

    bool isMorningPresent =
        await SharedPreferenceService().getBool('isMorningPresent') ?? false;

    // print("isMorningPresent: $isMorningPresent");

    bool isAfternoonPresent =
        await SharedPreferenceService().getBool('isAfternoonPresent') ?? false;
    // print("isAfternoonPresent: $isAfternoonPresent");

    bool isSnooze =
        await SharedPreferenceService().getBool('isSnooze') ?? false;
    // print("isSnooze: $isSnooze");

    await ScheduleReminderService().resetSchedule(timeOfDay: nowTOD);

    if (isSnooze && !isMorningPresent) {
      Timer(Duration(minutes: 5), () async {
        //reset Snooze after 5 minutes
        await SharedPreferenceService().setBool('isSnooze', false);
        // print("Snooze reset");

        //absen pagi
        await ScheduleReminderService().scheduleMorningPresent(
            isMorningPresent: isMorningPresent, timeOfDay: nowTOD);
      });
    } else {
      //absen pagi
      await ScheduleReminderService().scheduleMorningPresent(
          isMorningPresent: isMorningPresent, timeOfDay: nowTOD);
    }

    if (isSnooze && !isAfternoonPresent) {
      Timer(Duration(minutes: 5), () async {
        //reset Snooze after 5 minutes
        await SharedPreferenceService().setBool('isSnooze', false);
        // print("Snooze reset");

        //absen siang
        await ScheduleReminderService().scheduleAfternoonPresent(
            isAfternoonPresent: isAfternoonPresent, timeOfDay: nowTOD);
      });
    } else {
      //absen sore
      await ScheduleReminderService().scheduleAfternoonPresent(
          isAfternoonPresent: isAfternoonPresent, timeOfDay: nowTOD);
    }

    service.invoke(
      'start',
      {
        "current_date": DateTime.now().toIso8601String(),
        "device": 'Android',
      },
    );
  });
}

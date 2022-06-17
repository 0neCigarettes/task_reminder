import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:task_reminder/helpers/functions_helper.dart';
import 'package:task_reminder/services/notification_service.dart';
import 'package:task_reminder/services/shared_preference_service.dart';
import 'package:vibration/vibration.dart';

class ScheduleReminderService extends ChangeNotifier {
  final presentSchedule = {
    "morning_present": {"sH": 08, "sM": 00, "eH": 09, "eM": 00},
    "afternoon_present": {"sH": 17, "sM": 00, "eH": 21, "eM": 00}
  };

  final List<int> pattern = [0, 1000, 500, 1000, 500, 1000, 500, 1000];

  final String sourceRingtone = "assets/sounds/arsi_ringtone.mp3";

  Future<void> resetSchedule({required TimeOfDay timeOfDay}) async {
    if ((parseTimeToDouble(timeOfDay) >
        parseTimeToDouble(TimeOfDay(
            hour: presentSchedule['morning_present']!['eH']!,
            minute: presentSchedule['morning_present']!['eH']!)))) {
      await SharedPreferenceService().setBool('isMorningPresent', false);
      // print("morning present reseted");
    }
    if ((parseTimeToDouble(timeOfDay) >
        parseTimeToDouble(TimeOfDay(
            hour: presentSchedule['afternoon_present']!['eH']!,
            minute: presentSchedule['afternoon_present']!['eH']!
            // hour: 05,
            // minute: 07
            )))) {
      await SharedPreferenceService().setBool('isAfternoonPresent', false);
      // print("afternoon present reseted");
    }
    notifyListeners();
  }

  Future<void> scheduleMorningPresent(
      {required bool isMorningPresent, required TimeOfDay timeOfDay}) async {
    if ((parseTimeToDouble(timeOfDay) >
            parseTimeToDouble(TimeOfDay(
                hour: presentSchedule['morning_present']!['sH']!,
                minute: presentSchedule['morning_present']!['sM']!))) &&
        (parseTimeToDouble(timeOfDay) <=
            parseTimeToDouble(TimeOfDay(
                hour: presentSchedule['morning_present']!['eH']!,
                minute: presentSchedule['morning_present']!['eH']!))) &&
        (isMorningPresent == false)) {
      await NotificationService().createNotification(
          id: 1,
          title: 'Pengingat presensi pagi !',
          body: 'Sudah presensi pagi ini ?',
          ticker: 'ARSI !,  Sudah presensi pagi ini ?');
      Vibration.vibrate(pattern: pattern);
      await FlutterRingtonePlayer.play(
          fromAsset: sourceRingtone,
          volume: 1.0,
          looping: false,
          asAlarm: true);
      Timer(Duration(seconds: 8), () async {
        await FlutterRingtonePlayer.stop();
      });

      // print(
      //     "compare time morning ${(parseTimeToDouble(timeOfDay) >= parseTimeToDouble(TimeOfDay(hour: presentSchedule['morning_present']!['sH']!, minute: presentSchedule['morning_present']!['sM']!))) && (parseTimeToDouble(timeOfDay) <= parseTimeToDouble(TimeOfDay(hour: presentSchedule['morning_present']!['eH']!, minute: presentSchedule['morning_present']!['eH']!))) && (isMorningPresent == false)}");
    }
    notifyListeners();
  }

  Future<void> scheduleAfternoonPresent(
      {required bool isAfternoonPresent, required TimeOfDay timeOfDay}) async {
    if ((parseTimeToDouble(timeOfDay) >
            parseTimeToDouble(TimeOfDay(
                hour: presentSchedule['afternoon_present']!['sH']!,
                minute: presentSchedule['afternoon_present']!['sM']!))) &&
        (parseTimeToDouble(timeOfDay) <=
            parseTimeToDouble(TimeOfDay(
                hour: presentSchedule['afternoon_present']!['eH']!,
                minute: presentSchedule['afternoon_present']!['eH']!))) &&
        (isAfternoonPresent == false)) {
      await NotificationService().createNotification(
          id: 2,
          title: 'Pengingat presensi sore !',
          body: 'Sudah presensi sore ini ?',
          ticker: 'ARSI !,  Sudah presensi sore ini ?');
      Vibration.vibrate(pattern: pattern);
      await FlutterRingtonePlayer.play(
          fromAsset: sourceRingtone,
          volume: 1.0,
          looping: false,
          asAlarm: true);

      Timer(Duration(seconds: 8), () async {
        await FlutterRingtonePlayer.stop();
      });

      // print("tod : ${parseTimeToDouble(timeOfDay)}");
      // print(
      //     "compare : ${parseTimeToDouble(TimeOfDay(hour: presentSchedule['afternoon_present']!['eH']!, minute: presentSchedule['afternoon_present']!['eH']!))}");

      // print(
      //     "compare time afternoon_present:  ${(parseTimeToDouble(timeOfDay) >= parseTimeToDouble(TimeOfDay(hour: presentSchedule['afternoon_present']!['sH']!, minute: presentSchedule['afternoon_present']!['sM']!))) && (parseTimeToDouble(timeOfDay) <= parseTimeToDouble(TimeOfDay(hour: presentSchedule['afternoon_present']!['eH']!, minute: presentSchedule['afternoon_present']!['eH']!))) && (isAfternoonPresent == false)}");
      notifyListeners();
    }
  }
}

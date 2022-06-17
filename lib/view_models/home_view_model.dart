import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_reminder/locator.dart';
import 'package:task_reminder/services/schedule_reminder_service.dart';
import 'package:task_reminder/services/shared_preference_service.dart';
import 'package:task_reminder/view_models/base_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeViewModel extends BaseViewModel {
  final SharedPreferenceService _prefs = locator<SharedPreferenceService>();
  // final NavigationService _navigationService = locator<NavigationService>();
  // final AlertService _alertService = locator<AlertService>();
  final ScheduleReminderService _scheduleReminderService =
      locator<ScheduleReminderService>();

  bool switchVal = false;
  String LoadingText = 'Loading...';
  String toastMessage = '';

  double parseTimeToDouble(TimeOfDay time) => time.hour + time.minute / 60.0;

  initViews(BuildContext context) async {
    await _prefs.getBool('isMorningPresent').then((value) async {
      if (value != null) {
        await _prefs.setBool('isMorningPresent', false);
        print("Presensi pagi: ${await _prefs.getBool('isMorningPresent')}");
      }
    });

    await _prefs.getBool('isAfternoonPresent').then((value) async {
      if (value != null) {
        await _prefs.setBool('isAfternoonPresent', false);
        print("Presensi sore: ${await _prefs.getBool('isAfternoonPresent')}");
      }
    });
    await getStatusService();
  }

  getStatusService() async {
    setBusy(true);
    await _prefs.setBool('backgroundServiceStatus',
        await FlutterBackgroundService().isRunning());
    switchVal = await _prefs.getBool('backgroundServiceStatus') ?? false;
    setBusy(false);
  }

  onPowerClick() async {
    setBusy(true);
    final service = await FlutterBackgroundService();
    var isRunning = await service.isRunning();

    if (!isRunning) {
      LoadingText = 'Menghidupkan reminder presensi...';
      setBusy(true);
      await service.startService();
      await _prefs.setBool('backgroundServiceStatus', true);
      toastMessage = 'Reminder presensi diaktifkan';
    }

    if (isRunning) {
      LoadingText = 'Mematikan reminder presensi...';
      setBusy(true);
      service.invoke("stopService");
      await _prefs.setBool('backgroundServiceStatus', false);
      toastMessage = 'Reminder presensi dimatikan';
    }

    Timer(Duration(seconds: 5), () async {
      await getStatusService();
      showToast(toastMessage);
      setBusy(false);
    });
  }

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blueGrey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  onAbsentClick(BuildContext context) async {
    setBusy(true);
    LoadingText = 'Memuat permintaan...';
    final service = await FlutterBackgroundService();
    var isRunning = await service.isRunning();
    bool isMorningPresent = await _prefs.getBool('isMorningPresent') ?? false;

    bool isAfternoonPresent =
        await _prefs.getBool('isAfternoonPresent') ?? false;

    if (isRunning) {
      //setMorningPresent: true
      if ((parseTimeToDouble(TimeOfDay.now()) >=
              parseTimeToDouble(TimeOfDay(
                  hour: _scheduleReminderService
                      .presentSchedule['morning_present']!['sH']!,
                  minute: _scheduleReminderService
                      .presentSchedule['morning_present']!['sM']!))) &&
          (parseTimeToDouble(TimeOfDay.now()) <=
              parseTimeToDouble(TimeOfDay(
                  hour: _scheduleReminderService
                      .presentSchedule['morning_present']!['eH']!,
                  minute: _scheduleReminderService
                      .presentSchedule['morning_present']!['eM']!))) &&
          (isMorningPresent == false)) {
        await _prefs.setBool('isMorningPresent', true);
        service.invoke("stopService");
        toastMessage = 'Berhasil presensi pagi';
      } else if ((parseTimeToDouble(TimeOfDay.now()) >=
              parseTimeToDouble(TimeOfDay(
                  hour: _scheduleReminderService
                      .presentSchedule['morning_present']!['sH']!,
                  minute: _scheduleReminderService
                      .presentSchedule['morning_present']!['sM']!))) &&
          (parseTimeToDouble(TimeOfDay.now()) <=
              parseTimeToDouble(TimeOfDay(
                  hour: _scheduleReminderService
                      .presentSchedule['morning_present']!['eH']!,
                  minute: _scheduleReminderService
                      .presentSchedule['morning_present']!['eM']!))) &&
          isMorningPresent) {
        toastMessage = 'Anda sudah presensi pagi ini';
      } else if ((parseTimeToDouble(
                  TimeOfDay.now()) >= //setAfternoonPresent: true
              parseTimeToDouble(TimeOfDay(
                  hour: _scheduleReminderService
                      .presentSchedule['afternoon_present']!['sH']!,
                  minute: _scheduleReminderService
                      .presentSchedule['afternoon_present']!['sM']!))) &&
          (parseTimeToDouble(TimeOfDay.now()) <=
              parseTimeToDouble(TimeOfDay(
                  hour: _scheduleReminderService
                      .presentSchedule['afternoon_present']!['eH']!,
                  minute: _scheduleReminderService
                      .presentSchedule['afternoon_present']!['eM']!))) &&
          (isAfternoonPresent == false)) {
        await _prefs.setBool('isAfternoonPresent', true);

        service.invoke("stopService");
        toastMessage = 'Berhasil presensi sore';
      } else if ((parseTimeToDouble(TimeOfDay.now()) >=
              parseTimeToDouble(TimeOfDay(
                  hour: _scheduleReminderService
                      .presentSchedule['afternoon_present']!['sH']!,
                  minute: _scheduleReminderService
                      .presentSchedule['afternoon_present']!['sM']!))) &&
          (parseTimeToDouble(TimeOfDay.now()) <=
              parseTimeToDouble(TimeOfDay(
                  hour: _scheduleReminderService
                      .presentSchedule['afternoon_present']!['eH']!,
                  minute: _scheduleReminderService
                      .presentSchedule['afternoon_present']!['eM']!))) &&
          isAfternoonPresent) {
        toastMessage = 'Anda sudah presensi sore ini';
      } else if ((parseTimeToDouble(TimeOfDay.now()) <=
          parseTimeToDouble(TimeOfDay(
              hour: _scheduleReminderService
                  .presentSchedule['morning_present']!['sH']!,
              minute: _scheduleReminderService
                  .presentSchedule['morning_present']!['sM']!)))) {
        toastMessage = 'Jadwal presensi pagi belum dimulai';
      } else if ((parseTimeToDouble(TimeOfDay.now()) >=
          parseTimeToDouble(TimeOfDay(
              hour: _scheduleReminderService
                  .presentSchedule['afternoon_present']!['eH']!,
              minute: _scheduleReminderService
                  .presentSchedule['afternoon_present']!['eM']!)))) {
        toastMessage = 'Jadwal presensi harian sudah berakhir';
      }

      Timer(Duration(seconds: 5), () async {
        await service.startService();
        setBusy(false);
        showToast(toastMessage);
      });
    } else {
      showToast('Aktifkan reminder presensi terlebih dahulu !');
      setBusy(false);
    }
  }

  onLinkPresentClick(BuildContext context) async {
    LoadingText = '...';
    LoadingText = 'Membuka Kelola Tugas...';
    setBusy(true);
    final service = await FlutterBackgroundService();
    final isRunning = await service.isRunning();

    bool? isMorningPresent = await _prefs.getBool('isMorningPresent') ?? false;

    bool? isAfternoonPresent =
        await _prefs.getBool('isAfternoonPresent') ?? false;

    if (isRunning) {
      service.invoke("stopService");
      if (!isMorningPresent || !isAfternoonPresent) {
        await _prefs.setBool('isSnooze', true);
      }
      Timer(Duration(seconds: 5), () async {
        final Uri _url = Uri.parse('https://m.kelolatugas.bpk.go.id');
        if (!await canLaunchUrl(_url)) {
          showToast('Tidak dapat membuka link');
        } else {
          await launchUrl(_url, mode: LaunchMode.externalApplication);
        }
        await service.startService();
        setBusy(false);
      });
    } else {
      showToast('Aktifkan reminder presensi terlebih dahulu !');
      setBusy(false);
    }
  }
}

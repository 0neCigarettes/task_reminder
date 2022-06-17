import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:task_reminder/views/shared/ui_colors.dart';

class NotificationService {
  Future<void> initialize() async {
    await AwesomeNotifications().initialize('resource://drawable/notif_icon', [
      NotificationChannel(
        channelGroupKey: 'ARSI',
        channelKey: 'ARSI',
        channelName: 'ARSI',
        channelDescription: 'Aplikasi Reminder Presensi',
        defaultColor: InfoColor,
        importance: NotificationImportance.Max,
        channelShowBadge: false,
        locked: true,
        playSound: false,
        criticalAlerts: true,
        // soundSource: 'resource://raw/arsi_ringtone',
        // vibrationPattern: lowVibrationPattern
      ),
    ]);
  }

  Future<void> createNotification({
    required int id,
    String channelKey = 'ARSI',
    String groupKey = 'ARSI',
    required String title,
    required String body,
    String ticker = 'Reminder Presensi!, silahakan lakukan presensi',
  }) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: id,
            channelKey: channelKey,
            groupKey: groupKey,
            title: title,
            body: body,
            ticker: ticker,
            wakeUpScreen: true,
            category: NotificationCategory.Alarm,
            locked: true,
            showWhen: true));
  }
}

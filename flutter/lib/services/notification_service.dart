import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder_app/main.dart';
import 'package:timezone/timezone.dart';

class NotificationService {
  showNotification(String text, DateTime selectedDateTime) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "reminder-notification",
      "Reminder App",
      priority: Priority.max,
      importance: Importance.max,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    var scheduleDateTime =
        TZDateTime.from(selectedDateTime, getLocation("Asia/Kolkata"));

    await notificationsPlugin.zonedSchedule(
      0,
      "Reminder",
      text,
      scheduleDateTime,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
    );
  }
}

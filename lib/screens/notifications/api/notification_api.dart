import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:rxdart/rxdart.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails('channel id', 'channeel name',
          importance: Importance.max),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    // _notifications.initialize(InitializationSettings(
    //     android: AndroidInitializationSettings('drawable/app_icon')));
    return _notifications.show(
      id,
      title,
      body,
      await _notificationDetails(),
      payload: payload,
    );
  }

  static Future init({bool initScheduled = false}) async {
    _notifications.initialize(
        InitializationSettings(
            android: AndroidInitializationSettings('drawable/app_icon')),
        onSelectNotification: (payload) async {
      onNotifications.add(payload);
    });

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Asia/Kolkata"));
  }

  static Future showTimerNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payload,
      required TimeOfDay selectedTime}) async {
    return _notifications.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(
        Duration(
            hours: selectedTime.hour - TimeOfDay.now().hour,
            minutes: selectedTime.minute - TimeOfDay.now().minute),
      ),
      await _notificationDetails(),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}

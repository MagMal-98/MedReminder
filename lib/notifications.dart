import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  BuildContext _context;

  Future<FlutterLocalNotificationsPlugin> initNotifies(
      BuildContext context) async {
    this._context = context;
    //-----------------------------| Inicialize local notifications |--------------------------------------
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('lavender_dot');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    return flutterLocalNotificationsPlugin;
    //======================================================================================================
  }

  //---------------------------------| Show the notification in the specific time |-------------------------------
  Future showNotification(String title, String description, DateTime scheduledDate, int id,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    await flutterLocalNotificationsPlugin.schedule(
      id.toInt(),
      title,
      description,
      scheduledDate,
      const NotificationDetails(
          AndroidNotificationDetails(
              'medicines_id', 'medicines', 'medicines_notification_channel',
              importance: Importance.High,
              priority: Priority.High,
              color: Colors.cyanAccent),
          IOSNotificationDetails(
              presentAlert: true, presentBadge: true, presentSound: true)),
      androidAllowWhileIdle: true,
    );
    //uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  //================================================================================================================

  //-------------------------| Cancel the notify |---------------------------
  Future removeNotify(int notifyId,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    try {
      return await flutterLocalNotificationsPlugin.cancel(notifyId);
    } catch (e) {
      return null;
    }
  }

  //==========================================================================

  //-------------| function to inicialize local notifications |---------------------------
  Future onSelectNotification(String payload) async {
    showDialog(
      context: _context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }
//======================================================================================

}

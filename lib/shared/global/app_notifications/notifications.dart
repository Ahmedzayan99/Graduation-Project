import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class NotifyHelper
{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Future<void> init() async {
    AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();

    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    var initializationSettings = InitializationSettings(

        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);


    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

       Timer.periodic( Duration(seconds: 50), (timer) async {
      await showNotification();
     });
      // onSelectNotification: selectNotification
  }

  Future showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true,
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

  //  var scheduledNotificationDateTime = DateTime(2023,5,8,10,29);

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      1,
      'نذكرك بتمرين اليوم',
      '',
      platformChannelSpecifics,

    );
  }
}


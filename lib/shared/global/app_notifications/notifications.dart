import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class NotifyHelper
{
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  Future<void> init() async {

    AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);

    _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();


     initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
/*  Timer.periodic( Duration(seconds: 50), (timer) async {
      await
    });*/
   // onSelectNotification: selectNotification;
  }
  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  }
  Future<void> showNotification(RemoteMessage message) async {

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    var iosPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title,
        message.notification!.body,
        platformChannelSpecifics,
        payload: message.data['taskId']);
  }


/*  Future showNotification() async {
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
  }*/
}




/*for (int i=0 ; i < scheduledNotificationDataTimes.length;i++){
      print('object222222222222222');
      showNotification();
    }
       Timer.periodic( Duration(seconds: 50), (timer) async {
      await showNotification();
     });
      // onSelectNotification: selectNotification
  }
  void deleteNotification({required int taskId}) async
  {
    await flutterLocalNotificationsPlugin.cancel(taskId);
  }

  showNotification({required String title, required String body}) async {
    if (kDebugMode) {
      print("doing test");
    }
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
       ticker: 'ticker',
       playSound: true,);
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'MoaaZ Task',
      'Meeting MoaaZ !',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  scheduledNotification({
    required int hour,
    required int minutes,
    required  Task tasks,
    required int id,}) async {
    var startTime = DateFormat('hh:mm a',).format(tasks.storage as DateTime);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        'Task Time!',
        '$startTime, ${tasks.time}',
        _convertTime(hour, minutes, tasks),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id',
                'your channel name',
                channelDescription:'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime
    );

  }

}







*/
/*  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) => const CupertinoAlertDialog(
        title: Text('Notification'),
        content: Text('Go to Another Screen'),
      ),
    );
  }*//*


  tz.TZDateTime _convertTime(int? hour, int? minutes, Task task)
  {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime handleDateTime = tz.TZDateTime(tz.local, task.date! as int , task.date! as int, task.date! as int, hour!, minutes!);
    if(handleDateTime.isBefore(now) && handleDateTime.isAfter(now))
    {
      handleDateTime = handleDateTime.add(const Duration(days: 1));
    }
    return handleDateTime;
  }

  Future<void> _configurationLocalTimeZone()async
  {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }
*/


// ignore_for_file: prefer_const_constructors, avoid_print
import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:blackgym/app.dart';
import 'package:blackgym/modules/login_register/homeSignup.dart';
import 'package:blackgym/shared/bloc_observer.dart';
import 'package:blackgym/shared/global/app_notifications/notifications.dart';
import 'package:blackgym/shared/network/local/cache_helper.dart';
import 'package:blackgym/shared/network/remote/dio_helper.dart';
import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'modules/gym.dart';
import 'package:flutter_svg/svg.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('_firebaseMessagingBackgroundHandler');
  print(message.data.toString());
  Fluttertoast.showToast(
    msg: "on Messaging Background:",
    backgroundColor: Colors.green,
    textColor: Colors.black,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().then((value) {
    print('FIRRRRRRRRRRRRRRRRRR');
  });
  var tokeni = FirebaseMessaging.instance.getToken();
  print(tokeni.toString());
  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());
    Fluttertoast.showToast(
      msg: "onMessage:",
      backgroundColor: Colors.white,
      textColor: Colors.black,
    );
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('oonMessageOpenedApp');
    print(event.data.toString());
    Fluttertoast.showToast(
      msg: "oonMessageOpenedApp:",
      backgroundColor: Colors.white,
      textColor: Colors.black,
    );
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  await CacheHelper.init();
  await NotifyHelper().init().then((value){
    print('Start NotifyHelper');
  }).catchError((Error){
    print('Error NotifyHelper${Error.toString()}');
  });
  // bool? onBoarding = CacheHelper.getDataIntoShPre(key: 'Onboarding');
  var lang = CacheHelper.getDataIntoShPre(key: 'Lang');
  var token = CacheHelper.getDataIntoShPre(key: 'token');
  var userModel = CacheHelper.getDataIntoShPre(key: 'userModel');

  if (lang != null) {
    lang = lang;
  } else {
    lang = 'en';
  }
  late Widget widget;
  if (token != null) {
    widget = NewLayout();
    print(userModel);
  } else {
    widget = AnimatedSplashScreen(
      splashIconSize: 160,
      duration: 4000,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: ColorsManager.primary,
      nextScreen:  HomeSignUpScreen(),
      splash:SvgPicture.asset(
          'assets/images/Logo.svg'
      ),
    );
       // alignment: AlignmentDirectional.center
  }
  //FirebaseAuth.instance.authStateChanges().listen((user) {
  //if (user == null) {
  //    initialRoute = loginScreen;
  //   } else {
  //   initialRoute = newLayout;
  //  }
  //});
  runApp(MyApp(
    //appRouter: AppRouter()
    startWidget: widget,
    lang: lang,
    //token: token,
  ));
}

/*
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbHelper = DatabaseHelper.instance;
  final taskController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  void dispose() {
    taskController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  void _insertTask() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnTask: taskController.text,
      DatabaseHelper.columnDate: dateController.text,
      DatabaseHelper.columnTime: timeController.text
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
    _scheduleNotification();
    setState(() {
      taskController.clear();
      dateController.clear();
      timeController.clear();
    });
  }

  Future<void> _scheduleNotification() async {
    var scheduledNotificationDateTime = DateTime.parse(
        '${dateController.text} '
            '${timeController.text}'); // convert date and time strings to DateTime obj
// ect
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id',
        'your channel name',
       channelDescription:  'your channel description',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Task Reminder',
        '${taskController.text} is due at ${timeController.text}',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: taskController,
                decoration: InputDecoration(
                  hintText: 'Enter task name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: dateController,
                decoration: InputDecoration(
                  hintText: 'Enter date (YYYY-MM-DD)',
                ),
                onTap: ()
                {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.parse('2025-05-05'),
                  ).then((value) {
                    dateController.text=DateFormat.yMMMd().format(value!);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: timeController,
                decoration: InputDecoration(
                  hintText: 'Enter time (HH:MM)',
                ),
                onTap: () {
                  showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now())
                      .then((value){
                    timeController.text = value!.format(context).toString();
                  });
                },

              ),
            ),
            ElevatedButton(
              onPressed: _insertTask,
              child: Text('Add Task'),
            ),
            Expanded(
              child: FutureBuilder(
                future: dbHelper.queryAllRows(),
                initialData: [],
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index]['task']),
                        subtitle: Text(
                            'Due on ${snapshot.data![index]['date']} at ${snapshot.data![index]['time']}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DatabaseHelper {
  static final _databaseName = 'task_manager.db';
  static final _databaseVersion = 1;

  static final table = 'tasks';

  static final columnId = '_id';
  static final columnTask = 'task';
  static final columnDate = 'date';
  static final columnTime = 'time';

  static final DatabaseHelper instance= DatabaseHelper._privateConstructor();

  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String databasePath = await getDatabasesPath();

  //  String path = join(databasePath, _databaseName);
    return await openDatabase(
        'task_manager.db',
        version: 1,
       // path,
       // version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnTask TEXT NOT NULL,
            $columnDate TEXT NOT NULL,
            $columnTime TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

}

*/

// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_null_comparison, prefer_if_null_operators, avoid_types_as_parameter_names

import 'dart:io';

import 'package:blackgym/model/chat_model.dart';
import 'package:blackgym/model/user_model.dart';
import 'package:blackgym/modules/exercises/exercises.dart';
import 'package:blackgym/modules/home/home.dart';
import 'package:blackgym/modules/notas/newTask.dart';
import 'package:blackgym/modules/settings/settings.dart';
import 'package:blackgym/modules/workouts/workouts.dart';
import 'package:blackgym/shared/app_cubit/states.dart';
import 'package:blackgym/shared/network/local/cache_helper.dart';
import 'package:blackgym/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';
class GymCubit extends Cubit<GymStates> {
  GymCubit() : super(GymInitialState());

  static GymCubit get(context) => BlocProvider.of(context);

  //<<<<<<<<<<<<<<<<<Start the cubit of BottomNavigationBar >>>>>>>>>>>>>>>>>>>>>>
  int current = 0;
  List<Widget> screen = [
    const HomeScreen(),
    const ExercisesScreen(),
    WorkoutsScreen(),
    NewTaskScreen(),
    SettingsScreen(),
  ];

  void changeIndex(int index) {
    if (index == 4) {
      getUserData();
    }

    current = index;
    emit(GymChangeBottomNavBarState());
  }

  //<<<<<<<<<<<<<<<<<Start the cubit of page Setting >>>>>>>>>>>>>>>>>>>>>>
  bool myProfile = false;

  void changeBottomProfile() {
    myProfile = !myProfile;
    emit(GymChangeProfileState());
  }

  bool language = false;

  void changeBottomLanguage() {
    language = !language;
    emit(GymChangeLanguageState());
  }

  bool selectLanguage = true;

  void changeBottomSelectLanguage() {
    selectLanguage = !selectLanguage;
    emit(GymInitialState());
  }

  ////////////////////////////////////////////////////////////////////////////////////////

  //<getData>
  double heightInitial = 120;

  void updateHeight({
    required double height,
  }) {
    heightInitial = height;
    print(heightInitial);
    emit(UpdateHeightState());
  }

  double weightInitial = 60;

  void updateWeight({
    required double weight,
  }) {
    weightInitial = weight;
    print(weightInitial);
    emit(UpdateWeightState());
  }

  double ageInitial = 21;

  void updateAge({
    required double age,
  }) {
    ageInitial = age;
    print(ageInitial);
    emit(UpdateAgeState());
  }

  double fatPercentageInitial = 5;

  void updateFatPercentaget({
    required double fatPercentage,
  }) {
    fatPercentageInitial = fatPercentage;
    print(fatPercentageInitial);
    emit(UpdateFatPercentageState());
  }


  File? profileImage;
  var picker = ImagePicker();

  void getProfileImage() async {
    final XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickerSuccessState());
    } else {
      print('no image selected');
      emit(ProfileImagePickerErrorState());
    }
  }

  Future<void> uploadProfileImage() async {
    emit(UploadProfileImageLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL()
          .then((value) {
        updateProfileImage(
            image: value
        );
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  void updateProfileImage({
    String? image,
  }) {
    UserModel model = UserModel(
      image: image,
      name: userModel?.name,
      email: userModel?.email,
      phone: userModel?.phone,
      height: userModel?.height,
      age: userModel?.age,
      uId: userModel?.uId,
      fatPercentage: userModel?.fatPercentage,
      weight: userModel?.weight,
      gender: userModel?.gender,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      profileImage = null;
      getUserData();
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }

  void updateUserBady({
    String? height,
    String? age,
    String? fatPercentage,
    String? weight,
  }) async {
    UserModel model = UserModel(
      name: userModel?.name,
      email: userModel?.email,
      phone: userModel?.phone,
      uId: userModel?.uId,
      image: userModel?.image,
      gender: userModel?.gender,
      height: '${ageInitial.round()}',
      age: '${ageInitial.round()}',
      fatPercentage: '${fatPercentageInitial.round()}',
      weight: '${weightInitial.round()}',

    );
    emit(UpdateUserBadyLoadingState());

    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      print("yessssss");
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }

  void updateName({
    required String name,
  }) async {
    UserModel model = UserModel(
      name: name,
      email: userModel?.email,
      phone: userModel?.phone,
      height: userModel?.height,
      image: userModel?.image,
      age: userModel?.age,
      uId: userModel?.uId,
      fatPercentage: userModel?.fatPercentage,
      weight: userModel?.weight,
      gender: userModel?.gender,
    );
    emit(UpdateNameLoadingState());
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      print("yessssss");
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }

  UserModel? userModel;

  Future<void> getUserData() async {
    emit(GetUserLoadingState());
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(CacheHelper.getDataIntoShPre(key: "uId"))
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data()!);
      print("Bishooooooo $userModel");
      emit(GetUserSuccessState());
    }).catchError((error) {
      emit(GetUserErrorState(error.toString()));
      print(error);
    });
  }


//

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    CacheHelper.removeUserData(key: 'uId');
  }


  List<String> dropDownButton = [
    'ar',
    'en',
  ];
  String lang = 'en';

  void changeLanguage({required String languageCode}) {
    if (languageCode.isNotEmpty) {
      lang = languageCode;
    } else {
      lang = lang;
    }
    CacheHelper.saveData(key: 'Lang', value: lang).then((value) {
      emit(ChangeAppModeState());
    });
  }

  void confirmPasswordReset() {
    FirebaseAuth
        .instance
        .confirmPasswordReset(
        code: '1112',
        newPassword: '11111111')
        .then((value) {
      print('sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
    })
        .catchError((error) {
      print(
          'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      print(error.toString());
    });
  }

  //<<<<<<<<<<<<<<<<<Start the cubit of BottomSheet >>>>>>>>>>>>>>>>>>>>>>

  bool isBottomSheet = false;
  IconData iconShow = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheet = isShow;
    iconShow = icon;
    emit(ChangeBottomSheetState());
  }

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  void createDatabase() {
    print('Start **********************************');
    openDatabase(
      'GymApp.db',
      version: 1,
      onCreate: (database, version) {
        print('DataBase Created ------------------------------------');
        database.execute(
            'CREATE TABLE task (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)'
        )
            .then((value) {
          print('Table Created ====================================');
        }).catchError((error) {
          print('error when ${error.toString()}');
        });
      },
      onOpen: (database) {
        getFromDatabase(database);
        print('DataBase Opened ________________________________________');
      },
    ).then((value) {
      database = value;
      emit(CreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async
    {
      await txn
          .rawInsert(
          'INSERT INTO task (title, date, time, status) VALUES("$title", "$date", "$time", "new")'
      )
          .then((value) {
        print(' insert successfully');
        emit(InsertDatabaseState());
        getFromDatabase(database);
      })
          .catchError((error) {
        print('when error${error.toString()}');
      });
    });
  }

  getFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    emit(GetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM task').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        }

        else if (element['status'] == 'done') {
          doneTasks.add(element);
        }

        else {
          archiveTasks.add(element);
        }
      });
      emit(GetDatabaseState());
    });
  }

  void updateToDatabase({
    required String status,
    required int id,
  }) {
    database.rawUpdate(
        'UPDATE task SET status = ? WHERE id = ?',
        [status, id])
        .then((value) {
      getFromDatabase(database);
      emit(UpdateDatabaseState());
    });
  }

  void deleteFromDatabase({
    required id,
  }) {
    database
        .rawDelete('DELETE FROM task WHERE id = ?', [id])
        .then((value) {
      getFromDatabase(database);
      emit(DeleteDatabaseState());
    });
  }

  late List<plays> amed = [
    plays(image: 'assets/images/gym.jpg',
      uId: '',
      set: 4,),
    plays(image: 'assets/images/gym.jpg',
      uId: '',
      set: 2,),
    plays(image: 'assets/images/gym.jpg',
      uId: '',
      set: 1,),
    plays(image: 'assets/images/gym.jpg',
      uId: '',
      set: 2,)
  ];

  List<Plan> plans =[
    Plan(
        date:DateTime(2023,4,20,0,0,0,0,0) ,
        uId:'ssss',
        play: [
          plays(
            uId: 'sss',
            image:'assets/images/SITUP exercise.png',
            set: 2,
          ),
          plays(
            uId: 'sss',
            image:'assets/images/SITUP exercise.png',
            set: 2,
          ),
          plays(
            uId: 'sss',
            image:'assets/images/SITUP exercise.png',
            set: 2,
          ),
          plays(
            uId: 'sss',
            image:'assets/images/SITUP exercise.png',
            set: 2,
          ),
        ]
    ),
    Plan(
        date:DateTime(2023,4,20,0,0,0,0,0) ,
        uId:'ssss',
        play: [
          plays(
            uId: 'sss',
            image:'assets/images/SITUP exercise.png',
            set: 2,
          ),
          plays(
            uId: 'sss',
            image:'assets/images/SITUP exercise.png',
            set: 2,
          ),
          plays(
            uId: 'sss',
            image:'assets/images/SITUP exercise.png',
            set: 2,
          ),
          plays(
            uId: 'sss',
            image:'assets/images/SITUP exercise.png',
            set: 2,
          ),
        ]
    ),
    Plan(
        date:DateTime(2023,4,20,0,0,0,0,0) ,
        uId:'ssss',
        play: [
          plays(
            uId: 'sss',
            image:'assets/images/SITUP exercise.png',
            set: 2,
          ),
          plays(
            uId: 'sss',
            image:'assets/images/SITUP exercise.png',
            set: 2,
          ),
          plays(
            uId: 'sss',
            image:'assets/images/SITUP exercise.png',
            set: 2,
          ),
          plays(
            uId: 'sss',
            image:'assets/images/SITUP exercise.png',
            set: 2,
          ),
        ]
    ),
    Plan(
        date:DateTime(2023,4,20,0,0,0,0,0) ,
        uId:'ssss',
        play: [
          plays(
            uId: 'sss',
            image:'assets/images/SITUP exercise.png',
            set: 2,
          ),
          plays(
            uId: 'sss',
            image:'assets/images/SITUP exercise.png',
            set: 2,
          ),
          plays(
            uId: 'sss',
            image:'assets/images/SITUP exercise.png',
            set: 2,
          ),
          plays(
            uId: 'sss',
            image:'assets/images/SITUP exercise.png',
            set: 2,
          ),
        ]
    ),
    Plan(
        date:DateTime(2023,4,20,0,0,0,0,0) ,
        uId:'ssss',
        play: [
          plays(
            uId: 'sss',
            image:'assets/images/SITUP exercise.png',
            set: 2,
          ),
          plays(
            uId: 'sss',
            image:'assets/images/SITUP exercise.png',
            set: 2,
          ),
          plays(
            uId: 'sss',
            image:'assets/images/SITUP exercise.png',
            set: 2,
          ),
          plays(
            uId: 'sss',
            image:'assets/images/SITUP exercise.png',
            set: 2,
          ),
        ]
    ),
  ];
}
// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_null_comparison, prefer_if_null_operators

import 'dart:io';

import 'package:blackgym/model/chat_model.dart';
import 'package:blackgym/model/user_model.dart';
import 'package:blackgym/modules/chat/chats.dart';
import 'package:blackgym/modules/exercises/exercises.dart';
import 'package:blackgym/modules/home/home.dart';
import 'package:blackgym/modules/settings/settings.dart';
import 'package:blackgym/modules/workouts/workouts.dart';
import 'package:blackgym/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blackgym/shared/logic/home_logic/states.dart';

class GymCubit extends Cubit<GymStates> {
  GymCubit() : super(GymInitialState());

  static GymCubit get(context) => BlocProvider.of(context);

  //<<<<<<<<<<<<<<<<<Start the cubit of BottomNavigationBar >>>>>>>>>>>>>>>>>>>>>>
  int current = 0;
  List<Widget> screen = [
    const HomeScreen(),
    const ExercisesScreen(),
    const WorkoutsScreen(),
    const ChatScreen(),
    SettingsScreen(),
  ];

  void changeIndex(int index) {
    if (index == 3) {
      getAllUser();
    }
    if(index == 4 ){
      print("BishoIndex $index");
      getUserData();
    }

    current = index;
    emit(GymChangeBottomNavBarState());
  }

  //<<<<<<<<<<<<<<<<<Start the cubit of BottomSheet >>>>>>>>>>>>>>>>>>>>>>
  void changeBottomSheetState({required bool isShow}) {
    emit(GymChangeBottomSheetState());
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
        .child('Users/${Uri.file(profileImage!.path).pathSegments.last}')
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

  void updateProfileImage (
  {
      String? image,
  }){
    UserModel model = UserModel(
      image: image,
      name: userModel?.name,
      email: userModel?.email,
      phone: userModel?.phone,
      height:userModel?.height,
      age:userModel?.age,
      uId: userModel?.uId,
      fatPercentage:userModel?.fatPercentage,
      weight: userModel?.weight,
      gender: userModel?.gender,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
          profileImage=null ;
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
      height:'${ageInitial.round()}',
      age: '${ageInitial.round()}',
      fatPercentage:'${fatPercentageInitial.round()}',
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
    required  String name,
  }) async {
    UserModel model = UserModel(
      name: name,
      email: userModel?.email,
      phone: userModel?.phone,
      height:userModel?.height,
      image:userModel?.image,
      age: userModel?.age,
      uId: userModel?.uId,
      fatPercentage:userModel?.fatPercentage,
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

  List<UserModel> users = [];

  void getAllUser() {
    users = [];
    emit(GetAllUserLoadingState());
    FirebaseFirestore.instance.collection('Users').get().then((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] != userModel!.uId) {
          users.add(UserModel.fromJson(element.data()));
        }
      }
      emit(GetAllUserSuccessState());
    }).catchError((error) {
      emit(GetAllUserErrorState(error.toString()));
      print(error);
    });
  }

  void sendMessage({
    required String receiverId,
    required String dataTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      receiverId: receiverId,
      dataTime: dataTime,
      text: text,
      senderId: userModel!.uId,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessage({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dataTime')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(GetMessageSuccessState());
    });
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
}

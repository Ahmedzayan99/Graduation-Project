// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_null_comparison, prefer_if_null_operators

import 'package:blackgym/model/chat_model.dart';
import 'package:blackgym/model/user_model.dart';
import 'package:blackgym/modules/chat/chats.dart';
import 'package:blackgym/modules/exercises/exercises.dart';
import 'package:blackgym/modules/home/home.dart';
import 'package:blackgym/modules/settings/settings.dart';
import 'package:blackgym/modules/workouts/workouts.dart';
import 'package:blackgym/shared/network/constants.dart';
import 'package:blackgym/shared/network/local/cache_helper.dart';
import 'package:blackgym/shared/styles/iconly_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io' as io;
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
  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(
      icon: Icon(IconlyBroken.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(IconlyBroken.exercise_1),
      label: 'exercises',
    ),
    const BottomNavigationBarItem(
      icon: Icon(IconlyBroken.report),
      label: 'Workouts',
    ),
    const BottomNavigationBarItem(
      icon: Icon(IconlyBroken.chat),
      label: 'Chat',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        IconlyBroken.setting,
      ),
      label: 'settings',
    ),
  ];
  List<Widget> screen = [
    const HomeScreen(),
    const ExercisesScreen(),
    const WorkoutsScreen(),
    const ChatScreen(),
    SettingsScreen(),
  ];

  void changeIndex(int index) {
    if(index ==3 ){
     getAllUser();
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
  String profileImageUrl = '';
  void updateUser({
    String? name,
    String? email,
    String? phone,
    String? height,
    String? age,
    String? image,
    String? fatPercentage,
    String? weight,
    String? gender,
    required String uId,
  }) async {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      isEmailVerified: false,
      height: height,
      image:image,
      age: age,
      uId: uId,
      fatPercentage: fatPercentage,
      weight: weight,
      gender: gender,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }

  UserModel? userModel;

  Future<void> getUserData() async{
    emit(GetUserLoadingState());
  await  FirebaseFirestore.instance.collection('Users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      print("Bishooooooo $userModel");
      emit(GetUserSuccessState());
    }).catchError((error) {
      emit(GetUserErrorState(error.toString()));
      print(error);
    });
  }

  io.File? profileImage;
  var picker = ImagePicker();
  void getProfileImage() async {
    final XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = io.File(pickedFile.path);
      emit(ProfileImagePickerSuccessState());
    } else {
      print('no image selected');
      emit(ProfileImagePickerErrorState());
    }
  }

//

  Future<void> uploadProfileImage() async {
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        print(value);
        emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    CacheHelper.removeUserData(key: 'uId');
  }
  List<UserModel> users=[];
  void getAllUser(){
    users=[];
    emit(GetAllUserLoadingState());
    FirebaseFirestore
        .instance.
    collection('Users').
    get()
        .then((value) {
      value.docs.forEach((element) {
        if(element.data()['uId']!=userModel!.uId)
        users.add(UserModel.fromJson(element.data()));
      });
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
  }){
    MessageModel model =MessageModel(
      receiverId:receiverId,
      dataTime:dataTime,
      text:text,
      senderId:userModel!.uId,
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
    })
        .catchError((error){
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
    })
        .catchError((error){
      emit(SendMessageErrorState());
    });
  }
  List<MessageModel> messages =[];
  void getMessage({
    required String receiverId,
  })
  {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dataTime')
        .snapshots()
        .listen((event) {
      messages =[];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessageSuccessState());
    });
  }
}



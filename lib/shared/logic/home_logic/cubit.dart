// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_null_comparison, prefer_if_null_operators

import 'dart:io' as io;
import 'package:blackgym/shared/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/model/user_model.dart';
import '../../../layout/chats.dart';
import '../../../layout/exercises.dart';
import '../../../layout/home.dart';
import '../../../layout/settings.dart';
import '../../../layout/workouts.dart';
import '../../../shared/network/constants.dart';
import '../../../shared/styles/iconly_broken.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../shared/network/local/cache_helper.dart';

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

  //<<<<<<<<<<<<<<<<<Start the cubit of show Password  >>>>>>>>>>>>>>>>>>>>>>


  IconData iconPasswordLogin = IconlyBroken.hide;
  bool isPasswordLogin = true;

  void changePasswordLoginVisible() {
    isPasswordLogin =! isPasswordLogin;
    isPasswordLogin
        ? iconPasswordLogin = IconlyBroken.hide
        : iconPasswordLogin = Icons.remove_red_eye_rounded;
    emit(GymChangeVisiblePasswordLoginState());

  }

  bool isPasswordRegister = true;
  IconData iconPasswordRegister = IconlyBroken.hide;
  void changePasswordRegisterVisible() {
    isPasswordRegister = !isPasswordRegister;
    isPasswordRegister
        ? iconPasswordRegister = IconlyBroken.hide
        : iconPasswordRegister = Icons.remove_red_eye_rounded;
    emit(GymChangeVisiblePassworRegisterdState());

  }

  //<<<<<<<<<<<<<<<<<Start the cubit of Login by firebase>>>>>>>>>>>>>>>>>>>>>>
  //<Register>
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String height,
    required String age,
    required String fatPercentage,
    required String weight,
    required String gender,
    String? image,
  }) {
    emit(GymRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      createUser(
        gender: gender,
        image: profileImageUrl != null ? profileImageUrl : image,
        name: name,
        email: email,
        uId: value.user!.uid,
        phone: phone,
        height: height,
        age: age,
        fatPercentage: fatPercentage,
        weight: weight,
      );
      userLogin(email: email, password: password);
    }).catchError((error) {
      emit(GymRegisterErrorState(error.toString()));
      print(error);
    });
  }

  //<Login>
  void userSignOut() {
    FirebaseAuth.instance.signOut().then((value) {
      emit(GymSignOutSuccessState());
    }).catchError((error) {
      emit(GymSignOutErrorState());
    });
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(GymLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user?.email);
      emit(GymLoginSuccessState(value.user!.uid));
    }).then((value) {
      emit(GymInitialState());
    }).catchError((error) {
      emit(GymLoginErrorState(error.toString()));
      print(error);
    });
  }

  //<collection>
  void createUser({
    String? name,
    String? email,
    required String uId,
    required String phone,
    required String height,
    required String age,
    String? image,
    required String fatPercentage,
    required String weight,
    required String gender,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      uId: uId,
      phone: phone,
      isEmailVerified: false,
      height: height,
      image:
          "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?size=338&ext=jpg&ga=GA1.1.292155642.1675795923",
      age: age,
      fatPercentage: fatPercentage,
      weight: weight,
      gender: gender,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(GymCreateUserSuccessState(uId));
      getUserData();
    }).catchError((error) {
      emit(GymCreateUserErrorState(error.toString()));
    });
  }

  //<getData>
   UserModel? userModel;

  void getUserData() {
    emit(GymGetUserLoadingState());
    FirebaseFirestore.instance.collection('Users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GymGetUserSuccessState());
    }).catchError((error) {
      emit(GymGetUserErrorState(error.toString()));
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
      emit(GymProfileImagePickerSuccessState());
    } else {
      print('no image selected');
      emit(GymProfileImagePickerErrorState());
    }
  }

//
  String profileImageUrl = '';

  Future<void> uploadProfileImage() async {
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        emit(GymUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(GymUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(GymUploadProfileImageErrorState());
    });
  }

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
      image: profileImageUrl,
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
      emit(GymUserUpdateErrorState());
    });
  }

  ////////////////////////////////////////////////////////////////////////////////////////

  late String verificationId;

  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(PhoneLoadingState());

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print("verification Completed");
    await signIn(credential);
  }

  verificationFailed(FirebaseAuthException error) {
    print('Error ${error.toString()}');
    print(error.toString());
    emit(PhoneErrorState(error: error.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    print('code is sent');
    this.verificationId = verificationId;
    emit(PhoneNumberSubmitted());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('CodeAutoRetrievalTimeout');
  }

  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.toString(), smsCode: otpCode);
    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOTPVerified());
    } catch (error) {
      print(error.toString());
      emit(PhoneErrorState(error: error.toString()));
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    CacheHelper.removeUserData(key: 'uId');
  }

  User getCurrentUser() {
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    return firebaseUser;
  }
}

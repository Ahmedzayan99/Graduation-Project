// ignore_for_file: avoid_print

import 'package:blackgym/model/user_model.dart';
import 'package:blackgym/shared/network/constants.dart';
import 'package:blackgym/shared/network/remote/dio_helper.dart';
import 'package:blackgym/shared/styles/colors_manager.dart';
import 'package:blackgym/shared/styles/iconly_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'authentication_states.dart';
class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  //<<<<<<<<<<<<<<<<<Start the cubit of show Password  >>>>>>>>>>>>>>>>>>>>>>

  IconData iconPasswordLogin = IconlyBroken.hide;
  bool isPasswordLogin = true;

  void changePasswordLoginVisible() {
    isPasswordLogin = !isPasswordLogin;
    iconPasswordLogin =
        isPasswordLogin ? IconlyBroken.hide : Icons.remove_red_eye_rounded;
    emit(GymChangeVisiblePasswordLoginState());
  }

  bool isPasswordRegister = true;
  IconData iconPasswordRegister = IconlyBroken.hide;

  void changePasswordRegisterVisible() {
    isPasswordRegister = !isPasswordRegister;
    iconPasswordRegister =
        isPasswordRegister ? IconlyBroken.hide : Icons.remove_red_eye_rounded;
    emit(GymChangeVisiblePasswordRegisterState());
  }

  Color colorGender = ColorsManager.black;
  bool genderInitial = true;
  String genderString = 'MALE';

  void changeGender({
    required bool gender,
  }) {
    genderInitial = gender;
    print(genderInitial);
    if (genderInitial == true) {
      genderString = 'MALE';
    } else {
      genderString = 'FEMALE';
    }
    print(genderString);
    emit(GymChangeGenderState());
  }

  double heightInitial = 120;

  void changeHeight({
    required double height,
  }) {
    heightInitial = height;
    print(heightInitial);
    emit(GymChangeHeightState());
  }

  double weightInitial = 60;

  void changeWeight({
    required double weight,
  }) {
    weightInitial = weight;
    print(weightInitial);
    emit(GymChangeWeightState());
  }

  double ageInitial = 21;

  void changeAge({
    required double age,
  }) {
    ageInitial = age;
    print(ageInitial);
    emit(GymChangeAgeState());
  }

  String agr = '';
  double fatPercentageInitial = 5;

  void changefatPercentaget({
    required double fatPercentage,
  }) {
    fatPercentageInitial = fatPercentage;
    print(fatPercentageInitial);
    emit(GymChangeFatPercentageState());
  }

  ///========= otp message =========///
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
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      emit(PhoneOTPVerified());
    }).catchError((error) {
      print(error.toString());
      emit(PhoneErrorState(error: error.toString()));
    });
  }

  User getCurrentUser() {
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    return firebaseUser;
  }

  //<<<<<<<<<<<<<<<<<Start the cubit of Register by firebase>>>>>>>>>>>>>>>>>>>>>>
  Future<void> userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
    // String? image,
  }) async {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: '$email@gym.com',
      password: password,
    )
        .then((value) {
      emit(RegisterSuccessState());
       createUser(
        gender: genderString,
        name: name,
        email: email,
        uId: value.user!.uid,
         phone: phone,
        image:
            "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?size=338&ext=jpg&ga=GA1.1.292155642.1675795923",
        height: '${heightInitial.round()}',
        age: '${ageInitial.round()}',
        fatPercentage: '${fatPercentageInitial.round()}',
        weight: '${weightInitial.round()}',
      );

      userLogin(
          email: email,
          password: password
      );
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
      print('user register error$error');
    });
  }
  //<<<<<<<<<<<<<<<<<Start the cubit of createUser by firebase>>>>>>>>>>>>>>>>>>>>>>
  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required  String height,
    required  String age,
    required  String image,
    required  String fatPercentage,
    required  String weight,
    required  String gender,
  }) {
    emit(CreateUserLoadingState());
    UserModel model = UserModel(
      gender: genderString,
      name: name,
      email: email,
      uId: uId,
      phone: phone,
      image:
      "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?size=338&ext=jpg&ga=GA1.1.292155642.1675795923",
      height:height,
      age: age,
      fatPercentage: fatPercentage,
      weight: weight,

    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
       emit(CreateUserSuccessState());
    }).catchError((error) {
      print('CreateUserErrorState$error');
      emit(CreateUserErrorState(error.toString()));
    });
  }

  //<<<<<<<<<<<<<<<<<Start the cubit of Login by firebase>>>>>>>>>>>>>>>>>>>>>>
  UserModel? userModel;
  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    print('11111111111111');
    DioHelper.postData(
        url: login,
        data: {
          'email': email,
          'password': password,
        }
    ).then((value) {
      print('22222222');
      print(value.data);
      userModel = UserModel.fromJson(value.data()!);
      emit(LoginSuccessState());
    }).catchError((error) {
      print('3333333333');
      emit(LoginErrorState(error.toString()));
      print('LoginErrorState$error');
    });
  }

  ////////////////fire base Login//////////////////////////////////
  /*  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: '$email@gym.com',
          password: password,
        )
        .then((value) {
      CacheHelper.saveData(
          key: 'uId',
          value:value.user?.uid);
          emit(LoginSuccessState());
        })
        .then((value) {})
        .catchError((error) {
          emit(LoginErrorState(error.toString()));
          print('lllllllllllllllllllllllllllllllllll'+error);
        });
  }
*/

//<collection>
//<getData>
}

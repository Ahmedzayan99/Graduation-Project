

import 'dart:io';

import 'package:blackgym/cubit/settings/settings_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';


import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../data/models/authentication/get_user/user_model.dart';
import '../../data/network/constants.dart';
import '../../data/network/local/cache_helper.dart';
import '../../data/network/remote/dio_helper.dart';
import '../../shared/styles/iconly_broken.dart';


class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(SettingsInitialState());

  get index => null;

  static SettingsCubit get(context) => BlocProvider.of(context);

  bool myProfile = false;

  void changeBottomProfile() {
    myProfile = !myProfile;
    emit(GymChangeProfileState());
  }

  bool ourBranch = false;

  void changeBottomBranch() {
    ourBranch = !ourBranch;
    emit(GymChangeBranchState());
  }
  bool evaluateCoach = false;

  void changeBottomEvaluateCoach() {
    evaluateCoach = !evaluateCoach;
    emit(GymChangeEvaluateCoachState());
  }

  Future<void> updateRate({
    required int stars,
  }
      ) async {
    emit(UpdateRateLoading());
    await DioHelper.postData(
        url: rate,
        data:{
          "user_id":userModel!.users!.id,
          "Coash_id":29,
          "stars":stars,
        }).then((value) {
      emit(UpdateRateSuccess());
    }).catchError((error){
      emit(UpdateRateError(error: error));
    });
  }
  UserModel userModel=UserModel();
  Future<void> getUserData() async {
    emit(GetUserLoadingState());
    await DioHelper.getData(url: user.getProfile(id: CacheHelper.getDataIntoShPre(key:'token'))).then((value) {
      userModel = UserModel.fromJson(value.data);
      print(userModel!);
      emit(GetUserSuccessState());
    })/*;
    await DioHelper.getData(url: user)
        .then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(GetUserSuccessState());
    })*/
        .catchError((error) {
      emit(GetUserErrorState(error: error.toString()),);
      print(error.toString());
    });
  }


  bool language = false;

  void changeBottomLanguage() {
    language = !language;
    emit(ChangeLanguageState());
  }

  bool selectLanguage = true;

  void changeBottomSelectLanguage() {
    selectLanguage = !selectLanguage;
    emit(ChangeBottomSelectLanguage());
  }

  Future<void> logOut() async {
    CacheHelper.removeUserData(key:'token');
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

  var confirmController = TextEditingController();
  var passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  IconData iconPasswordLogin = IconlyBroken.hide;
  bool isPasswordLogin = true;

  void changePasswordLoginVisible() {
    isPasswordLogin = !isPasswordLogin;
    iconPasswordLogin =
    isPasswordLogin ? IconlyBroken.hide : Icons.remove_red_eye_rounded;
    emit(GymChangeVisiblePasswordEditState());
  }
  IconData iconPasswordConfirmLogin = IconlyBroken.hide;
  bool isPasswordConfirmLogin = true;

  void changePasswordConfirmVisible() {
    isPasswordConfirmLogin = !isPasswordConfirmLogin;
    iconPasswordConfirmLogin =
    isPasswordConfirmLogin ? IconlyBroken.hide : Icons.remove_red_eye_rounded;
    emit(GymChangeVisiblePasswordConfirmEditState());
  }

  bool isPasswordRegister = true;
  IconData iconPasswordRegister = IconlyBroken.hide;


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
        .child('ahmed/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateProfileImage(image: value);
        //   updateProfileImage(image: value);
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
    DioHelper.postData(url:updateProfile , data: {
      "user_id":userModel!.users!.id,
      "name":userModel!.users!.name,
      "password":'123456789',
      "phone_number":userModel!.users!.phoneNumber,
      "height":userModel!.users!.height,
      "weight":userModel!.users!.weight,
      "age":userModel!.users!.age,
      "fat_percentage":userModel!.users!.fatPercentage,
      "image_url":image,
      "gender":userModel!.users!.gender,
      "membership":'paid',
      "coash_name":userModel!.users!.coashName

    }).then((value) {
      profileImage = null;
      getUserData();
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }

  void updateProfilePassword() {
    emit(UpdateUserPasswordLoadingState());
    DioHelper.postData(url:updateProfile , data: {
      "user_id":userModel!.users!.id,
      "name":userModel!.users!.name,
      "password":confirmController.text,
      "phone_number":userModel!.users!.phoneNumber,
      "height":userModel!.users!.height,
      "weight":userModel!.users!.weight,
      "age":userModel!.users!.age,
      "fat_percentage":userModel!.users!.fatPercentage,
      "image_url":userModel!.users!.imageUrl,
      "gender":userModel!.users!.gender,
      "membership":'paid',
      "coash_name":userModel!.users!.coashName

    }).then((value) {
      getUserData();
    }).catchError((error) {
      emit(UpdateUserPasswordErrorState());
    });
  }


}
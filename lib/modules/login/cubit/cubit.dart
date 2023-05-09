import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../models/countery_model.dart';
import '../../../models/error_message.dart';
import '../../../models/login_model.dart';
import '../../../models/profile_model.dart';
import '../../../shared/network/local/cache_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;
  ErrorMessage? errorMessage;
  void userLogin(
      {@required phone,
      @required device_name,
      @required type,
      @required device_token}) async {
    emit(LoginLoadingState());
    var response = await DioHelper.postData(url: type, data: {
      'device_name': device_name,
      'phone': phone,
      'device_token': device_token
    });
    if (response.statusCode == 200) {
      loginModel = LoginModel.fromJson(response.data);
      emit(LoginSuccessState(loginModel!));
    }
    if (response.statusCode == 422) {
      errorMessage = ErrorMessage.fromJson(response.data);
      print(errorMessage);
      emit(LoginErrorState2(errorMessage!));
    }
  }

  bool? isDark = CacheHelper.getBoolean(key: 'isDark') ?? false;

  void changeAppMode({required bool fromShared}) {
    isDark = !isDark!;
    CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
      emit(ThemChangeModeState());
    });
  }

  void verifyLogin({@required phone, @required code}) {
    emit(LoginLoadingState());
    DioHelper.postData(
        url: 'users/verify-code',
        data: {'phone': phone, 'code': code}).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.user!.phone);

      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      print(error.toString());
    });
  }

///// Info
  ///
  ///
  ProfileModel? profileModel;

  void InfoData({@required name, @required country, file}) async {
    emit(InfoLoadingState());
    FormData formData = FormData.fromMap({
      'name': name,
      'country_id': country,
      'image': file != null
          ? await MultipartFile.fromFile(file.path, filename: fileName)
          : null,
    });

    DioHelper.postData(
            url: 'users/update-profile', data: formData, token: token)
        .then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      print(value.data);
      emit(InfoSuccessState(profileModel!));
    }).catchError((error) {
      emit(InfoErrorState(error.toString()));
      print(error.toString());
    });
  }

  CountryModel? countryModel;
  Future<void> getCountries() async {
    emit(CountryLoadingState());
    DioHelper.getData(
      url: 'countries',
      token: token,
    ).then((value) {
      print(value.data);
      countryModel = CountryModel.fromJson(value.data);
      emit(CountrySuccessState());
    }).catchError((error) {
      emit(ContryErrorState(error.toString()));
      print(error.toString());
    });
  }

  final picker = ImagePicker();
  File? file;

  Future<void> getImageFromGallery() async {
    final dynamic pickedImage =
        await picker.pickImage(source: ImageSource.gallery).then((value) {
      file = File(value!.path);
      emit(fileImagePickedSucseesState());
    });
    if (pickedImage != null) {
      fileName = pickedImage != null ? pickedImage.path.split('/').last : '';
      emit(ShopProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(ShopProfileImagePickedErrorState());
    }
  }

  bool isShowPassword = true;

  void changePasswordVisibility() {
    isShowPassword = !isShowPassword;
    emit(LoginChangePasswordVisibilityState());
  }

  int? CounteryVal;

  void changeCounteryValue(val) {
    CounteryVal = val;
    emit(InfoChangeCounteryState());
  }

  var myToken;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  void Fcm() {
    _firebaseMessaging.getToken().then((value) {
      myToken = value;
      print('this is my token');

      print(myToken);
      emit(FcmSuccessState());
    });
    print(myToken);
  }
}

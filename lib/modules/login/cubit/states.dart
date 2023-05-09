// import 'package:shop_app/models/login_model.dart';

import '../../../models/error_message.dart';
import '../../../models/login_model.dart';
import '../../../models/profile_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}

class LoginErrorState2 extends LoginStates {
  ErrorMessage error;
  LoginErrorState2(this.error);
}

class ThemChangeModeState extends LoginStates {}

class InfoLoadingState extends LoginStates {}

class InfoSuccessState extends LoginStates {
  ProfileModel profileModel;
  InfoSuccessState(this.profileModel);
}

class InfoErrorState extends LoginStates {
  final String error;
  InfoErrorState(this.error);
}

class CountryLoadingState extends LoginStates {}

class CountrySuccessState extends LoginStates {
  CountrySuccessState();
}

class ContryErrorState extends LoginStates {
  final String error;
  ContryErrorState(this.error);
}

class ShopProfileImagePickedSuccessState extends LoginStates {}

class ShopProfileImagePickedErrorState extends LoginStates {}

class fileImagePickedSucseesState extends LoginStates {}

class InfoChangeCounteryState extends LoginStates {}

class FcmSuccessState extends LoginStates {}

class LoginChangePasswordVisibilityState extends LoginStates {}

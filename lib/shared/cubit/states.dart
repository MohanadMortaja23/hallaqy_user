import 'package:shop_app/models/message_model.dart';
import 'package:shop_app/models/work_time_model.dart';

import '../../models/favourite_mdoel.dart';
import '../../models/home_model.dart';
import '../../models/order_model.dart';
import '../../models/profile_model.dart';

abstract class HallaqStates {}

class ChangeBottomNavState extends HallaqStates {
  // ignore: prefer_typing_uninitialized_variables
  final index;

  ChangeBottomNavState(this.index);
}

class ChangeColor1State extends HallaqStates {
  // ignore: prefer_typing_uninitialized_variables

  ChangeColor1State();
}

class HallaqInitialState extends HallaqStates {}

class ChangeColorFavoriteState extends HallaqStates {}

class ChangeThemeState extends HallaqStates {}

class ShopChangeModeState extends HallaqStates {}
////////// Order State

class HallaqLoadingHomeDataState extends HallaqStates {
  List<DataHome> oldPosts;
  final bool isFirstFetch;
  HallaqLoadingHomeDataState(this.oldPosts, {this.isFirstFetch = false});
}

class HallaqSuccessHomeDataState extends HallaqStates {
  final List<DataHome> Posts;
  HallaqSuccessHomeDataState(this.Posts);
}

class HallaqErrorHomeDataState extends HallaqStates {
  final String error;

  HallaqErrorHomeDataState(this.error);
}

class HallaqLoadingDetailsState extends HallaqStates {}

class HallaqSuccessDetailsState extends HallaqStates {}

class HallaqErrorDetailsState extends HallaqStates {
  final String error;

  HallaqErrorDetailsState(this.error);
}

class HallaqLoadingNotifcationState extends HallaqStates {}

class HallaqSuccessNotificationState extends HallaqStates {}

class HallaqErrorNotificationState extends HallaqStates {
  final String error;

  HallaqErrorNotificationState(this.error);
}

class HallaqLoadingAddOrderState extends HallaqStates {}

class HallaqSuccessAddOrderState extends HallaqStates {
  HallaqSuccessAddOrderState();
}

class HallaqErrorAddOrderState extends HallaqStates {
  final String error;

  HallaqErrorAddOrderState(this.error);
}

class HallaqLoadingGetTimeState extends HallaqStates {}

class HallaqSuccessGetTimeState extends HallaqStates {
  final WorkTime workTime;
  HallaqSuccessGetTimeState(this.workTime);
}

class HallaqErrorGetTiemState extends HallaqStates {
  final String error;

  HallaqErrorGetTiemState(this.error);
}

class HallaqLoadingGetEmployeesState extends HallaqStates {}

class HallaqSuccessGetEmployeesState extends HallaqStates {}

class HallaqErrorGetEmployeesState extends HallaqStates {
  final String error;

  HallaqErrorGetEmployeesState(this.error);
}

class HallaqDayChaneState extends HallaqStates {}

class HallaqLoadingGetProfilesState extends HallaqStates {}

class HallaqSuccessGetProfilesState extends HallaqStates {}

class HallaqErrorGetProfileState extends HallaqStates {
  final String error;

  HallaqErrorGetProfileState(this.error);
}

class CountryLoadingState extends HallaqStates {}

class CountrySuccessState extends HallaqStates {}

class ContryErrorState extends HallaqStates {
  final String error;

  ContryErrorState(this.error);
}

class InfoChangeCounteryState extends HallaqStates {}

class InfoLoadingState extends HallaqStates {}

class InfoSuccessState extends HallaqStates {
  InfoSuccessState();
}

class InfoSuccess2State extends HallaqStates {
  final ProfileModel profileModel;
  InfoSuccess2State(this.profileModel);
}

class InfoErrorState extends HallaqStates {
  final String error;
  InfoErrorState(this.error);
}

class FavoriteLoadingState extends HallaqStates {}

class FavoriteSuccessState extends HallaqStates {
  final MessageMdoel messagemdoel;
  FavoriteSuccessState(this.messagemdoel);
}

class FavoriteErrorState extends HallaqStates {}

class GetFavoriteLoadingState extends HallaqStates {}

class GetFavoriteSuccessState extends HallaqStates {
  final FavouriteModel favouriteModel;
  GetFavoriteSuccessState(this.favouriteModel);
}

class GetFavoriteErrorState extends HallaqStates {}
////////// Order State

class MyOrderLoadingState extends HallaqStates {
  List<DataOrder> oldPosts;
  final bool isFirstFetch;

  MyOrderLoadingState(this.oldPosts, {this.isFirstFetch = false});
}

class MyOrderSuccessState extends HallaqStates {
  final List<DataOrder> Posts;

  MyOrderSuccessState(this.Posts);
}

class MyOrderErrorState extends HallaqStates {}

class DeletOrderLoadingState extends HallaqStates {}

class DeletOrderSuccessState extends HallaqStates {
  DeletOrderSuccessState();
}

class DeletOrderErrorState extends HallaqStates {}

class EmployeeLoadingState extends HallaqStates {}

class EmployeeSuccessState extends HallaqStates {
  EmployeeSuccessState();
}

class EmployeeErrorState extends HallaqStates {}

class ShopSuccessChangeFavoritesState extends HallaqStates {}

class ShopErrorChangeFavoritesState extends HallaqStates {
  final String error;

  ShopErrorChangeFavoritesState(this.error);
}

class ShopSuccessGetFavoritesState extends HallaqStates {}

class ShopLoadingGetFavoritesState extends HallaqStates {}

class ShopErrorGetFavoritesState extends HallaqStates {
  final String error;

  ShopErrorGetFavoritesState(this.error);
}

class ShopSuccessGetUserDataState extends HallaqStates {}

class ShopLoadingGetUserDataState extends HallaqStates {}

class ShopErrorGetUserDataState extends HallaqStates {
  final String error;

  ShopErrorGetUserDataState(this.error);
}

class ShopSuccessUpdateUserState extends HallaqStates {
  // ShopSuccessUpdateUserState(this.userData);
}

class ShopLoadingUpdateUserState extends HallaqStates {}

class ShopErrorUpdateUserState extends HallaqStates {
  final String error;

  ShopErrorUpdateUserState(this.error);
}

class OpenDrawerState extends HallaqStates {}

class CloseDrawerState extends HallaqStates {}

class ShopProfileImagePickedSuccessState extends HallaqStates {}

class fileImagePickedSucseesState extends HallaqStates {}

class ShopProfileImagePickedErrorState extends HallaqStates {}

class ShopOnPageChangeState extends HallaqStates {}

class ShopSuccessAddAndRemoveFromCartState extends HallaqStates {}

class ShopErrorAddAndRemoveFromCartState extends HallaqStates {
  final String error;

  ShopErrorAddAndRemoveFromCartState(this.error);
}

class FcmSuccessState extends HallaqStates {}

class InfoLoadingtokenState extends HallaqStates {}

class DeviceTokenUpdateState extends HallaqStates {}

class ShopSuccessAddQuantityState extends HallaqStates {}

class ShopErrorAddQuantityState extends HallaqStates {
  final String error;

  ShopErrorAddQuantityState(this.error);
}

class ShopSuccessGetCartsState extends HallaqStates {}

class ShopLoadingGetCartsState extends HallaqStates {}

class ShopErrorGetCartsState extends HallaqStates {
  final String error;

  ShopErrorGetCartsState(this.error);
}

class ShopLoadingAddAddressState extends HallaqStates {}

class ShopSuccessAddAddressState extends HallaqStates {}

class ShopErrorAddAddressState extends HallaqStates {
  final String error;

  ShopErrorAddAddressState(this.error);
}

class ShopLoadingGetFAQsState extends HallaqStates {}

class ShopSuccessGetFAQsState extends HallaqStates {}

class ShopErrorGetFAQsState extends HallaqStates {
  final String error;

  ShopErrorGetFAQsState(this.error);
}

class ShopLoadingGetOrdersState extends HallaqStates {}

class ShopSuccessGetOrdersState extends HallaqStates {}

class ShopErrorGetOrdersState extends HallaqStates {
  final String error;

  ShopErrorGetOrdersState(this.error);
}

class ShopSuccessCancelOrderState extends HallaqStates {}

class ShopErrorCancelOrderState extends HallaqStates {}

class ShopChangePasswordVisibility1State extends HallaqStates {}

class ShopChangePasswordVisibility2State extends HallaqStates {}

class ShopLoadingChangePasswordState extends HallaqStates {}

class ShopSuccessChangePasswordState extends HallaqStates {
  // final ChangePasswordModel changePasswordModel;
  // ShopSuccessChangePasswordState(this.changePasswordModel);
}

class ShopErrorChangePasswordState extends HallaqStates {
  final String error;

  ShopErrorChangePasswordState(this.error);
}

class ShopLoadingSearchState extends HallaqStates {}

class ShopSuccessSearchState extends HallaqStates {}

class ShopErrorSearchState extends HallaqStates {
  final error;
  ShopErrorSearchState(this.error);
}

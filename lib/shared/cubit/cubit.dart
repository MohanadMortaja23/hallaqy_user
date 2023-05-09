import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shop_app/models/details_model.dart';
import 'package:shop_app/models/employee_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/profile_model.dart';
import 'package:shop_app/modules/home_screen/home_screen.dart';
import 'package:shop_app/modules/nearby_screen/nearby_screen.dart';
import 'package:shop_app/modules/orders/orders_screen.dart';
import 'package:shop_app/modules/profile/profile_screen.dart';

import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../models/countery_model.dart';
import '../../models/favourite_mdoel.dart';
import '../../models/message_model.dart';
import '../../models/noftication_model.dart';
import '../../models/order_model.dart';
import '../../models/work_time_model.dart';
import '../styles/theme.dart';

class HallaqCubit extends Cubit<HallaqStates> {
  HallaqCubit() : super(HallaqInitialState());

  static HallaqCubit get(context) => BlocProvider.of(context);
/////////////////

  int bottomNavBarCurrentIndex = 0;

  List<Widget> bottomNavBarScreens = [
    HomeScreen(),
    OrdersScreen(),
    ProfileScreen()
  ];

  Widget chooseBotNavBarScreen(int index) {
    return bottomNavBarScreens[index];
  }

  void changeBottomNavBarCurrentIndex(int index) {
    bottomNavBarCurrentIndex = index;
    emit(ChangeBottomNavState(bottomNavBarCurrentIndex));
  }

  ThemeData? themeData = lightMode;
  void changeTheme(val) {
    themeData = val;
    emit(ChangeThemeState());
  }

  ///////////////////////Change color
  int? Index = 0;
  Color color = Colors.white;
  int? Index2 = 0;
  Color color2 = Colors.white;

  dynamic timeSelected;

  void changeColorTimeIndex(int index, time) {
    Index = index;
    timeSelected = time;
    color = Color(0xffC9574D);

    emit(ChangeColor1State());
  }

  int? id_employee = 0;
  void changeColorhallaqIndex(int index, id) {
    id_employee = id;
    Index2 = index;
    color2 = Color(0xffC9574D);
    print(id_employee);

    emit(ChangeColor1State());
  }

  Color? color_favorite;

  void changeColorFavoriteIndex(color) {
    color_favorite = color;
    emit(ChangeColorFavoriteState());
  }

  HomeModel? homeModel;
  int pageHome = 1;

  void getHomeData({@required String? search}) async {
    if (state is HallaqLoadingHomeDataState) return;
    final currentState = state;
    var oldPosts = <DataHome>[];
    if (currentState is HallaqSuccessHomeDataState) {
      oldPosts = currentState.Posts;
    }
    if (search != '') {
      pageHome = 1;
      oldPosts = <DataHome>[];
    }
    emit(HallaqLoadingHomeDataState(oldPosts, isFirstFetch: pageHome == 1));
    DioHelper.getData(
      url: 'users/salons?page=$pageHome&search=$search',
      token: token,
    ).then((value) {
      pageHome++;
      final posts = (state as HallaqLoadingHomeDataState).oldPosts;
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel!.data!.length);

      posts.addAll(homeModel!.data!);
      print(posts.length);
      print('the page ');

      print(pageHome);

      emit(HallaqSuccessHomeDataState(posts));
    }).catchError((error) {
      emit(HallaqErrorHomeDataState(error.toString()));
      print(error.toString());
    });
  }

  //// Home

  // CategoriesModel categoriesModel;
  DetailsModel? detailsModel;
  void getDetailsCard({required id}) {
    emit(HallaqLoadingDetailsState());
    DioHelper.getData(
      url: 'users/salons/$id',
      token: token,
    ).then((value) {
      detailsModel = DetailsModel.fromJson(value.data);
      // categoriesModel = CategoriesModel.fromJson(value.data);
      emit(HallaqSuccessDetailsState());
    }).catchError((error) {
      emit(HallaqErrorDetailsState(error.toString()));
      print(error.toString());
    });
  }

  NotificationModel? notificationModel;
  void getNotification() {
    emit(HallaqLoadingNotifcationState());
    DioHelper.getData(
      url: 'users/notifications',
      token: token,
    ).then((value) {
      notificationModel = NotificationModel.fromJson(value.data);
      // categoriesModel = CategoriesModel.fromJson(value.data);
      emit(HallaqSuccessNotificationState());
    }).catchError((error) {
      emit(HallaqErrorNotificationState(error.toString()));
      print(error.toString());
    });
  }

  Color color3 = Color(0xffC9574D);
  Color color4 = Colors.white;
  int day = 1;

  void changeColorDay1Index() {
    color3 = Color(0xffC9574D);
    color4 = Colors.white;
    day = 1;
    emit(ChangeColor1State());
  }

  void changeColorDay2Index() {
    color4 = Color(0xffC9574D);
    color3 = Colors.white;
    day = 2;
    emit(ChangeColor1State());
  }

  Map<int, bool> favorites = {};

  // ChangeFavoritesModel changeFavoritesModel;

  Map<int, bool> carts = {};

  // ChangeCartsModel changeCartsModel;

  void getUserData() {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      // userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessGetUserDataState());
    }).catchError((error) {
      emit(ShopErrorGetUserDataState(error.toString()));
      print(error.toString());
    });
  }

  void InfoData({name, country, file, phone}) async {
    emit(InfoLoadingState());
    FormData formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'country_id': country,
      'image': await MultipartFile.fromFile(file.path, filename: fileName),
    });

    DioHelper.postData(
            url: 'users/update-profile', data: formData, token: token)
        .then((value) {
      print(value.data);
      emit(InfoSuccessState());
    }).catchError((error) {
      emit(InfoErrorState(error.toString()));
      print(error.toString());
    });
  }

  void InfoData2({name, country, file, phone}) async {
    emit(InfoLoadingState());
    FormData formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'country_id': country,
    });

    DioHelper.postData(
            url: 'users/update-profile', data: formData, token: token)
        .then((value) {
      print(value.data);
      profilemodel = ProfileModel.fromJson(value.data);
      emit(InfoSuccess2State(profilemodel!));
    }).catchError((error) {
      emit(InfoErrorState(error.toString()));
      print(error.toString());
    });
  }

  int? CounteryVal;

  void changeCounteryValue(val) {
    CounteryVal = int.parse('$val');
    emit(InfoChangeCounteryState());
  }

  CountryModel? countryModel;
  DataCountery? initialCountery;
  Future<void> getCountries(id) async {
    emit(CountryLoadingState());
    DioHelper.getData(
      url: 'countries',
      token: token,
    ).then((value) {
      print(value.data);
      countryModel = CountryModel.fromJson(value.data);
      initialCountery = countryModel!.data!.firstWhere((e) {
        return e.id == id;
      });
      emit(CountrySuccessState());
    }).catchError((error) {
      emit(ContryErrorState(error.toString()));
      print(error.toString());
    });
  }

  //// Post Favouite
  MessageMdoel? messagemdoel;
  void PostFavorite({partner_id}) async {
    FormData formData = FormData.fromMap({
      'partner_id': partner_id,
    });

    DioHelper.postData(
            url: 'users/favorite-salons', data: formData, token: token)
        .then((value) {
      print(value.data);
    }).catchError((error) {
      emit(FavoriteErrorState());
      print(error.toString());
    });
  }

  ////Get Favourite
  FavouriteModel? favouriteModel;
  void GetFavorite() async {
    emit(GetFavoriteLoadingState());

    DioHelper.getData(url: 'users/favorite-salons', token: token).then((value) {
      favouriteModel = FavouriteModel.fromJson(value.data);
      print(value.data);
      emit(GetFavoriteSuccessState(favouriteModel!));
    }).catchError((error) {
      emit(GetFavoriteErrorState());
      print(error.toString());
    });
  }

  /////////////////OrderCARD

  OrderMdoel? ordermdoel;
  int pageOrder = 1;
  List<DataOrder> posts = [];

  void Get_Myorder() async {
    if (state is MyOrderLoadingState) return;
    final currentState = state;
    var oldPosts = <DataOrder>[];
    if (currentState is MyOrderSuccessState) {
      oldPosts = currentState.Posts;
    }

    emit(MyOrderLoadingState(oldPosts, isFirstFetch: pageOrder == 1));
    DioHelper.getData(url: 'users/orders?page=$pageOrder', token: token)
        .then((value) {
      print(value.data);
      pageOrder++;
      final posts = (state as MyOrderLoadingState).oldPosts;
      ordermdoel = OrderMdoel.fromJson(value.data);
      print(ordermdoel!.data!.length);

      posts.addAll(ordermdoel!.data!);
      print(posts.length);

      print(pageOrder);

      emit(MyOrderSuccessState(posts));
    }).catchError((error) {
      emit(MyOrderErrorState());
      print(error.toString());
    });
  }

  MessageMdoel? messageMdoel;
  Future<void> DeleteOrder({id, context, index}) async {
    DioHelper.postData(
        url: 'users/delete-order',
        token: token,
        data: {'id': id}).then((value) {
      messageMdoel = MessageMdoel.fromJson(value.data);
      if (messageMdoel!.status == true) {
        posts.removeAt(index);
        emit(MyOrderSuccessState(posts));
      }
      MotionToast.success(
        title: "",
        titleStyle: TextStyle(fontWeight: FontWeight.bold),
        description: messageMdoel!.message.toString(),
        descriptionStyle: TextStyle(
            //overflow: TextOverflow.ellipsis,
            ),
        animationType: ANIMATION.FROM_LEFT,
        position: MOTION_TOAST_POSITION.TOP,
        borderRadius: 10.0,
        width: 300,
        height: 65,
      ).show(context);
      print(value.data);
    }).catchError((error) {
      emit(DeletOrderErrorState());
      print(error.toString());
    });
  }

  EmployeeMdoel? employeemodel;

  void EmployeeData({partner_id}) async {
    emit(EmployeeLoadingState());
    DioHelper.getData(
            url: 'users/getemployees?partner_id=$partner_id', token: token)
        .then((value) {
      employeemodel = EmployeeMdoel.fromJson(value.data);
      id_employee = employeemodel!.data![0].id;
      emit(EmployeeSuccessState());
    }).catchError((error) {
      emit(EmployeeErrorState());
      print(error.toString());
    });
  }

  void updateUserFullName(
      {required String name,
      @required email,
      @required phone,
      @required image}) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(url: UPDATE_PROFILE, token: token!, data: {
      'name': name,
      'email': email,
      'phone': phone,
      'image': image
    }).then((value) {
      // userModel = LoginModel.fromJson(value.data);
      // emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error) {
      emit(ShopErrorUpdateUserState(error.toString()));
      print(error.toString());
    });
  }

  // ProductDetailsModel productDetailsModel;

  //// Order Request
  ///
  ///
  MessageMdoel? messageMdoel2;
  void addOrder({
    required employee_id,
    required day,
    required time,
    required partner_id,
  }) {
    print(employee_id);
    print(day);
    print(time.toString());
    print(partner_id);

    emit(HallaqLoadingAddOrderState());
    DioHelper.postData(
      url: 'users/orders',
      token: token,
      data: {
        'date': day,
        'employee_id': employee_id,
        'partner_id': partner_id,
        'time': time.toString(),
      },
    ).then((value) {
      messageMdoel2 = MessageMdoel.fromJson(value.data);
      // getCarts();
      print(id_employee);
      emit(HallaqSuccessAddOrderState());
    }).catchError((error) {
      print(error.toString());
      emit(HallaqErrorAddOrderState(error.toString()));
    });
  }

  int? idemployee;
  changeEmployeeId() {}

/////////////////////Get Time WORK Data
  WorkTime? workTime;
  void getTimeWorkData({partner_id, day_id, employee_id}) {
    workTime = null;
    emit(HallaqLoadingGetTimeState());
    DioHelper.getData(
      url:
          'users/getWorkTime?partner_id=$partner_id&employee_id=$employee_id&date=$day_id',
      token: token,
    ).then((value) {
      print(value);
      workTime = WorkTime.fromJson(value.data);
      timeSelected = (workTime!.data!.length != 0
          ? workTime!.data![0].time.toString()
          : '');
      emit(HallaqSuccessGetTimeState(workTime!));
    }).catchError((error) {
      emit(HallaqErrorGetTiemState(error.toString()));
      print(error.toString());
    });
  }

  ///////////// Employe

  void getEmployeesData({partner_id}) {
    emit(HallaqLoadingGetEmployeesState());
    DioHelper.getData(
      url: 'users/getemployees?partner_id=$partner_id',
      token: token,
    ).then((value) {
      print(value);
      emit(HallaqSuccessGetEmployeesState());
    }).catchError((error) {
      emit(HallaqErrorGetEmployeesState(error.toString()));
      print(error.toString());
    });
  }

  dynamic Day_id = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
  void changeTimeWork(val) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(val);

    Day_id = formattedDate;
    print(Day_id);
    emit(HallaqDayChaneState());
  }

///////////////Get Profile Data
  ProfileModel? profilemodel;
  void getProfile() {
    emit(HallaqLoadingGetProfilesState());
    DioHelper.getData(
      url: 'users/profile',
      token: token,
    ).then((value) {
      print(value.data);
      profilemodel = ProfileModel.fromJson(value.data);
      // ordersModel = OrdersModel.fromJson(value.data);
      emit(HallaqSuccessGetProfilesState());
    }).catchError((error) {
      emit(HallaqErrorGetProfileState(error.toString()));
    });
  }

  ///

  bool isDark = false;

  // void changeAppMode({bool fromShared}) {
  //   if (fromShared != null) {
  //     isDark = fromShared;
  //     emit(ShopChangeModeState());
  //   } else {
  //     isDark = !isDark;
  //     CacheHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
  //       emit(ShopChangeModeState());
  //     });
  //   }
  // }

  // void addAddress({
  //   required String name,
  //   required String city,
  //   required String region,
  //   required String details,
  //   required String notes,
  // }) {
  //   emit(ShopLoadingAddAddressState());
  //   DioHelper.postData(
  //     url: ADDRESS,
  //     token: token!,
  //     data: {
  //       'name': name,
  //       'city': city,
  //       'region': region,
  //       'details': details,
  //       'notes': notes,
  //       'latitude': '3123123',
  //       'longitude': '2121545',
  //     },
  //   ).then((value) {
  //     addOrder(idAddress: value.data['data']['id']);
  //     emit(ShopSuccessAddAddressState());
  //   }).catchError((error) {
  //     emit(ShopErrorAddAddressState(error.toString()));
  //     print(error.toString());
  //   });
  // }

  // FaqsModel faqsModel;

  // void getFAQs() {
  //   emit(ShopLoadingGetFAQsState());
  //   DioHelper.getData(
  //     url: FAQS,
  //   ).then((value) {
  //     faqsModel = FaqsModel.fromJson(value.data);
  //     emit(ShopSuccessGetFAQsState());
  //   }).catchError((error) {
  //     emit(ShopErrorGetFAQsState(error.toString()));
  //   });
  // }

  bool expansionIcon = false;

  // OrdersModel ordersModel;

  void getOrders() {
    emit(ShopLoadingGetOrdersState());
    DioHelper.getData(
      url: ORDERS,
      token: token,
    ).then((value) {
      // ordersModel = OrdersModel.fromJson(value.data);
      emit(ShopSuccessGetOrdersState());
    }).catchError((error) {
      emit(ShopErrorGetOrdersState(error.toString()));
    });
  }

  void cancelOrder({required int id}) {
    DioHelper.getData(
      url: 'orders/${id}/cancel',
      token: token,
    ).then((value) {
      emit(ShopSuccessCancelOrderState());
    }).catchError((error) {
      emit(ShopErrorCancelOrderState());
    });
  }

  bool isShowPassword1 = true;

  void changePasswordVisibility1() {
    isShowPassword1 = !isShowPassword1;
    emit(ShopChangePasswordVisibility1State());
  }

  bool isShowPassword2 = true;

  void changePasswordVisibility2() {
    isShowPassword2 = !isShowPassword2;
    emit(ShopChangePasswordVisibility2State());
  }

  // ChangePasswordModel changePasswordModel;

  void changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    emit(ShopLoadingChangePasswordState());
    DioHelper.postData(
      url: CHANGE_PASSWORD,
      token: token!,
      data: {
        'current_password': currentPassword,
        'new_password': newPassword,
      },
    ).then((value) {
      // changePasswordModel=ChangePasswordModel.fromJson(value.data);
      print('=======================================');
      print(value.data);
      print('=======================================');
      // emit(ShopSuccessChangePasswordState(changePasswordModel));
    }).catchError((error) {
      emit(ShopErrorChangePasswordState(error.toString()));
      print(error.toString());
    });
  }

  // SearchModel searchModel;

  void search({required String text}) {
    emit(ShopLoadingSearchState());
    DioHelper.postData(
      url: PRODUCTS_SEARCH,
      token: token!,
      data: {
        'text': text,
      },
    ).then((value) {
      // searchModel = SearchModel.fromJson(value.data);
      emit(ShopSuccessSearchState());
    }).catchError((error) {
      emit(ShopErrorSearchState(error.toString()));
    });
  }

  final picker = ImagePicker();
  File? file;

  // Implementing the image picker

  Future<void> getImageFromGallery() async {
    final dynamic pickedImage =
        await picker.pickImage(source: ImageSource.gallery).then((value) {
      file = File(value!.path);
      emit(fileImagePickedSucseesState());
    });
    if (pickedImage != null) {
      fileName = pickedImage != null ? pickedImage.path.split('/').last : '';

      // InfoData(file: file);
      emit(ShopProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(ShopProfileImagePickedErrorState());
    }
  }

  Future<void> getImageFromCamera() async {
    final dynamic pickedImage = await picker.pickImage(
        source: ImageSource.camera, maxHeight: 1800, maxWidth: 1800);
    if (pickedImage != null) {
      // profileImage = File(pickedImage.path);
      // List<int> imageBytes = profileImage.readAsBytesSync();
      // base64Image = base64Encode(imageBytes);
      emit(ShopProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(ShopProfileImagePickedErrorState());
    }
  }

  void Infotoken({device_token}) async {
    print(device_token);
    print('Divice Token updated ');
    emit(InfoLoadingtokenState());

    DioHelper.postData(
            url: 'users/refresh_device_token',
            data: {
              'device_token': device_token,
            },
            token: token)
        .then((value) {
      print(value.data);
      emit(DeviceTokenUpdateState());
    }).catchError((error) {
      emit(InfoErrorState(error.toString()));
      print(error.toString());
    });
  }

  var myToken;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  void Fcm() {
    _firebaseMessaging.getToken().then((value) {
      myToken = value;
      print('this is my token');
      Infotoken(device_token: myToken);

      print(myToken);
      emit(FcmSuccessState());
    });
    print(myToken);
  }
  //////////////////
}

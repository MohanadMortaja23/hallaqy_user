import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/splash/splash_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/theme.dart';

import 'firebase_options.dart';
import 'modules/login/cubit/states.dart';
import 'modules/login/login_screen.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
    name: 'hallaqy',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
  Widget widget;
  token = await CacheHelper.getData(key: 'token');
  bool? isDark = CacheHelper.getBoolean(key: 'isDark') ?? false;
  if (token != null) {
    widget = HallaqLayoutScreen();
  } else {
    widget = LoginScreen();
  }
  runApp(halaaqApp(widget, isDark));
}

class halaaqApp extends StatelessWidget {
  final mywidget;
  final isDark;

  const halaaqApp(this.mywidget, this.isDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => HallaqCubit()),
        BlocProvider(create: (BuildContext context) => LoginCubit()),
      ],
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ScreenUtilInit(
            builder: (context, child) => MaterialApp(
              themeMode: LoginCubit.get(context).isDark!
                  ? ThemeMode.dark
                  : ThemeMode.light,
              darkTheme: darkMode,
              theme: lightMode,
              home: Scaffold(
                body: mywidget,
              ),
            ),
          );
        },
      ),
    );
  }
}

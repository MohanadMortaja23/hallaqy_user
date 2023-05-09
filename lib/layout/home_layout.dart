// ignore: file_names
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';
import '../shared/local_notification_service.dart';
import '../shared/styles/icon_broken.dart';

class HallaqLayoutScreen extends StatefulWidget {
  const HallaqLayoutScreen({super.key});

  @override
  State<HallaqLayoutScreen> createState() => _HallaqLayoutScreenState();
}

class _HallaqLayoutScreenState extends State<HallaqLayoutScreen> {
  var currentIndex = 0;
  late final LocalNotificationService service;
  @override
  void initState() {
    // TODO: implement initState
    service = LocalNotificationService();
    service.intialize();
    listenToNotification();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await service
          .showNotification(
              id: 0,
              title: message.notification!.title.toString(),
              body: message.notification!.body.toString())
          .then((value) {
        Future.delayed(const Duration(seconds: 5), () {
// Here you can write your code
          MotionToast.success(
            title: message.notification!.title.toString(),
            titleStyle: TextStyle(fontWeight: FontWeight.bold),
            description: message.notification!.body.toString(),
            descriptionStyle: TextStyle(
                //overflow: TextOverflow.ellipsis,
                ),
            animationType: ANIMATION.FROM_LEFT,
            position: MOTION_TOAST_POSITION.TOP,
            borderRadius: 10.0,
            width: 300,
            height: 65,
            toastDuration: Duration(seconds: 5),
          ).show(context);
        });
      });

      // NotificationService().showNotification(1, "title", "body", 10);
      print('إشعااااااااااااااار جديد');
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print(' ${message.notification!.title}');
        print(' ${message.notification!.body}');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HallaqCubit()
        ..getProfile()
        ..Fcm(),
      child: BlocConsumer<HallaqCubit, HallaqStates>(
          listener: (BuildContext context, Object? state) {},
          builder: (BuildContext context, Object? state) {
            double displayWidth = MediaQuery.of(context).size.width;

            var cubit = HallaqCubit.get(context);

            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body:
                    cubit.chooseBotNavBarScreen(cubit.bottomNavBarCurrentIndex),
                bottomNavigationBar: Card(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  elevation: 0,
                  child: Container(
                    margin:
                        EdgeInsets.only(bottom: 20.h, left: 25.w, right: 25.w),
                    height: displayWidth * .144,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 245, 244, 244), width: 2),
                      color: Color.fromARGB(255, 255, 255, 255),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 20,
                          offset: Offset(15, 15),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                    child: Container(
                      child: ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                              HapticFeedback.lightImpact();
                              cubit.changeBottomNavBarCurrentIndex(index);
                            });
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Stack(
                            children: [
                              AnimatedContainer(
                                duration: Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width: index == currentIndex
                                    ? displayWidth * .30
                                    : displayWidth * .25,
                                alignment: Alignment.center,
                                child: AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  height: index == currentIndex
                                      ? displayWidth * .12
                                      : 0,
                                  width: index == currentIndex
                                      ? displayWidth * .32
                                      : 0,
                                  decoration: BoxDecoration(
                                    color: index == currentIndex
                                        ? Colors.blueAccent.withOpacity(.2)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              AnimatedContainer(
                                duration: Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width: index == currentIndex
                                    ? displayWidth * .31
                                    : displayWidth * .18,
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Row(
                                      children: [
                                        AnimatedContainer(
                                          duration: Duration(seconds: 1),
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          width: index == currentIndex
                                              ? displayWidth * .13
                                              : 0,
                                        ),
                                        AnimatedOpacity(
                                          opacity:
                                              index == currentIndex ? 1 : 0,
                                          duration: Duration(seconds: 1),
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          child: Text(
                                            index == currentIndex
                                                ? '${listOfStrings[index]}'
                                                : '',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        AnimatedContainer(
                                          duration: Duration(seconds: 1),
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          width: index == currentIndex
                                              ? displayWidth * .03
                                              : 20,
                                        ),
                                        Icon(
                                          listOfIcons[index],
                                          size: displayWidth * .076,
                                          color: index == currentIndex
                                              ? Colors.black
                                              : Colors.black,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  List<IconData> listOfIcons = [
    IconBroken.Home,
    IconBroken.Paper,
    IconBroken.Profile,
  ];

  List<String> listOfStrings = [
    'الرئيسية',
    'الحجوزات',
    'حسابي',
  ];
  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');
    }
  }
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:pinput/pinput.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/login/info_screen.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class MyVerify extends StatefulWidget {
  final phonenumber;

  const MyVerify(this.phonenumber);
  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  dynamic number = 0;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message);
              print(state.loginModel.user!.token);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.user!.token)
                  .then((value) {
                print(state.loginModel.user!.token);
                print('==============================');
                token = CacheHelper.getData(key: 'token');
                print(token);
                print('==============================');
                if (state.loginModel.user!.name == null)
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return OfficerInfoScreen();
                  }));
                if (state.loginModel.user!.name != null)
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return HallaqLayoutScreen();
                  }));

                MotionToast.success(
                  title: "Success",
                  titleStyle: TextStyle(fontWeight: FontWeight.bold),
                  description: state.loginModel.message.toString(),
                  descriptionStyle: TextStyle(
                      //overflow: TextOverflow.ellipsis,
                      ),
                  animationType: ANIMATION.FROM_LEFT,
                  position: MOTION_TOAST_POSITION.TOP,
                  borderRadius: 10.0,
                  width: 300,
                  height: 65,
                ).show(context);
              });
            } else {
              print(state.loginModel.message);
              MotionToast.error(
                title: "Error",
                titleStyle: TextStyle(fontWeight: FontWeight.bold),
                description: state.loginModel.message.toString(),
                descriptionStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
                animationType: ANIMATION.FROM_LEFT,
                position: MOTION_TOAST_POSITION.TOP,
                borderRadius: 10.0,
                width: 300,
                height: 65,
              ).show(context);
            }
          }
        },
        builder: (context, state) => Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Center(
                child: Text(
                  'التحقق',
                  style: GoogleFonts.lato(
                      textStyle:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),
              ),
              elevation: 0,
            ),
            body: Stack(
              children: [
                Container(),
                Container(
                  margin: EdgeInsets.only(left: 25, right: 25),
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/images/img1.png',
                            width: double.infinity,
                            height: 200.h,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "رمز التحقق ",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "أدخل الرمز المرسل الى الهاتف ",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Pinput(
                          length: 4,
                          // defaultPinTheme: defaultPinTheme,
                          // focusedPinTheme: focusedPinTheme,
                          // submittedPinTheme: submittedPinTheme,

                          showCursor: true,
                          onCompleted: (pin) {
                            number = pin.toString();
                            print(pin);
                            print(widget.phonenumber);
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 45.h,
                          child: ConditionalBuilder(
                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator()),
                              condition: state is! LoginLoadingState,
                              builder: (context) {
                                return gradientButton(
                                    context: context,
                                    onPressed: () {
                                      LoginCubit.get(context).verifyLogin(
                                          phone: widget.phonenumber,
                                          code: number);
                                    },
                                    title: Text(
                                      "تأكيد الرمز المدخل ",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.sp),
                                    ));
                              }),

                          // child: ElevatedButton(
                          //     style: ElevatedButton.styleFrom(
                          //         primary: Colors.green.shade600,
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(10))),
                          //     onPressed: () {},
                          //     child: Text("تأكيد الرمز المدخل ")),
                        ),
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  navigatorPush(context, LoginScreen());
                                },
                                child: Text(
                                  "تعديل الرقم المدخل ؟",
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

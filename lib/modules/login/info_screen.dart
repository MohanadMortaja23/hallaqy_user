import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../../layout/home_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/icon_broken.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

// ignore: must_be_immutable
class OfficerInfoScreen extends StatelessWidget {
  var formState = GlobalKey<FormState>();
  TextEditingController FirstNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit()..getCountries(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is InfoSuccessState) {
            if (state.profileModel.status!) {
              print(state.profileModel.message);

              print('==============================');
              print('==============================');
              if (LoginCubit.get(context).CounteryVal != null) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return HallaqLayoutScreen();
                }));
                MotionToast.success(
                  title: "Success",
                  titleStyle: TextStyle(fontWeight: FontWeight.bold),
                  description: state.profileModel.message!,
                  descriptionStyle: TextStyle(
                      //overflow: TextOverflow.ellipsis,
                      ),
                  animationType: ANIMATION.FROM_LEFT,
                  position: MOTION_TOAST_POSITION.TOP,
                  borderRadius: 10.0,
                  width: 300,
                  height: 65,
                ).show(context);
              }
            } else {
              MotionToast.error(
                title: "Error",
                titleStyle: TextStyle(fontWeight: FontWeight.bold),
                description: state.profileModel.message!,
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
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  title: Text('معلوماتي ',
                      style: TextStyle(
                          fontSize: 25.sp, fontWeight: FontWeight.bold)),
                ),
                body: LoginCubit.get(context).countryModel != null
                    ? Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20.h),
                            child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        LoginCubit.get(context)
                                            .getImageFromGallery();
                                      },
                                      child: CircleAvatar(
                                        radius: 60.r,
                                        backgroundColor: Color(0xffC9574D),
                                        child: CircleAvatar(
                                          radius: 55.r,
                                          backgroundColor: Colors.white,
                                          child: LoginCubit.get(context).file !=
                                                  null
                                              ? Container(
                                                  width: 100.w,
                                                  height: 100.h,
                                                  child: Image.file(
                                                    File(LoginCubit.get(context)
                                                        .file!
                                                        .path),
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                )
                                              : CircleAvatar(
                                                  radius: 80.r,
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        'https://icon-library.com/images/no-profile-picture-icon/no-profile-picture-icon-6.jpg',
                                                    placeholder: (context,
                                                            url) =>
                                                        Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                      strokeWidth: 1.5.w,
                                                    )),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(
                                                      Icons.error,
                                                      color: Color(0xffC9574D),
                                                    ),
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        CircleAvatar(
                                                      backgroundImage:
                                                          imageProvider,
                                                      radius: 65.r,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 25.r,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        child: IconButton(
                                          splashRadius: 22.r,
                                          onPressed: () {},
                                          icon: Icon(
                                            IconBroken.Camera,
                                            color: Color(0xffC9574D),
                                          ),
                                        ),
                                        radius: 22.r,
                                        backgroundColor: Colors.grey[50],
                                      ),
                                    ),
                                  ],
                                ),
                                AnnotatedRegion<SystemUiOverlayStyle>(
                                  value: SystemUiOverlayStyle(
                                      statusBarColor: Colors.transparent,
                                      statusBarIconBrightness: Brightness.dark),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Form(
                                        key: formState,
                                        child: SingleChildScrollView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              TextFormField(
                                                controller: FirstNameController,
                                                cursorColor: indigo,
                                                keyboardType:
                                                    TextInputType.name,
                                                validator: (dynamic value) {
                                                  if (value.isEmpty) {
                                                    return 'أدخل الاسم    ';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  labelText: ' الاسم  ',
                                                  prefixIcon:
                                                      Icon(IconBroken.Profile),
                                                  enabledBorder: enabledBorder,
                                                  focusedBorder: focusedBorder,
                                                  errorBorder: enabledBorder,
                                                  focusedErrorBorder:
                                                      focusedBorder,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color:
                                                              Colors.black26),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.r),
                                                      boxShadow: <BoxShadow>[
                                                        //blur radius of shadow
                                                      ]),
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 30, right: 30),
                                                      child: DropdownButton<
                                                          dynamic>(
                                                        value: LoginCubit.get(
                                                                context)
                                                            .CounteryVal,
                                                        hint: Text(
                                                            'اختر المدينة '),
                                                        icon: Icon(
                                                          Icons
                                                              .arrow_circle_down_rounded,
                                                          color: Colors.black,
                                                        ),
                                                        items: LoginCubit.get(
                                                                context)
                                                            .countryModel!
                                                            .data!
                                                            .map((e) {
                                                          return DropdownMenuItem(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .topCenter,
                                                            value: e.id,
                                                            child: Text(e.name
                                                                .toString()),
                                                          );
                                                        }).toList(),
                                                        onChanged: (value) {
                                                          LoginCubit.get(
                                                                  context)
                                                              .changeCounteryValue(
                                                                  value);
                                                          print(value);
                                                        },
                                                        isExpanded:
                                                            true, //make true to take width of parent widget
                                                        underline:
                                                            Container(), //empty line
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.black),

                                                        iconEnabledColor: Colors
                                                            .white, //Icon color
                                                      ))),
                                              SizedBox(
                                                height: 30.0.h,
                                              ),
                                              ConditionalBuilder(
                                                  fallback: (context) => Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                                  condition: state
                                                      is! InfoLoadingState,
                                                  builder: (context) {
                                                    return gradientButton(
                                                        context: context,
                                                        title: Text(
                                                          'التالي ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16.sp),
                                                        ),
                                                        onPressed: () {
                                                          if (formState
                                                              .currentState!
                                                              .validate()) {
                                                            LoginCubit.get(context).InfoData(
                                                                name:
                                                                    FirstNameController
                                                                        .text,
                                                                country: LoginCubit
                                                                        .get(
                                                                            context)
                                                                    .CounteryVal,
                                                                file: LoginCubit
                                                                        .get(
                                                                            context)
                                                                    .file);
                                                          }
                                                        });
                                                  }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Lottie.asset(
                          'assets/lottiefiles/loader2.json',
                          width: 200,
                          height: 200,
                        ),
                      )),
          );
        },
      ),
    );
  }
}

class User {
  const User(this.id, this.name);

  final String name;
  final int id;
}

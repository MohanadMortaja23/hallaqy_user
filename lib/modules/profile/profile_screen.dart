import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/profile/policy_screen.dart';
import 'package:shop_app/modules/profile/region_screen.dart';
import 'package:shop_app/modules/update_user_data/update_user_data_bottom_sheet.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

import '../../shared/styles/theme.dart';

class ProfileScreen extends StatelessWidget {
  bool? _switchValue = CacheHelper.getBoolean(key: 'isDark');

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HallaqCubit, HallaqStates>(
      listener: (context, state) {
        if (state is InfoSuccess2State) {
          if (state.profileModel.status!) {
            MotionToast.success(
              title: "Success",
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
          } else {
            print(state.profileModel.message!);
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
        HallaqCubit cubit = HallaqCubit.get(context);

        return ModalProgressHUD(
          inAsyncCall: state is ShopLoadingUpdateUserState,
          color: Colors.white,
          opacity: 0.5,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                title: Center(
                  child: Text(
                    'الملف الشخصي',
                    style: Theme.of(context).appBarTheme.titleTextStyle,
                  ),
                ),
                leading: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.notifications,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          InkWell(
                            onTap: () {
                              cubit.getImageFromGallery().then((value) {
                                cubit.InfoData(file: cubit.file);
                              });
                            },
                            child: CircleAvatar(
                              radius: 60.r,
                              backgroundColor: Color(0xffC9574D),
                              child: CircleAvatar(
                                radius: 55.r,
                                backgroundColor: Colors.white,
                                child: cubit.file != null
                                    ? Container(
                                        width: 100.w,
                                        height: 100.h,
                                        child: Image.file(
                                          File(cubit.file!.path),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 80.r,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              '${cubit.profilemodel!.data!.image}',
                                          placeholder: (context, url) => Center(
                                              child: CircularProgressIndicator(
                                            strokeWidth: 1.5.w,
                                          )),
                                          errorWidget: (context, url, error) =>
                                              Icon(
                                            Icons.error,
                                            color: Color(0xffC9574D),
                                          ),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  CircleAvatar(
                                            backgroundImage: imageProvider,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text('${cubit.profilemodel!.data!.name}',
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                      Text('  ${cubit.profilemodel!.data!.phone}',
                          style: Theme.of(context).textTheme.bodyText1),

                      Divider(thickness: 2, indent: 1.5),
                      profileItem2(
                          context: context,
                          title: 'تعديل الملف الشخصي',
                          onTap: () {
                            bottomSheetUpdateUserData(
                                context: context, cubit: cubit);
                          },
                          icon: Icon(
                            IconBroken.User,
                          )),
                      profileItem2(
                          context: context,
                          title: ' تعديل المنطقة  ',
                          onTap: () {
                            navigatorPush(
                                context,
                                RegionScreen(HallaqCubit.get(context)
                                    .profilemodel!
                                    .data!
                                    .countryId));
                          },
                          icon: Icon(Icons.location_city)),
                      Container(
                        margin: EdgeInsets.only(top: 25.h),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: Text(
                                LoginCubit.get(context).isDark!
                                    ? 'تغيير إلى الوضع الفاتح'
                                    : 'تغيير إلى الوضع المظلم',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            Spacer(),
                            CupertinoSwitch(
                              value: LoginCubit.get(context).isDark!,
                              onChanged: (value) {
                                LoginCubit.get(context)
                                    .changeAppMode(fromShared: value);
                              },
                              trackColor: Colors.grey.shade200.withOpacity(0.2),
                            ),
                          ],
                        ),
                      ),

                      profileItem2(
                          context: context,
                          title: 'سياسة الخصوصية',
                          onTap: () {
                            navigatorPush(context, PolicyScreen());
                          },
                          icon: Icon(Icons.local_police)),

                      // Container(
                      //   margin: EdgeInsets.only(top: 15.h),
                      //   child: Row(
                      //     children: [
                      //       Icon(IconBroken.User),
                      //       Padding(
                      //         padding: EdgeInsets.only(right: 10.w),
                      //         child: Text(
                      //           'تعديل الملف الشخصي',
                      //           style: TextStyle(
                      //               color: Colors.black,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //       ),
                      //       Spacer(),
                      //       Icon(IconBroken.Arrow___Left_Circle)
                      //     ],
                      //   ),
                      // ),

                      SizedBox(
                        height: 15.h,
                      ),

                      InkWell(
                        onTap: () {
                          logout(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ' الخروج',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 12),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Spacer(),
                            Icon(
                              IconBroken.Logout,
                              color: Colors.red,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 11.h,
                      ),
                      InkWell(
                        onTap: () {
                          logout(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'حذف الحساب',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 12),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Spacer(),
                            Icon(
                              IconBroken.Delete,
                              color: Colors.red,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

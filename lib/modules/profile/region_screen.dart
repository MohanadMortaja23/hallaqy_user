import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/favorite_screen/favorite_screen.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/states.dart';

class RegionScreen extends StatelessWidget {
  final countery_id;

  RegionScreen(this.countery_id);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HallaqCubit()..getCountries(countery_id),
      child: BlocConsumer<HallaqCubit, HallaqStates>(
        listener: (context, state) {
          if (state is InfoSuccess2State) {
            navigatorReplacement(context, HallaqLayoutScreen());
            MotionToast.success(
              title: "نجاح",
              titleStyle: TextStyle(fontWeight: FontWeight.bold),
              description: 'تم تغيير المنطقة بنجاح',
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
        },
        builder: (context, state) => Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              title: InkWell(
                onTap: () {
                  navigatorPush(context, FavoriteScreen());
                },
                child: Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.favorite,
                    size: 30,
                  ),
                ),
              ),
              actions: [
                Container(
                    width: 160.w,
                    child: Center(
                        child: Text('تغيير المدينة',
                            style:
                                Theme.of(context).appBarTheme.titleTextStyle))),
                Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Image.asset(
                      'assets/images/img1.png',
                      width: 30,
                      height: 80,
                    )),
              ],
            ),
            body: HallaqCubit.get(context).countryModel != null
                ? Container(
                    margin: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w),
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                            child: Text(
                              'تغيير المدينة الحالية',
                              style: TextStyle(fontSize: 22.sp),
                            )),
                        DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black26),
                                borderRadius: BorderRadius.circular(15.r),
                                boxShadow: <BoxShadow>[
                                  //blur radius of shadow
                                ]),
                            child: Padding(
                                padding: EdgeInsets.only(left: 30, right: 30),
                                child: DropdownButton<dynamic>(
                                  value: HallaqCubit.get(context).CounteryVal,
                                  hint: Text(HallaqCubit.get(context)
                                      .initialCountery!
                                      .name
                                      .toString()
                                      .toString()),
                                  icon: Icon(
                                    Icons.arrow_circle_down_rounded,
                                    color: Colors.black,
                                  ),
                                  items: HallaqCubit.get(context)
                                      .countryModel!
                                      .data!
                                      .map((e) {
                                    return DropdownMenuItem(
                                      alignment: AlignmentDirectional.topCenter,
                                      value: e.id,
                                      child: Text(e.name.toString()),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    HallaqCubit.get(context)
                                        .changeCounteryValue(value);
                                    print(value);
                                  },
                                  isExpanded:
                                      true, //make true to take width of parent widget
                                  underline: Container(), //empty line
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                  iconEnabledColor: Colors.white, //Icon color
                                ))),
                        SizedBox(
                          height: 20.0.h,
                        ),
                        ConditionalBuilder(
                          condition: state is! InfoLoadingState,
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                          builder: (context) => gradientButton(
                              context: context,
                              title: Text(
                                'تأكيد تعديل المنطقة ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.sp),
                              ),
                              onPressed: () {
                                HallaqCubit.get(context).InfoData2(
                                    country:
                                        HallaqCubit.get(context).CounteryVal);
                              }),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Lottie.asset(
                      'assets/lottiefiles/loader2.json',
                      width: 200,
                      height: 200,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

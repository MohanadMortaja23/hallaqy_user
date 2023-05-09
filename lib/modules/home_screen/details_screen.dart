import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app/modules/home_screen/hajz.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/states.dart';

class DetailsScreen extends StatelessWidget {
  int id;
  DetailsScreen(this.id);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HallaqCubit()
        ..getDetailsCard(id: id)
        ..getEmployeesData(partner_id: id)
        ..EmployeeData(partner_id: id),
      child: BlocConsumer<HallaqCubit, HallaqStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HallaqCubit cubit = HallaqCubit.get(context);

          return cubit.detailsModel != null
              ? Directionality(
                  textDirection: TextDirection.rtl,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text('الصالون'),
                    ),
                    body: SingleChildScrollView(
                        child: Column(
                      children: [
                        Container(
                            constraints: BoxConstraints(
                                maxHeight: 200.h, maxWidth: double.infinity),
                            child: Image.network(
                                '${cubit.detailsModel!.data!.image}')),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 12.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  '${cubit.detailsModel!.data!.name}',
                                  style: TextStyle(
                                    fontSize: 30.sp,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0, // shadow blur
                                        color: Colors.orange, // shadow color
                                        offset: Offset(2.0,
                                            2.0), // how much shadow will be shown
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Row(
                              //   children: [
                              //     Text(
                              //       'التقييم',
                              //       style: TextStyle(
                              //           color: Colors.black,
                              //           fontWeight: FontWeight.bold,
                              //           fontSize: 15),
                              //     ),
                              //     Spacer(),
                              //     RatingBar.builder(
                              //       initialRating: 3,
                              //       minRating: 1,
                              //       direction: Axis.horizontal,
                              //       allowHalfRating: true,
                              //       itemCount: 5,
                              //       itemPadding:
                              //           EdgeInsets.symmetric(horizontal: 4.0),
                              //       itemBuilder: (context, _) => Icon(
                              //         Icons.star,
                              //         color: Colors.amber,
                              //       ),
                              //       onRatingUpdate: (rating) {
                              //         print(rating);
                              //       },
                              //     )
                              //   ],
                              // ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 15.h, horizontal: 50.w),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          launch(
                                              "tel://${cubit.detailsModel!.data!.phone}");
                                        },
                                        child: Icon(Icons.call,
                                            color: Colors.black),
                                        style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          padding: EdgeInsets.all(20),
                                          backgroundColor:
                                              Colors.white, // <-- Button color
                                          foregroundColor:
                                              Colors.red, // <-- Splash color
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          String url() {
                                            if (Platform.isAndroid) {
                                              // add the [https]
                                              return "https://wa.me/${cubit.detailsModel!.data!.phone}/?text=${Uri.parse('')}"; // new line
                                            } else {
                                              // add the [https]
                                              return "https://api.whatsapp.com/send?phone=${cubit.detailsModel!.data!.phone}=${Uri.parse('')}"; // new line
                                            }
                                          }

                                          launch(url());
                                        },
                                        child: Image.asset(
                                          'assets/images/whatsapp.png',
                                          height: 30,
                                          fit: BoxFit.contain,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          padding: EdgeInsets.all(20),
                                          backgroundColor:
                                              Colors.white, // <-- Button color
                                          foregroundColor:
                                              Colors.red, // <-- Splash color
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                'المتخصصون',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 135.h,
                                width: double.infinity,
                                child: cubit.employeemodel != null
                                    ? ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount:
                                            cubit.employeemodel!.data!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) =>
                                                SpecialistItem(
                                                  img: cubit.employeemodel!
                                                      .data![index].image,
                                                  name: cubit.employeemodel!
                                                      .data![index].name,
                                                ))
                                    : Center(
                                        child: Lottie.asset(
                                            'assets/lottiefiles/loader.json',
                                            width: 25.w,
                                            height: 25.h)),
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(top: 20.h, bottom: 10.h),
                                child: Text(
                                  'ساعات العمل',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              ListView.builder(
                                itemCount: cubit
                                    .detailsModel!.data!.workingHours!.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return TimeWork(
                                      day: cubit.detailsModel!.data!
                                          .workingHours![index].day,
                                      from: cubit.detailsModel!.data!
                                          .workingHours![index].from,
                                      to: cubit.detailsModel!.data!
                                          .workingHours![index].to);
                                },
                              ),

                              Container(
                                margin: EdgeInsets.symmetric(vertical: 15.h),
                                child: gradientButton(
                                    context: context,
                                    title: Text(
                                      'إحجز الآن ',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    onPressed: () {
                                      navigatorPush(
                                          context,
                                          Hajz(id, cubit.employeemodel,
                                              cubit.id_employee));
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                  ))
              : Scaffold(
                  body: Center(
                    child: Lottie.asset('assets/lottiefiles/loader2.json',
                        width: 200.w, height: 200.h),
                  ),
                );
        },
      ),
    );
  }
}

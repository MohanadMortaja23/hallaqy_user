import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

import '../../modules/home_screen/details_screen.dart';
import 'constants.dart';

Widget textFormField({
  TextEditingController? controller,
  Widget? suffixIcon,
  Widget? prefixIcon,
  OutlineInputBorder? enabledBorder,
  OutlineInputBorder? focusedBorder,
  Color? fillColor,
  Color? cursorColor,
  String? hintText,
  String? labelText,
  TextStyle? hintStyle,
  TextStyle? labelStyle,
  TextStyle? style,
  bool? filled,
  int? maxLines,
//  TextInputAction textInputAction,
  TextInputType? keyboardType,
  dynamic validator,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      fillColor: fillColor,
      hintText: hintText,
      hintStyle: hintStyle,
      labelText: labelText,
      labelStyle: labelStyle,
      filled: filled,
    ),
    style: style,
    // textInputAction: textInputAction,
    validator: validator,
    cursorColor: cursorColor,
    maxLines: maxLines,
    keyboardType: keyboardType,
  );
}

OutlineInputBorder focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(20.0),
  borderSide: BorderSide(
    color: Color.fromARGB(255, 219, 211, 211),
  ),
);

OutlineInputBorder enabledBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(20.0),
  borderSide: BorderSide(
    color: Color.fromARGB(255, 194, 184, 184),
  ),
);

navigatorPush(context, screen) {
  return Navigator.push(context, MaterialPageRoute(builder: (context) {
    return screen;
  }));
}

navigatorReplacement(context, screen) {
  return Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) {
    return screen;
  }));
}

Widget profileItem2({
  required BuildContext context,
  String? title,
  dynamic onTap,
  required Icon icon,
}) {
  return Container(
    margin: EdgeInsets.only(top: 25.h),
    child: Row(
      children: [
        icon,
        Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: Text(
            title!,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        Spacer(),
        InkWell(onTap: onTap, child: Icon(IconBroken.Arrow___Left_Circle))
      ],
    ),
  );
}

Widget profileItem({
  required BuildContext context,
  String? title,
  String? content,
  dynamic onTap,
}) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 15.0,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Color.fromARGB(255, 214, 210, 210),
          ),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    content!,
                    style: TextStyle(
                      color: Colors.grey,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                InkWell(
                  onTap: onTap,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: Colors.white,
                    ),
                    width: 35,
                    height: 35,
                    child: Icon(
                      IconBroken.Edit,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget gradientButton(
    {required BuildContext context, dynamic onPressed, Widget? title}) {
  return Container(
    clipBehavior: Clip.antiAlias,
    width: MediaQuery.of(context).size.width,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: Color(0xffC9574D),
    ),
    child: MaterialButton(
      onPressed: onPressed,
      child: title,
    ),
  );
}

Widget gradientButton2(
    {required BuildContext context, dynamic onPressed, Widget? title, color}) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: Container(
      clipBehavior: Clip.antiAlias,
      width: MediaQuery.of(context).size.width,
      height: 50.h,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Color(0xffC9574D)),
          borderRadius: BorderRadius.circular(20.r)),
      child: MaterialButton(
        onPressed: onPressed,
        child: title,
      ),
    ),
  );
}

Widget SpecialistItem({check, img, name}) {
  return Card(
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Container(
      width: 120.w,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.r),
              child: CachedNetworkImage(
                imageUrl: '$img',
                placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 1.5.w,
                )),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Color(0xffC9574D),
                ),
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  backgroundImage: imageProvider,
                  radius: 40.r,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white10),
            padding: EdgeInsets.only(top: 5.h),
            child: Text(
              '$name',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 5,
    margin: EdgeInsets.all(10),
  );
}

Widget CardItemHajzi() {
  return Card(
    elevation: 3,
    margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.r),
    ),
    child: ClipRRect(
      child: Container(
        padding: EdgeInsets.all(12),
        height: 175.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25.r)),
        child: Column(
          children: [
            Text(
              'ديسمبر 22,2022 - 10:00 ص',
              style: GoogleFonts.notoKufiArabic(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
            Divider(),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10.w),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.r)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.r),
                    child: Image.network(
                      'https://media.gemini.media/img/large/2018/4/4/2018_4_4_16_0_54_209.jpg',
                      width: 100.w,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'صالون الأكابر',
                          style: GoogleFonts.notoKufiArabic(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 40.w,
                        ),
                        Icon(Icons.favorite)
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: Text(
                        'غزة',
                        style: GoogleFonts.notoKufiArabic(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        Text(
                          '1.7 km',
                          style: GoogleFonts.notoKufiArabic(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.red,
                        ),
                        Text(
                          '4.5',
                          style: GoogleFonts.notoKufiArabic(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget CardItem(ctx, text, space, city, star, image,
    {order = false, index, isLiked, onTapFavourite}) {
  return InkWell(
    onTap: () {
      navigatorPush(ctx, DetailsScreen(index));
    },
    child: Card(
      elevation: 3,
      margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Column(
        children: [
          ClipRRect(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: 128.h,
              ),
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(ctx).cardColor,
                  borderRadius: BorderRadius.circular(25.r)),
              child: Row(
                children: [
                  Container(
                    constraints:
                        BoxConstraints(maxHeight: 120.h, maxWidth: 100.w),
                    margin: EdgeInsets.only(left: 10.w),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(25.r)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.r),
                      child: Image.network(
                        '$image',
                        width: 100.w,
                        height: 120.h,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    width: 180.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 5.h),
                              constraints: BoxConstraints(maxWidth: 120.w),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      '$text',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: 15.w, left: 15.w, top: 15.h),
                                        child: Row(
                                          children: [
                                            Text(
                                              '$city',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                shadows: [
                                                  Shadow(
                                                    blurRadius:
                                                        10.0, // shadow blur
                                                    color: Colors
                                                        .black26, // shadow color
                                                    offset: Offset(2.0,
                                                        2.0), // how much shadow will be shown
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            Align(
                              alignment: Alignment.topLeft,
                              child: LikeButton(
                                  likeBuilder: (isLiked) {
                                    return Icon(
                                      size: 35.r,
                                      Icons.favorite,
                                      color:
                                          isLiked ? Colors.red : Colors.black45,
                                    );
                                  },
                                  isLiked: isLiked,
                                  onTap: onTapFavourite),

                              // (isLiked) async {
                              //     return ;
                              //   },
                            )
                          ],
                        ),

                        // Row(
                        //   children: [
                        //     Icon(
                        //       Icons.location_on,
                        //       color: Colors.red,
                        //     ),
                        //     Text(
                        //       '$space',
                        //       style: GoogleFonts.notoKufiArabic(
                        //           color: Colors.black,
                        //           fontSize: 11,
                        //           fontWeight: FontWeight.normal),
                        //     ),
                        //     SizedBox(
                        //       width: 20.w,
                        //     ),
                        //     Icon(
                        //       Icons.star,
                        //       color: Colors.red,
                        //     ),
                        //     Text(
                        //       '$star',
                        //       style: GoogleFonts.notoKufiArabic(
                        //           color: Colors.black,
                        //           fontSize: 11,
                        //           fontWeight: FontWeight.normal),
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget NotitcatonItem(ctx, text, subText) {
  return Card(
    elevation: 3,
    margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.r),
    ),
    child: Column(
      children: [
        ClipRRect(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: 120.h,
            ),
            padding: EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(ctx).cardColor,
                borderRadius: BorderRadius.circular(25.r)),
            child: Container(
              width: 180.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            '$text',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: 15.w, left: 15.w, top: 15.h),
                              child: Row(
                                children: [
                                  Text(
                                    '$subText',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 10.0, // shadow blur
                                          color: Colors.black26, // shadow color
                                          offset: Offset(2.0,
                                              2.0), // how much shadow will be shown
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget TimeItem(color, time) {
  return Card(
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child:
        Container(color: color, width: 80.w, child: Center(child: Text(time))),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 5,
    margin: EdgeInsets.all(10),
  );
}

ShowDigalog(context, msg, stats) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      content: Container(
        height: 400.h,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.h),
              width: 150.w,
              height: 150.h,
              child: stats == true
                  ? Lottie.asset('assets/lottiefiles/sucess.json',
                      width: 80.w, height: 80.h)
                  : Lottie.asset('assets/lottiefiles/failed.json',
                      width: 80.w, height: 80.h),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.h),
              child: Center(
                child: Text(
                  '$msg',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30.h),
              child: gradientButton(
                  context: context,
                  title: Text(
                    'الرجوع للصفحة الرئيسية',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    navigatorReplacement(context, HallaqLayoutScreen());
                  }),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget TimeWork({day, from, to}) {
  return Card(
    elevation: 4,
    child: Container(
      height: 45.h,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
      margin: EdgeInsets.only(bottom: 0.h, top: 0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffC9574D),
                  borderRadius: BorderRadius.circular(0.r)),
              width: 120.w,
              child: Center(
                child: Text(
                  ' $day',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          if (from == to)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
              ),
              width: 120.w,
              child: Center(
                child: Text(
                  'يوم عطلة عند الحلاق',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.red),
                ),
              ),
            ),
          if (from != to)
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  width: 50.w,
                  child: Center(
                    child: Text(
                      '$from',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
                  width: 50.w,
                  child: Center(
                    child: Text(
                      'إلى',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
                  width: 50.w,
                  child: Center(
                    child: Text(
                      '$to',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    ),
  );
}

Widget CardItemOrder(
    {ctx,
    text,
    image,
    date,
    time,
    number,
    staff,
    onTap,
    id,
    cubit,
    index,
    status}) {
  return InkWell(
    onTap: () {},
    child: Card(
      elevation: 3,
      margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Column(
        children: [
          ClipRRect(
            child: Container(
              constraints: BoxConstraints(
                minHeight: 170.h,
                maxHeight: 300.h,
              ),
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(ctx).cardColor,
                  borderRadius: BorderRadius.circular(25.r)),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      constraints:
                          BoxConstraints(maxHeight: 140.h, maxWidth: 100.w),
                      margin: EdgeInsets.only(left: 10.w),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(25.r)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25.r),
                        child: Image.network(
                          '$image',
                          width: 100.w,
                          height: 120.h,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      width: 180.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 5.h),
                                    constraints:
                                        BoxConstraints(maxWidth: 140.w),
                                    child: Center(
                                      child: Text(
                                        '$text',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.notoKufiArabic(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  if (status == 'pending')
                                    InkWell(
                                      onTap: onTap,
                                      child: Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                      ),
                                    )
                                ],
                              ),
                              Divider(),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'رقم الحجز : ',
                                style: GoogleFonts.notoKufiArabic(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                '$number',
                                style: GoogleFonts.notoKufiArabic(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'تاريخ الحجز: ',
                                style: GoogleFonts.notoKufiArabic(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                '$date',
                                style: GoogleFonts.notoKufiArabic(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'وقت الحجز: ',
                                style: GoogleFonts.notoKufiArabic(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                '$time',
                                style: GoogleFonts.notoKufiArabic(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          Text(
                            'اسم الموظف:$staff',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.notoKufiArabic(
                                fontSize: 15.sp, fontWeight: FontWeight.normal),
                          ),
                          Row(
                            children: [
                              Text(
                                'حالة الحجز: ',
                                style: GoogleFonts.notoKufiArabic(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                status == 'pending'
                                    ? 'قيد المتابعة'
                                    : status == 'rejected'
                                        ? 'مرفوض'
                                        : 'مقبول الحجز',
                                style: GoogleFonts.notoKufiArabic(
                                    color: status == 'pending'
                                        ? Colors.blue
                                        : status == 'rejected'
                                            ? Colors.red
                                            : Colors.green,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal),
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
          Container(
            child: Center(
              child: Text(
                status == 'pending'
                    ? '( قيد المراجعة)'
                    : status == 'rejected'
                        ? '(مرفوض يرجى مراجعة الحلاق لمعرفة سبب الرفض عبر الواتس اب)'
                        : '(تم قبول الحجز)',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.notoKufiArabic(
                    fontSize: 15.sp, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Future<bool> showPopupUpdatstaff(
    id, context, HallaqCubit cubit, index, ontaptrue) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            constraints: BoxConstraints(maxHeight: 140.h, maxWidth: 100.w),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("تأكيد حذف طلب الحجز",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'cairo',
                          fontSize: 16.sp)),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: ontaptrue,
                          child: const Text("نعم",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'cairo',
                                  fontSize: 16)),
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          print('no selected');
                          Navigator.of(context).pop();
                        },
                        child: Text("لا",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'cairo',
                                fontSize: 16.sp)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}

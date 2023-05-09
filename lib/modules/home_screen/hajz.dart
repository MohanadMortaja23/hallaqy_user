import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app/models/employee_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

import '../../shared/cubit/states.dart';

class Hajz extends StatelessWidget {
  final id;
  final employee_id;
  EmployeeMdoel? employeemode;
  Hajz(this.id, this.employeemode, this.employee_id);
  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => HallaqCubit()
          ..getTimeWorkData(
              partner_id: id,
              day_id: HallaqCubit.get(context).Day_id,
              employee_id: employee_id)
          ..changeColorhallaqIndex(0, employeemode!.data![0].id),
        child: BlocConsumer<HallaqCubit, HallaqStates>(
          listener: (context, state) {
            if (state is HallaqSuccessAddOrderState) {
              ShowDigalog(
                  context,
                  HallaqCubit.get(context).messageMdoel2!.message,
                  HallaqCubit.get(context).messageMdoel2!.status);
            }
          },
          builder: (context, state) {
            var cubit = HallaqCubit.get(context);

            return Scaffold(
              appBar: AppBar(
                title: Text('احجز موعد'),
              ),
              body: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.h),
                        child: Text(
                          'أختر يوم الحجز ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      _buildDefaultSingleDatePickerWithValue(context),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       flex: 1,
                      //       child: Container(
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(20.r)),
                      //         child: gradientButton2(
                      //             color: HallaqCubit.get(context).color3,
                      //             context: context,
                      //             title: Text(
                      //               'اليوم ',
                      //               style: TextStyle(
                      //                   color: Colors.black, fontSize: 16),
                      //             ),
                      //             onPressed: () {
                      //               HallaqCubit.get(context)
                      //                   .changeColorDay1Index();
                      //               HallaqCubit.get(context).changeTimeWork(1);
                      //               HallaqCubit.get(context).getTimeWorkData(
                      //                   day_id: 1,
                      //                   partner_id: id,
                      //                   employee_id: HallaqCubit.get(context)
                      //                       .id_employee);
                      //               //   HallaqCubit.get(context).changeColorDayIndex(index)
                      //             }),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       flex: 1,
                      //       child: Container(
                      //         width: 120.w,
                      //         margin: EdgeInsets.symmetric(
                      //             vertical: 15.h, horizontal: 5.w),
                      //         child: gradientButton2(
                      //             color: HallaqCubit.get(context).color4,
                      //             context: context,
                      //             title: Text(
                      //               'غداً ',
                      //               style: TextStyle(
                      //                   color: Colors.black, fontSize: 16),
                      //             ),
                      //             onPressed: () {
                      //               HallaqCubit.get(context)
                      //                   .changeColorDay2Index();
                      //               HallaqCubit.get(context).changeTimeWork(2);
                      //               HallaqCubit.get(context).getTimeWorkData(
                      //                   day_id: 2,
                      //                   partner_id: id,
                      //                   employee_id: HallaqCubit.get(context)
                      //                       .id_employee);
                      //             }),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Text(
                        'المتخصصون',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Container(
                          constraints: BoxConstraints(
                            maxHeight: 170.h,
                          ),
                          width: double.infinity,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: employeemode!.data!.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  InkWell(
                                      onTap: () {
                                        HallaqCubit.get(context)
                                            .changeColorhallaqIndex(index,
                                                employeemode!.data![index].id);
                                        HallaqCubit.get(context)
                                            .getTimeWorkData(
                                                day_id: HallaqCubit.get(context)
                                                    .Day_id,
                                                employee_id:
                                                    HallaqCubit.get(context)
                                                        .id_employee,
                                                partner_id: id);
                                      },
                                      child: Column(
                                        children: [
                                          SpecialistItem(
                                            check: HallaqCubit.get(context)
                                                        .Index2 ==
                                                    index
                                                ? true
                                                : false,
                                            img: employeemode!
                                                .data![index].image,
                                            name:
                                                employeemode!.data![index].name,
                                          ),
                                          if (HallaqCubit.get(context).Index2 ==
                                              index)
                                            Container(
                                              height: 12.h,
                                              width: 50.w,
                                              decoration: BoxDecoration(
                                                  color: Color(0xffC9574D)),
                                            )
                                        ],
                                      )))),
                      Text(
                        'أختر وقت الحجز ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 50.h,
                        width: double.infinity,
                        child: cubit.workTime != null
                            ? HallaqCubit.get(context).workTime!.data!.length !=
                                    0
                                ? ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: HallaqCubit.get(context)
                                        .workTime!
                                        .data!
                                        .length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                          onTap: () {
                                            HallaqCubit.get(context)
                                                .changeColorTimeIndex(
                                                    index,
                                                    cubit.workTime!.data![index]
                                                        .time
                                                        .toString());
                                          },
                                          child: TimeItem(
                                              HallaqCubit.get(context).Index ==
                                                      index
                                                  ? Color(0xffC9574D)
                                                  : Colors.black
                                                      .withOpacity(0.5),
                                              cubit.workTime!.data![index].time
                                                  .toString()));
                                    })
                                : Container(
                                    margin: EdgeInsets.only(top: 15.h),
                                    child: Text(
                                      '${HallaqCubit.get(context).workTime!.message}',
                                      style: TextStyle(fontSize: 18.sp),
                                    ),
                                  )
                            : Center(
                                child: Lottie.asset(
                                    'assets/lottiefiles/loader.json')),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15.h),
                        child: ConditionalBuilder(
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                            condition: state is! HallaqLoadingAddOrderState,
                            builder: (context) {
                              return gradientButton(
                                  context: context,
                                  title: Text(
                                    'إحجز الآن ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  onPressed: () {
                                    HallaqCubit.get(context).addOrder(
                                        day: HallaqCubit.get(context).Day_id,
                                        employee_id: HallaqCubit.get(context)
                                            .id_employee,
                                        partner_id: id,
                                        time: cubit.timeSelected);
                                  });
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDefaultSingleDatePickerWithValue(context) {
    final config = CalendarDatePicker2Config(
      selectedDayHighlightColor: Color(0xffC9574D),
      weekdayLabels: ['احد', 'اثنين', 'ثلاث', 'اربع', 'خميس', 'جمعة', 'سبت'],
      weekdayLabelTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      firstDayOfWeek: 1,
      controlsHeight: 50.h,
      controlsTextStyle: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      disabledDayTextStyle: const TextStyle(),
      selectableDayPredicate: (day) => !day
          .difference(DateTime.now().subtract(const Duration(days: 1)))
          .isNegative,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CalendarDatePicker2(
          config: config,
          initialValue: _singleDatePickerValueWithDefaultValue,
          onValueChanged: (values) {
            print(values.first);
            HallaqCubit.get(context).changeTimeWork(values.first);
            HallaqCubit.get(context).getTimeWorkData(
                day_id: HallaqCubit.get(context).Day_id,
                partner_id: id,
                employee_id: HallaqCubit.get(context).id_employee);
            // String formattedDate = DateFormat('yyyy-MM-dd').format(values.first as DateTime);
            //     print(formattedDate)
            print(HallaqCubit.get(context).Day_id);
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }
}

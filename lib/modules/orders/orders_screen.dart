import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shop_app/shared/components/components.dart';

import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../../models/order_model.dart';

class OrdersScreen extends StatefulWidget {
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<HallaqCubit>(context).Get_Myorder();
          print(1);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('1231231231231232222222222222');
    return BlocProvider(
        create: (context) => HallaqCubit()..Get_Myorder(),
        child: BlocConsumer<HallaqCubit, HallaqStates>(
            listener: (context, state) {},
            builder: (context, state) {
              setupScrollController(context);
              return _OrderList();
            }));
  }

  Widget _loadingIndicator() {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Lottie.asset('assets/lottiefiles/loader2.json',
              height: 200, width: 200),
        ));
  }

  Widget _OrderList() {
    return BlocBuilder<HallaqCubit, HallaqStates>(builder: (context, state) {
      if (state is MyOrderLoadingState && state.isFirstFetch) {
        return _loadingIndicator();
      }

      bool isLoading = false;

      if (state is MyOrderLoadingState) {
        HallaqCubit.get(context).posts = state.oldPosts;
        isLoading = true;
      } else if (state is MyOrderSuccessState) {
        HallaqCubit.get(context).posts = state.Posts;
      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          leading: Container(
            margin: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.notifications,
              size: 30,
            ),
          ),
          title: Text('حجوزاتي',
              style: Theme.of(context).appBarTheme.titleTextStyle),
        ),
        body: SingleChildScrollView(
          controller: scrollController,
          child: HallaqCubit.get(context).posts.length != 0
              ? Column(
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: HallaqCubit.get(context).posts.length,
                      itemBuilder: (context, index) {
                        if (index < HallaqCubit.get(context).posts.length)
                          return CardItemOrder(
                              image: HallaqCubit.get(context)
                                  .posts[index]
                                  .partnerImage,
                              text: HallaqCubit.get(context)
                                  .posts[index]
                                  .partnerName,
                              number:
                                  HallaqCubit.get(context).posts[index].number,
                              date: HallaqCubit.get(context).posts[index].date,
                              time: HallaqCubit.get(context).posts[index].time,
                              ctx: context,
                              staff: HallaqCubit.get(context)
                                  .posts[index]
                                  .employeeName,
                              onTap: () {
                                setState(() {
                                  showPopupUpdatstaff(
                                      HallaqCubit.get(context).posts[index].id,
                                      context,
                                      HallaqCubit.get(context),
                                      index, () {
                                    setState(() {
                                      HallaqCubit.get(context)
                                          .DeleteOrder(
                                              id: HallaqCubit.get(context)
                                                  .posts[index]
                                                  .id,
                                              context: context,
                                              index: index)
                                          .then((value) {});
                                      Navigator.of(context).pop();
                                    });
                                  });

                                  // HallaqCubit.get(context)
                                  //     .DeleteOrder(
                                  //         id: HallaqCubit.get(context)
                                  //             .posts[index]
                                  //             .id,
                                  //         context: context,
                                  //         index: index)
                                  //     .then((value) {});
                                });
                              },
                              id: HallaqCubit.get(context).posts[index].id,
                              cubit: HallaqCubit.get(context),
                              index: index,
                              status:
                                  HallaqCubit.get(context).posts[index].status);
                        else {
                          Timer(Duration(milliseconds: 30), () {
                            scrollController.jumpTo(
                                scrollController.position.maxScrollExtent);
                          });

                          return Container();
                        }
                      },
                    ),
                    state is MyOrderLoadingState
                        ? _loadingIndicator()
                        : Text('')
                  ],
                )
              : Center(
                  child: Lottie.asset('assets/lottiefiles/empty.json',
                      width: 500.w, height: 500.h),
                ),
        ),
      );
    });
  }
}

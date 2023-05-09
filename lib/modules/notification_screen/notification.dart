import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

import '../../shared/cubit/states.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HallaqCubit()..getNotification(),
      child: BlocConsumer<HallaqCubit, HallaqStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                appBar: AppBar(
                  title: Text('الإشعارات'),
                ),
                body: HallaqCubit.get(context).notificationModel != null
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          return NotitcatonItem(
                              context,
                              HallaqCubit.get(context)
                                  .notificationModel!
                                  .data!
                                  .data![index]
                                  .title,
                              HallaqCubit.get(context)
                                  .notificationModel!
                                  .data!
                                  .data![index]
                                  .message);
                        },
                        itemCount: HallaqCubit.get(context)
                            .notificationModel!
                            .data!
                            .data!
                            .length)
                    : Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Lottie.asset('assets/lottiefiles/loader2.json',
                              height: 200, width: 200),
                        ))),
          );
        },
      ),
    );
  }
}

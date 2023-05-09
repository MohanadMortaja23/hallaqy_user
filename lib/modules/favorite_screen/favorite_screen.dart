import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

import '../../shared/cubit/states.dart';
import '../../shared/styles/icon_broken.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => HallaqCubit()..GetFavorite(),
        child: BlocConsumer<HallaqCubit, HallaqStates>(
          listener: (context, state) {},
          builder: (context, state) {
            HallaqCubit cubit = HallaqCubit.get(context);

            return HallaqCubit.get(context).favouriteModel != null
                ? Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          navigatorReplacement(context, HallaqLayoutScreen());
                        },
                      ),
                      title: Text('المفضلة'),
                    ),
                    body: ListView.builder(
                      itemCount: cubit.favouriteModel!.data!.length,
                      itemBuilder: (context, index) {
                        return CardItem(
                          context,
                          cubit.favouriteModel!.data![index].name,
                          cubit.favouriteModel!.data![index].distance,
                          cubit.favouriteModel!.data![index].address,
                          cubit.favouriteModel!.data![index].rating,
                          cubit.favouriteModel!.data![index].image,
                          index: cubit.favouriteModel!.data![index].id,
                          isLiked:
                              cubit.favouriteModel!.data![index].isFavourite,
                          onTapFavourite: (isLiked) async {
                            cubit.PostFavorite(
                                partner_id:
                                    cubit.favouriteModel!.data![index].id);
                            return !isLiked;
                          },
                        );
                      },
                    ))
                : Scaffold(
                    body: Center(
                      child: Lottie.asset('assets/lottiefiles/loader2.json',
                          width: 200.w, height: 200.h),
                    ),
                  );
          },
        ),
      ),
    );
  }
}

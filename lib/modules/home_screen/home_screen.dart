import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app/modules/favorite_screen/favorite_screen.dart';
import 'package:shop_app/modules/notification_screen/notification.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

import '../../models/home_model.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<HallaqCubit>(context).getHomeData(search: '');
          print('1111111111111');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HallaqCubit()..getHomeData(search: ''),
      child: BlocConsumer<HallaqCubit, HallaqStates>(
        listener: (context, state) {},
        builder: (context, state) {
          setupScrollController(context);

          return Scaffold(
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
                leading: InkWell(
                  onTap: () {
                    navigatorPush(context, NotificationScreen());
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Icon(
                      Icons.notifications,
                      size: 30,
                    ),
                  ),
                ),
                actions: [
                  Container(
                      width: 120.w,
                      child: Center(
                          child: Text('الصالونات',
                              style: Theme.of(context)
                                  .appBarTheme
                                  .titleTextStyle))),
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Image.asset(
                        'assets/images/img1.png',
                        width: 30,
                        height: 80,
                      )),
                ],
              ),
              body: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: TextField(
                        cursorColor: indigo,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'البحث',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 68, 66, 66),
                              fontSize: 22),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color.fromARGB(255, 68, 66, 66),
                          ),
                          enabledBorder: enabledBorder,
                          focusedBorder: focusedBorder,
                          errorBorder: enabledBorder,
                          focusedErrorBorder: focusedBorder,
                        ),
                        onSubmitted: (value) {
                          HallaqCubit.get(context).pageHome = 0;
                          HallaqCubit.get(context)
                              .getHomeData(search: value.toString());

                          print(value);
                        },
                      ),
                    ),
                    _OrderList(),
                  ],
                ),
              ));
        },
      ),
    );
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
      if (state is HallaqLoadingHomeDataState && state.isFirstFetch) {
        return _loadingIndicator();
      }

      List<DataHome> posts = [];
      bool isLoading = false;

      if (state is HallaqLoadingHomeDataState) {
        posts = state.oldPosts;
        isLoading = true;
      } else if (state is HallaqSuccessHomeDataState) {
        posts = state.Posts;
      }
      return Stack(
        children: [
          Container(
            decoration:
                BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: 20.w),
                child: Text('الصالونات',
                    style:
                        TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold)

                    // TextStyle(
                    //     color: Colors.black,
                    //     fontSize: 33,
                    //     fontWeight: FontWeight.bold),
                    ),
              ),
              Divider(
                thickness: 2,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index < posts.length)
                    return CardItem(
                      context,
                      posts[index].name,
                      posts[index].distance,
                      posts[index].address,
                      posts[index].rating,
                      posts[index].image,
                      index: posts[index].id,
                      isLiked: posts[index].isFavourite,
                      onTapFavourite: (isLiked) async {
                        HallaqCubit.get(context).PostFavorite(
                            partner_id: HallaqCubit.get(context)
                                .homeModel!
                                .data![index]
                                .id);
                        return !isLiked;
                      },
                    );
                  else {
                    Timer(Duration(milliseconds: 30), () {
                      scrollController
                          .jumpTo(scrollController.position.maxScrollExtent);
                    });

                    return Container();
                  }
                },
                itemCount: posts.length,
              ),
              state is HallaqLoadingHomeDataState
                  ? _loadingIndicator()
                  : Text('')
            ],
          )
        ],
      );
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/app_cubit.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/components/components.dart';

import '../cubit/states.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),

          ),
          appBar: AppBar(
            title: const Text("News"),
            actions: [
              IconButton(onPressed: () {
                navigateTo(context, SearchScreen());
              }, icon: const Icon(Icons.search)),
              IconButton(onPressed: () {
                AppCubit.get(context).changeTheme();
              }, icon: const Icon(Icons.brightness_2_outlined))
            ],
          ),
          body: cubit.screens[cubit.curInedx],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.curInedx,
              items: cubit.bottomItems,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
              ),
        );
      },
    );
  }
}

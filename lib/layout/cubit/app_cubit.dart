import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/app_states.dart';
import 'package:news_app/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  ThemeMode appTheme = ThemeMode.dark;
  bool isDark = true;

  void changeTheme({bool? fromShared}) {
    if(fromShared!=null) {
      isDark=fromShared;
      emit(ChangeAppTheme());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark)
          .then((value) => emit(ChangeAppTheme()));
    }


  }
}

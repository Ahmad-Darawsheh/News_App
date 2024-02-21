import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/modules.business/business_screen.dart';
import '../../modules/modules.finance/finance_screen.dart';
import '../../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{

  NewsCubit() : super(NewsInitalState());

  static NewsCubit get(context)=> BlocProvider.of(context);

  int curInedx=0;

  List<BottomNavigationBarItem> bottomItems=[
    const BottomNavigationBarItem(
        icon: Icon(Icons.business_center_rounded),
      label: "Business"
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.monetization_on_outlined),
        label: "Finance"
    ),

  ];

  void changeBottomNavBar(int index){
    curInedx=index;
    emit(NewsBottomNavState());
  }

  List<Widget>  screens=[
    const BusinessScreen(),
    const FinanceScreen(),

  ];

  List<dynamic> business=[];


  void getBusiness() {
    emit(NewsBusinessLoadingState());
    DioHelper.getData(path: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'business',
      'apiKey': '027095661ad341578afb8fcff5782677'
    }).then((value) {
      business = value.data['articles'];
      emit(GetBusinessState());
    }).catchError((onError) {
      emit(ErrorBusinessState(onError.toString()));
    });

  }

  List<dynamic> finance=[];

  void getFinance() {
    emit(NewsFinanceLoadingState());
    DioHelper.getData(path: 'v2/everything', query: {
      'domains': 'wsj.com',
    'apiKey':'027095661ad341578afb8fcff5782677'
    }).then((value) {
      finance = value.data['articles'];
      emit(GetFinanceState());
    }).catchError((onError) {
      emit(ErrorFinanceState(onError.toString()));
    });

  }
  List<dynamic> search=[];

  void getSearch(String value){

    emit(NewsSearchLoadingState());
    search=[];
    DioHelper.getData(path: 'v2/everything', query: {
      'q': '$value',
      'apiKey':'027095661ad341578afb8fcff5782677'
    }).then((value) {
      search = value.data['articles'];
      emit(GetSearchState());
    }).catchError((onError) {
      emit(ErrorSearchState(onError.toString()));
    });
  }


}
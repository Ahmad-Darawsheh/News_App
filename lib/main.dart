import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/app_cubit.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/styles/bloc_observer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'layout/cubit/app_states.dart';
import 'layout/cubit/cubit.dart';
import 'layout/news_app/news_layout.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();

  bool? isDark=CacheHelper.getData(key: 'isDark');
  runApp( MyApp(isDark!));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  const MyApp(this.isDark, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>NewsCubit()..getBusiness()..getFinance()),
        BlocProvider(create: (context)=>AppCubit()..changeTheme(fromShared: isDark))
      ],
      child: BlocConsumer<AppCubit,AppStates>(

        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(

            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange
              ),
              appBarTheme:const AppBarTheme(
                  iconTheme: IconThemeData(
                      color: Colors.black,

                  ),

                titleSpacing: 20,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.red,
                    statusBarIconBrightness: Brightness.light,
                  ),
                  color: Colors.white,
                  elevation: 0,
                  actionsIconTheme: IconThemeData(color: Colors.black)
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 30
              ),
              textTheme: const TextTheme(bodyMedium:TextStyle(
                  fontSize: 18,fontWeight: FontWeight.w600,
                  color: Colors.black
              ) ),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor('333739'),
              primarySwatch: Colors.deepOrange,
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange
              ),
              appBarTheme: AppBarTheme(
                titleSpacing: 20,
                titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white
                ),
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.grey,
                  statusBarIconBrightness: Brightness.light,
                ),
                color: HexColor('333739'),
                elevation: 30,
                actionsIconTheme: IconThemeData(color: Colors.white),

              ),
              bottomNavigationBarTheme:  BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 30,
                  backgroundColor: HexColor('333739'),
                  unselectedItemColor: Colors.white
              ),
              textTheme: const TextTheme(bodyMedium:TextStyle(
                  fontSize: 18,fontWeight: FontWeight.w600,
                  color: Colors.white
              ) ),

            ),
            themeMode:AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light ,
            home:const NewsApp(),
          );
        },
      ),
    );
  }
}



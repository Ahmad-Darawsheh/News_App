import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext contextF) {
    var article=NewsCubit.get(contextF).finance;
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder:(context,state){
        return  ConditionalBuilder(

            condition: article.isNotEmpty  ,
            builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index)=>buildArticleItem(
                  article: article[index], context: contextF,
                ),
                separatorBuilder: (context,index)=>const SizedBox(height: 5 ,),
                itemCount: article.length) ,
            fallback: (context)=>const Center(child: CircularProgressIndicator(),)
        );
      } ,
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../../layout/news_app/cubit/Cubit.dart';
import '../../layout/news_app/cubit/States.dart';
import '../../shared/compenents/Components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates> (
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return buildScreen(
            list: cubit.business,
            buildContext: context
        );
      },
    );
  }
}
//ListView.separated(
//             itemBuilder: (context, index) => buildArticleItem(article: cubit.business[index]),
//             separatorBuilder: (context, index) => Expanded(child: Container(height: 1,width: double.infinity,)),
//             itemCount: 5);
//buildArticleItem(article: cubit.business)
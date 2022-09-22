import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:news/layout/news_app/cubit/Cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/news_app/cubit/States.dart';
import '../../shared/compenents/Components.dart';

class ScienceScreen extends StatelessWidget {
  // const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates> (
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return buildScreen(
            list: cubit.science ,
            buildContext: context
        );
      },
    );
  }
}
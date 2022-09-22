
import 'package:news/layout/news_app/cubit/States.dart';
import 'package:news/shared/compenents/Components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/news_app/cubit/Cubit.dart';

class NewsSearch extends StatelessWidget {
  // const NewsSearch({Key? key}) : super(key: key);
  var searchController  = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: searchController,
                          onFieldSubmitted: (value)  {
                            cubit.getSearch(value: value);
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Search",
                            border: OutlineInputBorder(),
                        ),
                        ),
                      ),
                    ],
                  ),
                )
                ,
                
                Expanded(
                  child: buildScreen(
                      list: cubit.search,
                      buildContext: context),
                ),
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}

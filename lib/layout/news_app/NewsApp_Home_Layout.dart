import 'package:news/layout/news_app/cubit/Cubit.dart';
import 'package:news/layout/news_app/cubit/States.dart';
import 'package:news/modules/news_search/NewsSearch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget {
  // const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "News App",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  NewsSearch())
                    );
                  }
                  ,
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    NewsCubit.get(context).refreshApp();
                  }
                  ,
                  icon: Icon(
                    Icons.refresh
                      )
                    ),
              
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomNavIcons,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            currentIndex: cubit.currentIndex,
          ),
          body: cubit.screens[cubit.currentIndex],
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     print("sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss");
          //     NewsCubit.get(context).getBusiness();
          //   },
          //   child: Icon(Icons.get_app),
          // ),
        );
      },
    );
  }
}
/*
 Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var cubit = NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News App',
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: ()
                {
                  navigateTo(context, SearchScreen(),);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.brightness_4_outlined,
                ),
                onPressed: ()
                {
                  AppCubit.get(context).changeAppMode();
                },
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}
 */
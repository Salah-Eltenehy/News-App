import 'dart:math';

import 'package:news/modules/Business/business_screen.dart';
import 'package:news/modules/science/Science.dart';
import 'package:news/modules/sports/Sports.dart';
import 'package:news/shared/networks/remote/Dio_Helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/news_app/cubit/States.dart';

import '../../../modules/settings/Settings.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(
    NewsInitialState()
    );
  var random  = Random();
  int currentApiKey = 0;
  List<String> apisKey = [
    "b93e47d6d2ef45e085ceaac4332e5bee",
    "423d36eb91c4402bb27997fd9932cafe",
    "827f3af5fc30490bba7bfac9ae5a98ef",
    "65f7f556ec76449fa7dc7c0069f040ca",
    "4d0cecb535124314a275b41d59f00a1f",
    "edb8e234ac5d4e1ab4931d6273e915d7",
    "06dfcf9802c1449f9027280eabf7378c",
    "aed7f9e363ea4962a0cddd9630286651",
    "aed7f9e363ea4962a0cddd9630286651",
    "a0357a52677547bfa36ff45610366d00",
  ];
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomNavIcons = [
    BottomNavigationBarItem(
      // backgroundColor: Colors.black,
        icon: Icon(
            Icons.business
        ),
        label: "Business",

    ),
    BottomNavigationBarItem(
      // backgroundColor: Colors.black,
        icon: Icon(
            Icons.sports
        ),
        label: "Sports"
    ),
    BottomNavigationBarItem(
      // backgroundColor: Colors.black,
        icon: Icon(
            Icons.science
        ),
        label: "Science"
    ),
    BottomNavigationBarItem(
      // backgroundColor: Colors.black,
      icon: Icon(
          Icons.settings
      ),
      label: "Settings",

    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  List<dynamic> business = [];

  void getBusiness()
  {
    
    if(business.length > 0)
      return;
    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      { 
        // a0357a52677547bfa36ff45610366d00
        // 423d36eb91c4402bb27997fd9932cafe
        'country':'${selectedValue}',
        'category':'business',
        'apiKey':'${apisKey[currentApiKey]}',
      },
    ).then((value)
    {
      business = value.data['articles'];
      // print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState());
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    if(sports.length > 0)
      return;
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country': '${selectedValue}',
          'category': 'sports',
          'apiKey': '${apisKey[currentApiKey]}',
        }
    ).then((value) {
      sports = value.data['articles'];
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportsErrorState());
    });

  }

  List<dynamic> science = [];

  void getScience() {
    if(science.length > 0)
      return;

    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country': '${selectedValue}',
          'category': 'science',
          'apiKey': '${apisKey[currentApiKey]}',
        }
    ).then((value) {
      science = value.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScienceErrorState());
    });
  }
  List<dynamic> search = [];

  void getSearch({
  required String value,
  }) {
    DioHelper.getData(
        url: 'v2/everything',
        query:
        {
          'q': '$value',
          'apiKey': '${apisKey[currentApiKey]}',
        }
    ).then((value) {
      search = value.data['articles'];
      print(search);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState());
    });
  }


  bool isDark = false;

  void changeMode({bool? fromShared}) {
    if(fromShared != null) {
      isDark = fromShared;
    }
    else
      isDark = !isDark;
    print(isDark);
    emit(ChangeModeState());
  }
  String selectedValue = "eg";
  void ChangeCountry({
    required String country
  }) {
    
    selectedValue = country;
    emit(ChangeCountryState());
  }

  void refreshApp() {
    currentApiKey = random.nextInt(9);
    business = [];
    sports = [];
    science = [];
    getBusiness();
    getScience();
    getSports();
    emit(RefreshState());
  }
}

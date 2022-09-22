import 'package:news/shared/compenents/Components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/news_app/cubit/Cubit.dart';
import '../../layout/news_app/cubit/States.dart';

class SettingsScreen extends StatelessWidget {
  // const SettingsScreen({Key? key}) : super(key: key);
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Egypt"),value: "eg"),
    DropdownMenuItem(child: Text("Saudi Arabia"),value: "sa"),
    DropdownMenuItem(child: Text("United Arab Emirates"),value: "ae"),
    DropdownMenuItem(child: Text("United States"),value: "us"),
    DropdownMenuItem(child: Text("Franca"),value: "fr"),
    DropdownMenuItem(child: Text("Australie"),value: "at"),
    DropdownMenuItem(child: Text("Brazil"),value: "br"),
    DropdownMenuItem(child: Text("Canada"),value: "ca"),
    DropdownMenuItem(child: Text("China"),value: "cn"),
    DropdownMenuItem(child: Text("Greece"),value: "gr"),
    DropdownMenuItem(child: Text("India"),value: "in"),
    DropdownMenuItem(child: Text("Japan"),value: "jp"),
    DropdownMenuItem(child: Text("Morco"),value: "ma"),
    DropdownMenuItem(child: Text("Russia"),value: "ru"),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              InkWell(
                onTap: () {
                  NewsCubit.get(context).changeMode(); 
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded( 
                          child: Text(
                            "Change Mode",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: NewsCubit.get(context).isDark ? Colors.white: Colors.black,
                            ),
                          ),
                        ),
                        Icon(
                          NewsCubit.get(context).isDark ? Icons.dark_mode : Icons.light_mode,
                          size: 30,
                          color: NewsCubit.get(context).isDark ? Colors.white: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Change Country",
                        style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: NewsCubit.get(context).isDark ? Colors.white: Colors.black,
                          ),
                      ),
                    ),
                    DropdownButton(
                      // dropdownColor: NewsCubit.get(context).isDark ? Colors.white: Colors.black,
                      
                      value: cubit.selectedValue,
                      items: menuItems, 
                      onChanged: (value) {
                        cubit.ChangeCountry(
                          country: value!);
                      }),
                  ],
                ),
              ),
            ],
          ),
        );
      },

    );
  }
}

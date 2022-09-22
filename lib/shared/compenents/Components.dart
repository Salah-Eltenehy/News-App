import 'package:news/modules/web_view/WebView.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget defaultButton(
      {
      required Function onPressedFunction,
      required String title,
      Color buttonColor = Colors.blue,
      double buttonWidth = double.infinity,
      double buttonHeight = 40.0,
      double radius = 0.0,
      bool isUpper = true,
      }) => 
      Container(
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadiusDirectional.circular(radius)
        ),
        width: buttonWidth,
        height: buttonHeight,
        child: MaterialButton(
          onPressed: () {
            onPressedFunction();
          },
          child: Text(
            isUpper ? title.toUpperCase() : title,
            style: TextStyle(
              color: Colors.white
            ),
            ),
        ),
      );

Widget defaultIconButton(
    {
      required Function onPressedFunction,
      required Icon iconButton,

    }
    ) => IconButton(
    onPressed: () {
      onPressedFunction();
    },
    icon: iconButton);

Widget defaultTextFormField({
          required TextEditingController controller,
          required String labelText ,
          required Function validatorFunction,
          required TextInputType textInputType,
          required Function onTapFunction,
          Function? onChangedFunc,
          Icon? prefixIcon ,
          IconData? suffixIcon,
          bool isSecure = false,
          }) => 
            Container( // email address
              height: 50.0,
              child: TextFormField(
                validator: (value) {
                  return validatorFunction(value);
                },
                onChanged: (value) {
                  return onChangedFunc!();
                },
                onTap: () {
                  onTapFunction();
                },
                obscureText: isSecure,
                controller: controller,
                keyboardType: textInputType,
                decoration: InputDecoration(
                  labelText: labelText,
                  border: OutlineInputBorder(),
                  prefix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: prefixIcon,
                  ),
                  suffixIcon: Icon(suffixIcon)
                ),
              ),
            );

// Widget defaultTaskShow({
//     required Map model,
//     required BuildContext context
//   }) {
//   AppCubit appCubit = AppCubit.getCubitObject(context);
//     return Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 5),
//                     child: Text(
//                       "${model["time"]}",
//                       style: TextStyle(fontSize: 10),
                    
//                     ),
//                   ),
//                   radius: 28,
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "${model["title"]}",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           "${model["date"]}",
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.grey
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                     onPressed: () {
//                       appCubit.updateDatabase(status: "done", id: model["id"]);
//                     },
//                     icon: Icon(Icons.check_box),
//                     color: Colors.green,
//                 ),
//                 SizedBox(
//                   width: 5,
//                 ),
//                 IconButton(
//                     onPressed: () {
//                       appCubit.updateDatabase(status: "archived", id: model["id"]);
//                     },
//                     icon: Icon(Icons.archive),
//                     color: Colors.black45,

//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
// }

Widget buildArticleItem({
  required article,
  required context

}) {
  return InkWell(

  onTap: () {
    print("${article['url']} lllllllllllllllllll");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>  WebViewScreen(article['url']))
    );
  },
    child: Row(
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0,),
            image: DecorationImage(
              image: NetworkImage("${article['urlToImage']}"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "${article['title']}",
                    style: Theme.of(context).textTheme.bodyText1,
                    // style: TextStyle(
                    //   fontSize: 15,
                    //   fontWeight: FontWeight.bold,
                    // ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "${article['publishedAt']}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildScreen({
  required List list,
  required BuildContext buildContext
}) {
  return ConditionalBuilder(
          condition: list.length > 0,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(15.0),
                child: buildArticleItem(
                    article: list[index],
                  context: buildContext
                ),
              ),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 20.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                  ),
                ),
              ),
              itemCount: list.length),
          fallback: (context) => Center(child: CircularProgressIndicator()));
}

/*
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:udemy_flutter/layout/news_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/news_app/news_layout.dart';
import 'package:udemy_flutter/layout/todo_app/todo_layout.dart';
import 'package:udemy_flutter/modules/bmi/bmi_screen.dart';
import 'package:udemy_flutter/modules/counter/counter_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/messenger/messenger_screen.dart';
import 'package:udemy_flutter/modules/users/users_screen.dart';
import 'package:udemy_flutter/shared/bloc_observer.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp(MyApp(isDark));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget {
  // constructor
  // build
  final bool isDark;

  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
                backgroundColor: Colors.white,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
                backgroundColor: HexColor('333739'),
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
                backgroundColor: HexColor('333739'),
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}
 */



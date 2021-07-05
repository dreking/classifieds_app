import 'package:classifieds_app/screens/product_details_screen.dart';
import 'package:classifieds_app/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:classifieds_app/providers/auth_logic.dart';
import 'package:classifieds_app/providers/product_logic.dart';
import 'package:classifieds_app/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthLogic()),
        ChangeNotifierProvider.value(value: ProductLogic()),
      ],
      child: MaterialApp(
        title: 'Classifieds App',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          primaryColor: Color.fromRGBO(81, 77, 84, 1),
          // scaffoldBackgroundColor: Color.fromRGBO(81, 77, 84, 1),
          appBarTheme: AppBarTheme(
            backgroundColor: Color.fromRGBO(81, 77, 84, 1),
            centerTitle: true,
            elevation: 0,
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            bodyText2: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
        routes: {
          MainScreen.routeName: (ctx) => MainScreen(),
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
          SignInScreen.routeName: (ctx) => SignInScreen(),
        },
      ),
    );
  }
}

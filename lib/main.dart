// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
//local
import './provider/user.dart';
import './screens/login_screen.dart';
import './screens/otp_screen.dart';
import './screens/home_screen.dart';

void main() => runApp(const CrowdLearn());

class CrowdLearn extends StatelessWidget {
  const CrowdLearn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=> User()),

    ],
    child: Consumer<User>(builder: (context, value, child) {
      return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
          textButtonTheme: TextButtonThemeData(style: ButtonStyle()),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
            contentPadding: EdgeInsets.symmetric(horizontal: 24),
          )),
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName : (context) => HomeScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        OtpScreen.routeName: (context) => OtpScreen(),
      },
    );

      
    },),
    
    );

   
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import './screens/login_screen.dart';

void main() => runApp(const CrowdLearn());

class CrowdLearn extends StatelessWidget {
  const CrowdLearn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            
          )


        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          contentPadding: EdgeInsets.symmetric(horizontal: 24),
  
  
        )
        
      ),

      initialRoute: LoginScreen.routeName,
       routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
      },

    
    );
  }
}

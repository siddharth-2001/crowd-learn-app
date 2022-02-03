import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
//local
import './provider/user.dart';
import './screens/login_screen.dart';
import './screens/otp_screen.dart';
import './screens/home_screen.dart';
import './screens/new_session.dart';
import './provider/sessions.dart';

void main() => runApp(const CrowdLearn());

class CrowdLearn extends StatelessWidget {
  const CrowdLearn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => User()),
        ChangeNotifierProvider(create: (context) => Sessions()),
      ],
      child: Consumer<User>(
        builder: (context, value, child) {

          return MaterialApp(
            theme: ThemeData(
                // primaryColor: Colors.greenAccent.shade100,
                colorScheme:const ColorScheme.light(
                  primary:  Color.fromRGBO(127,81,253,1),
                  background:Colors.white,
                  secondary: Color.fromRGBO(205,186,253,1),


                ),
                textTheme: const TextTheme(
                  // headline5: GoogleFonts.robotoCondensed(
                  // ),
                ),
                textButtonTheme:
                    const TextButtonThemeData(style: ButtonStyle()),
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                )),
            initialRoute:
               HomeScreen.routeName,
            routes: {
              HomeScreen.routeName: (context) => const HomeScreen(),
              LoginScreen.routeName: (context) => const LoginScreen(),
              OtpScreen.routeName: (context) => const OtpScreen(),
              NewSessionScreen.routeName: (context) => const NewSessionScreen(),
            },
          );
        },
      ),
    );
  }
}

import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => User()),
      ],
      child: Consumer<User>(
        builder: (context, value, child) {

          return MaterialApp(
            theme: ThemeData(
                // primaryColor: Colors.greenAccent.shade100,
                colorScheme: ColorScheme.light(
                  primary: Colors.deepPurple.shade400,
                  background: Colors.deepPurple.shade50,
                  secondary: Colors.blue,


                ),
                textTheme: TextTheme(
                  headline5: GoogleFonts.robotoCondensed(

                  ),
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
            },
          );
        },
      ),
    );
  }
}

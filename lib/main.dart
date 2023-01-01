import 'package:flutter/material.dart';
import 'package:rev/screen/auth/register_screen.dart';
import 'package:rev/screen/home_screen.dart';
import 'package:rev/screen/lunch_screen.dart';

import 'screen/auth/login_screen.dart';
import 'screen/user/user_home_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context) => const LunchScreen(),
        'homeScreen':(context) => const HomeScreen(),
        'homeUserApi':(context) => const HomeUserApi(),
        'loginScreen':(context) => const LoginScreen(),
        'registerScreen':(context) => const RegisterScreen(),
      },
    );
  }
}

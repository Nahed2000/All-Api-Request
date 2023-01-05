import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rev/get/image_get_controller.dart';
import 'package:rev/pref/pref_controller.dart';
import 'package:rev/screen/auth/forget_password.dart';
import 'package:rev/screen/auth/register_screen.dart';
import 'package:rev/screen/home_screen.dart';
import 'package:rev/screen/images/images_screen.dart';
import 'package:rev/screen/images/upolad_images.dart';
import 'package:rev/screen/lunch_screen.dart';

import 'screen/auth/login_screen.dart';
import 'screen/user/user_home_api.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefController().initPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        routes: {
          '/':(context) => const LunchScreen(),
          'homeScreen':(context) => const HomeScreen(),
          'homeUserApi':(context) => const HomeUserApi(),
          'loginScreen':(context) => const LoginScreen(),
          'registerScreen':(context) => const RegisterScreen(),
          'forgetScreen':(context) => const ForgetPassword(),
          'imagesScreen':(context) => const ImagesScreen(),
          'uploadImagesScreen':(context) => const UploadImagesScreen()
        },
    );
  }
}

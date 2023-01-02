import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rev/api/controller/auth_api_controller.dart';
import 'package:rev/model/api_response.dart';
import 'package:rev/util/helper.dart';

import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helper {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    // TODO: implement initState
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Login Screen',
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              letterSpacing: 2,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.s,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome Back ...!!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'please enter your email and password to login ',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                letterSpacing: 1,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 40),
            CustomTextField(
              controller: _emailController,
              title: 'Email',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _passwordController,
              title: 'Password',
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                // onTap: () => Navigator.pushNamed(con
                // text, '/forget_password'),
                child: Text(
                  'Forget Password',
                  style: TextStyle(
                      color: Colors.blueGrey.shade900,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
                onPress: () async => await performLogin(), title: 'Login'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have account?"),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, 'registerScreen'),
                  child: Text(
                    'Register Now!',
                    style: TextStyle(
                        color: Colors.blueGrey.shade900,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
      context: context,
      message: 'Please Enter your Email and Password ',
      error: true,
    );
    return false;
  }

  Future<void> login() async {
    ApiResponse apiResponse = await AuthAPIController().login(
        email: _emailController.text, password: _passwordController.text);
    showSnackBar(
        context: context,
        message: apiResponse.message,
        error: !apiResponse.status);
    if (apiResponse.status) {
      Navigator.pushReplacementNamed(context, 'homeScreen');
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rev/api/controller/auth_api_controller.dart';
import 'package:rev/model/api_response.dart';
import 'package:rev/util/helper.dart';

import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> with Helper {
  late TextEditingController _emailController;

  @override
  void initState() {
    // TODO: implement initState
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
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
          'Forget Password',
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
              'please enter your email to Reset ',
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
            CustomButton(
                onPress: () async => await performForget(), title: 'Send'),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future<void> performForget() async {
    if (checkData()) {
      await forget();
    }
  }

  bool checkData() {
    if (_emailController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
      context: context,
      message: 'Please Enter your Email to Rest',
      error: true,
    );
    return false;
  }

  Future<void> forget() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => RestPassword()));
  }
}

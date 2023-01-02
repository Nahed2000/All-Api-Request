import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rev/api/controller/auth_api_controller.dart';
import 'package:rev/model/api_response.dart';
import 'package:rev/util/helper.dart';

import '../../widget/custom_button.dart';
import '../../widget/custom_code_text.dart';
import '../../widget/custom_text_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> with Helper {
  late TextEditingController _passwordConfirmationController;
  late TextEditingController _passwordController;

  late TextEditingController _firstCodeTextController;
  late TextEditingController _secondCodeTextController;
  late TextEditingController _thirdCodeTextController;
  late TextEditingController _forthCodeTextController;

  late FocusNode _firstFocusNode;
  late FocusNode _secondFocusNode;
  late FocusNode _thirdFocusNode;
  late FocusNode _forthFocusNode;
  String code = '';

  @override
  void initState() {
    // TODO: implement initState
    _passwordConfirmationController = TextEditingController();
    _passwordController = TextEditingController();

    _firstCodeTextController = TextEditingController();
    _secondCodeTextController = TextEditingController();
    _thirdCodeTextController = TextEditingController();
    _forthCodeTextController = TextEditingController();

    _firstFocusNode = FocusNode();
    _secondFocusNode = FocusNode();
    _thirdFocusNode = FocusNode();
    _forthFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordConfirmationController.dispose();
    _passwordController.dispose();

    _firstCodeTextController.dispose();
    _secondCodeTextController.dispose();
    _thirdCodeTextController.dispose();
    _forthCodeTextController.dispose();

    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _thirdFocusNode.dispose();
    _forthFocusNode.dispose();

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
          'Reset password',
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
              'Please write your information to reset your password .. ',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                letterSpacing: 1,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                CustomCodeText(
                  controller: _firstCodeTextController,
                  focusNode: _firstFocusNode,
                  onPress: (value) {
                    if (value.isNotEmpty) {
                      _secondFocusNode.requestFocus();
                    }
                  },
                ),
                const SizedBox(width: 5),
                CustomCodeText(
                  controller: _secondCodeTextController,
                  focusNode: _secondFocusNode,
                  onPress: (value) {
                    value.isNotEmpty
                        ? _thirdFocusNode.requestFocus()
                        : _firstFocusNode.requestFocus();
                  },
                ),
                const SizedBox(width: 5),
                CustomCodeText(
                  controller: _thirdCodeTextController,
                  focusNode: _thirdFocusNode,
                  onPress: (value) {
                    value.isNotEmpty
                        ? _forthFocusNode.requestFocus()
                        : _secondFocusNode.requestFocus();
                  },
                ),
                const SizedBox(width: 5),
                CustomCodeText(
                  controller: _forthCodeTextController,
                  focusNode: _forthFocusNode,
                  onPress: (value) {
                    if (value.isEmpty) {
                      _thirdFocusNode.requestFocus();
                    }
                  },
                ),
                const SizedBox(width: 5),
              ],
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _passwordController,
              title: 'Password',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _passwordConfirmationController,
              title: 'Password Confirmation',
            ),
            const SizedBox(height: 20),
            CustomButton(
                onPress: () async => await performReset(), title: 'Reset'),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future<void> performReset() async {
    if (checkData()) {
      await reset();
    }
  }

  bool checkData() {
    if (checkPassword() && checkCode()) {
      print('successfully');
      return true;
    }
    return false;
  }

  bool checkCode() {
    if (_firstCodeTextController.text.isNotEmpty &&
        _secondCodeTextController.text.isNotEmpty &&
        _thirdCodeTextController.text.isNotEmpty &&
        _forthCodeTextController.text.isNotEmpty) {
      code = _firstCodeTextController.text +
          _secondCodeTextController.text +
          _thirdCodeTextController.text +
          _forthCodeTextController.text;
      print('****************');
      print('code is $code');
      print('****************');
      return true;
    }
    showSnackBar(
        context: context, message: 'Please Enter your Code', error: true);
    return false;
  }

  bool checkPassword() {
    if ((_passwordConfirmationController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) &&
        (_passwordConfirmationController.text == _passwordController.text)) {
      return true;
    }
    String message = _passwordConfirmationController.text.isEmpty ||
        _passwordController.text.isEmpty
        ? 'Please Enter Your Password & Confirmation Password'
        : 'Password and confirmation Password not match ..';
    showSnackBar(context: context, message: message, error: true);
    return false;
  }

  Future<void> reset() async {
    ApiResponse apiResponse = await AuthAPIController().reset(
        password: _passwordController.text, code: code, email: widget.email);
    if (apiResponse.status) {
      Navigator.pop(context);
    }
    showSnackBar(context: context, message: apiResponse.message, error: !apiResponse.status);
  }
}

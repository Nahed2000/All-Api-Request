import 'package:flutter/material.dart';
import 'package:rev/api/controller/auth_api_controller.dart';
import 'package:rev/get/task_get_controller.dart';
import 'package:rev/model/api_response.dart';
import 'package:rev/util/helper.dart';

import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> with Helper {
  late TextEditingController titleController;

  @override
  void initState() {
    // TODO: implement initState
    titleController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Add Task ..!',
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              letterSpacing: 2,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.s,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: titleController,
                title: 'Add Title',
              ),
              const SizedBox(height: 20),
              CustomButton(
                  onPress: () async => await performForget(), title: 'Save'),
              const SizedBox(height: 10),
            ],
          ),
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
    if (titleController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
      context: context,
      message: 'Please Enter your Title',
      error: true,
    );
    return false;
  }

  Future<void> forget() async {
    ApiResponse apiResponse = await TaskGetxController.to
        .createTask(context, title: titleController.text);
    if (apiResponse.status) {
      Navigator.pop(context);
      TaskGetxController.to.readTask();
    }
    showSnackBar(
        context: context,
        message: apiResponse.message,
        error: !apiResponse.status);
  }
}

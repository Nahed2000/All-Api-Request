import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rev/get/task_get_controller.dart';

import '../../util/helper.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> with Helper {
  @override
  void initState() {
    // TODO: implement initState
    TaskGetxController.to.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        title: const Text(
          'Tasks Screen',
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, 'addTask'),
              icon: const Icon(Icons.task))
        ],
      ),
      body: SafeArea(
        child: GetX<TaskGetxController>(
          builder: (controller) {
            if (controller.loading.isTrue) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blueGrey,
                ),
              );
            }
            if (controller.taskList.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, index) => Card(
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(controller.taskList[index].title),
                    subtitle: Text(controller.taskList[index].createdAt),
                    trailing: Text(controller.taskList[index].id.toString()),
                  ),
                ),
                itemCount: controller.taskList.length,
              );
            } else {
              print(controller.taskList.length);
              return const Center(child: Text("Don't have any Image"));
            }
          },
        ),
      ),
    );
  }
}

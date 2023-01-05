import 'package:get/get.dart';
import 'package:rev/api/controller/task_api_controller.dart';
import 'package:rev/model/api_response.dart';
import 'package:rev/util/helper.dart';

import '../model/task.dart';

class TaskGetxController extends GetxController with Helper {
  @override
  void onInit() {
    loading.value =true;
    // TODO: implement onInit
    readTask();
    loading.value= false;
    super.onInit();
  }

  static TaskGetxController get to => Get.find();
  RxList<Task> taskList = <Task>[].obs;
  RxBool loading = false.obs;

  TaskApiController taskApiController = TaskApiController();

  void readTask() async {
    print('taskList is : $taskList');
    ApiResponse<Task> apiResponse  = await taskApiController.indexTask();
    if(apiResponse.status) taskList.value = apiResponse.data ??[];
    print('task is : ${apiResponse.data}');

  }

  Future<ApiResponse> createTask(context, {required String title}) async {
    ApiResponse apiResponse = await taskApiController.createTask(title: title);
    print('we are here 1 ');
    return apiResponse;
  }
}

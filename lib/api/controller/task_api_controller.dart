import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rev/api/api_helper.dart';
import 'package:rev/api/api_setting.dart';
import 'package:rev/model/api_response.dart';
import 'package:rev/model/task.dart';

class TaskApiController with ApiHelper {
  Future<ApiResponse<Task>> createTask({required String title}) async {
    print('we are here 2 ');
    Uri url = Uri.parse(ApiSettings.task.replaceFirst('/{id}', ''));
    print('we are here 3 ');
    var response =
        await http.post(url, headers: headers, body: {"title": title});
    print('we are here  4');
    if (response.statusCode == 201 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if(response.statusCode ==201){
        print('we are here  5');
        // var jsonArray = jsonResponse['data'] as List;
        // List<Task> task = jsonArray.map((e) => Task.fromJson(e)).toList();
        print('we are here  6');
        return ApiResponse<Task>(
          status: jsonResponse['status'],
          message: jsonResponse['message'],
        );
      }
      return ApiResponse(message: jsonResponse['message'], status: jsonResponse['status']);
      // data: task);
    } else if (response.statusCode == 401) {
      print('we are here  7');
      print(response.statusCode);
      return ApiResponse(
          message: 'Please Login to create your Task', status: false);
    }
    print('we are here  8');
    return getGenericErrorServer();
  }

  Future<ApiResponse<Task>> indexTask() async {
    Uri url = Uri.parse(ApiSettings.task.replaceFirst('/{id}', ''));
    var response = await http.get(url, headers: headers);
    print('response.statusCode is ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 401) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      List<Task> task = jsonArray.map((e) => Task.fromJson(e)).toList();
      return ApiResponse.list(
          status: jsonResponse['status'],
          message: jsonResponse['message'],
          data: task);
    }
    return getGenericErrorServer();
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rev/api/api_setting.dart';
import 'package:rev/pref/pref_controller.dart';

import '../../model/api_response.dart';
import '../../model/student.dart';
import '../api_helper.dart';

class AuthAPIController with ApiHelper {
  Future<ApiResponse> login(
      {required String email, required String password}) async {
    Uri url = Uri.parse(ApiSettings.login);
    var response =
        await http.post(url, body: {"email": email, "password": password});
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var arrayResponse = jsonResponse['object'];
        Student student = Student.fromJson(arrayResponse);
        SharedPrefController().save(student);
        return ApiResponse(
            message: jsonResponse['message'], status: jsonResponse['status']);
      }
      return ApiResponse(
          message: jsonResponse['message'], status: jsonResponse['status']);
    }
    return ApiResponse(message: 'Something we went wrong..!!', status: false);
  }

  Future<ApiResponse> logout() async {
    Uri url = Uri.parse(ApiSettings.logout);
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 401) {
      var jsonResponse = jsonDecode(response.body);
      String message = response.statusCode == 200
          ? jsonResponse['message']
          : 'Logged out successfully';
      return ApiResponse(message: message, status: true);
    }
    return ApiResponse(message: 'Something went wrong ', status: false);
  }

  Future<ApiResponse> register(Student student) async {
    Uri url = Uri.parse(ApiSettings.register);
    var response = await http.post(url, body: {
      "full_name": student.fullName,
      "password": student.password,
      "email": student.email,
      "gender": student.gender,
    });
    if (response.statusCode == 201 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
          message: jsonResponse['message'], status: jsonResponse['status']);
    }
    return ApiResponse(message: 'Something went wrong', status: false);
  }

  Future<ApiResponse> forgetPassword(String email) async {
    Uri url = Uri.parse(ApiSettings.forget);
    var response = await http.post(url, body: {"email": email});
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      print('*****************');
      print('code is ${jsonResponse['code']}');
      print('*****************');
      return ApiResponse(
          message: jsonResponse['message'], status: jsonResponse['status']);
    }
    return ApiResponse(message: 'Something went wrong', status: false);
  }

  Future<ApiResponse> reset({
    required String password,
    required String code,
    required String email,
  }) async {
    Uri url = Uri.parse(ApiSettings.resetPassword);
    var response = await http.post(url, body: {
      "email": email,
      "password": password,
      "code": code,
      "password_confirmation": password
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
          message: jsonResponse['message'], status: jsonResponse['status']);
    }
    return ApiResponse(message: 'Something went wrong', status: false);
  }
}

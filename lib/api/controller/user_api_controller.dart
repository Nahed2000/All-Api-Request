import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rev/api/api_setting.dart';
import 'package:rev/model/base_user_data.dart';
import 'package:rev/model/user_data.dart';

class UserApiController {
  Future<List<UserData>> readUser() async {
    Uri url = Uri.parse(ApiSettings.readUser);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var apiResponse = jsonDecode(response.body);
      BaseUserData baseUserData = BaseUserData.fromJson(apiResponse);
      return baseUserData.data;
    }
    return [];
  }

  Future<List<UserData>> searchUser(
      {required String firstName, required String jobTitle}) async {
    Uri url = Uri.parse(ApiSettings.searchUser);
    var response = await http
        .post(url, body: {"first_name": firstName, "job_title": jobTitle});
    if (response.statusCode == 200) {
      var apiResponse = jsonDecode(response.body);
      print(apiResponse['status']);
      print(apiResponse['message']);
      var arrayJsonObject = apiResponse['data'] as List;
      List<UserData> user =
          arrayJsonObject.map((e) => UserData.fromJson(e)).toList();
      return user;
    }
    return [];
  }
}

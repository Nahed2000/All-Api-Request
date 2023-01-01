import 'package:rev/model/user_data.dart';

class BaseUserData {
  late bool status;
  late String message;
  late List<UserData> data;

  BaseUserData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserData>[];
      json['data'].forEach((v) {
        data.add(UserData.fromJson(v));
      });
    }
  }
}

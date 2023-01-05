import 'dart:io';

import 'package:rev/model/api_response.dart';

import '../pref/pref_controller.dart';

mixin ApiHelper {
  Map<String, String> get headers {
    Map<String, String> headers = <String, String>{};
    headers[HttpHeaders.acceptHeader] = 'application/json';
    if (SharedPrefController().loggedIn) {
      headers[HttpHeaders.authorizationHeader] = SharedPrefController().token;
    }
    return headers;
  }

  ApiResponse<T> getGenericErrorServer<T>() {
    return ApiResponse<T>(message: 'Something went wrong', status: false);
  }

  ApiResponse get errorServer =>
      ApiResponse(message: 'Something went wrong', status: false);
}

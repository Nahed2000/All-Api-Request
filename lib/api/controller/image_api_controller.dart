import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rev/api/api_helper.dart';
import 'package:rev/api/api_setting.dart';
import 'package:rev/model/api_response.dart';
import 'package:rev/pref/pref_controller.dart';

import '../../model/student_image.dart';

class ImageApiController with ApiHelper {

  Future<http.StreamedResponse> uploadImage({required File file}) async {
    print('we are 2');
    Uri url = Uri.parse(ApiSettings.imageStudent.replaceFirst('/{id}', ''));
    var request = http.MultipartRequest('POST', url);
    //TODO: Upload file or Image
    var image = await http.MultipartFile.fromPath('image', file.path);
    print('we are 3');
    request.files.add(image);
    //TODO: Upload Text or Fields
    // request.fields[''] = '';
    //TODO: add headers to form data:
    print('we are 4');
    request.headers[HttpHeaders.authorizationHeader] =
        SharedPrefController().token;
    request.headers[HttpHeaders.acceptHeader] = 'application/json';
    print('we are 5');
    return  await request.send();
  }

  Future<ApiResponse<StudentImage>> indexImage() async {
    Uri url = Uri.parse(ApiSettings.imageStudent.replaceFirst('/{id}', ''));
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 401) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var jsonArray = jsonResponse['data'] as List;
        List<StudentImage> images =
            jsonArray.map((e) => StudentImage.fromJson(e)).toList();
        return ApiResponse<StudentImage>.list(
            status: jsonResponse['status'],
            message: jsonResponse['message'],
            data: images);
      }
      return ApiResponse(
          message: 'Unauthorized ,Please login again!', status: true);
    }
    return getGenericErrorServer<StudentImage>();
  }

  Future<ApiResponse> deleteImage({required int id}) async {
    var url = Uri.parse(ApiSettings.imageStudent.replaceFirst('{id}', id.toString()));
    var response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
          message: jsonResponse['message'], status: jsonResponse['status']);
    } else if (response.statusCode == 401 || response.statusCode == 404) {
      String message = response.statusCode == 404
          ? 'Selected image is not found'
          : 'Unauthorized access, login again';
      return ApiResponse(message: message, status: false);
    }
    return errorServer;
  }
}

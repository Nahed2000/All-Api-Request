import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rev/api/api_setting.dart';
import 'package:rev/model/image_user.dart';

class ImageUserApiController {
  Future<List<ImageUsers>> imageUsers() async {
    Uri url = Uri.parse(ApiSettings.imageUser);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var arrayJsonResponse = jsonResponse['data'] as List;
      List<ImageUsers> imageList =
          arrayJsonResponse.map((e) => ImageUsers.fromJson(e)).toList();
      return imageList;
    }
    return [];
  }
}

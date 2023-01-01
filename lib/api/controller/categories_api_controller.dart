import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rev/api/api_setting.dart';
import 'package:rev/model/categories.dart';

class CategoriesApiController {
  Future<List<Categories>> indexCategories() async {
    Uri url = Uri.parse(ApiSettings.categories);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List arrayJsonObject = jsonResponse['data'];
      List<Categories> categories =
          arrayJsonObject.map((e) => Categories.fromJson(e)).toList();
      return categories;
    }
    return [];
  }
}

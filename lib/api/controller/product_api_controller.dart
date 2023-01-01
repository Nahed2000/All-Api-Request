import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rev/model/product.dart';

import '../api_setting.dart';

class ProductApiController {

  Future<List<Product>> getProduct() async {
    Uri url = Uri.parse(ApiSettings.product);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var jsonArrayResponse = jsonResponse['data'] as List;
      List<Product> product =
          jsonArrayResponse.map((e) => Product.fromJson(e)).toList();
      return product;
    }
    print(response.body);
    return [];
  }
}

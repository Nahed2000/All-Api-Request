import 'package:flutter/material.dart';
import 'package:rev/api/controller/categories_api_controller.dart';
import 'package:rev/api/controller/product_api_controller.dart';
import 'package:rev/model/product.dart';
import 'package:rev/screen/image_users/image_users.dart';
import 'package:rev/widget/custom_button.dart';

import '../model/categories.dart';
import 'categories/categories_api.dart';
import 'product/product_categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Categories>> futureCategories;
  late Future<List<Product>> futureProductCategories;

  @override
  void initState() {
    futureCategories = CategoriesApiController().indexCategories();
    futureProductCategories = ProductApiController().getProduct();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade900,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade900,
        title: const Text(
          'Home Screen',
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spa
            // ,
            children: [
              CustomButton(
                  title: 'User API',
                  onPress: () {
                    Navigator.pushNamed(context, 'homeUserApi');
                  }),
              const SizedBox(height: 20),
              CustomButton(
                  title: 'Index Categories',
                  onPress: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            IndexCategories(future: futureCategories),
                      ))),
              const SizedBox(height: 20),
              CustomButton(
                title: 'Index Categories Product',
                onPress: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductCategories(future: futureProductCategories),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                  title: 'Image User Screen',
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageUsersScreen(),
                      ),
                    );
                  }),
              const SizedBox(height: 20),
              CustomButton(title: 'User API', onPress: () {}),
              const SizedBox(height: 20),
              CustomButton(title: 'User API', onPress: () {}),
              const SizedBox(height: 20),
              CustomButton(title: 'User API', onPress: () {})
            ],
          ),
        ),
      ),
    );
  }
}

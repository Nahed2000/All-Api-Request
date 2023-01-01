import 'package:flutter/material.dart';
import 'package:rev/model/product.dart';


class ProductCategories extends StatelessWidget {
  const ProductCategories({Key? key, required this.future}) : super(key: key);
  final Future<List<Product>> future;
  // List<Product> _product = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.teal.shade900),
        title: Text(
          'Index Product Categories',
          style: TextStyle(color: Colors.teal.shade900),
        ),
      ),
      body: FutureBuilder<List<Product>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              // _product = ;
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(snapshot.data![index].name),
                  subtitle: Text(snapshot.data![index].description),
                  leading: Image.network(snapshot.data![index].image),
                  trailing:
                  Text(snapshot.data![index].visible == '0' ? 'Visible' : 'Not Visible'),
                ),
              );
            } else {
              print(snapshot);
              return const Center(child: Text("Don't have any data ..!!"));
            }
          }),
    );
  }
}

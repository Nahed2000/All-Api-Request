import 'package:flutter/material.dart';
import 'package:rev/model/categories.dart';

// ignore: must_be_immutable
class IndexCategories extends StatelessWidget {
  IndexCategories({Key? key, required this.future}) : super(key: key);
  final Future<List<Categories>> future;
  List<Categories> _categories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.teal.shade900),
        title: Text(
          'Index Categories',
          style: TextStyle(color: Colors.teal.shade900),
        ),
      ),
      body: FutureBuilder<List<Categories>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              _categories = snapshot.data!;
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20),
                itemCount: _categories.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(_categories[index].title),
                  subtitle: Text(_categories[index].description),
                  leading: Image.network(_categories[index].image),
                  trailing:
                  Text(_categories[index].visible == '0' ? 'Visible' : 'Not Visible'),
                ),
              );
            } else {
              return const Center(child: Text("Don't have any data ..!!"));
            }
          }),
    );
  }
}

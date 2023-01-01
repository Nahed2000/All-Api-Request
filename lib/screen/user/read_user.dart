import 'package:flutter/material.dart';

import '../../model/user_data.dart';

class ReadUsers extends StatelessWidget {
  ReadUsers({Key? key, required this.future}) : super(key: key);
  final Future<List<UserData>> future;
  List<UserData> _user = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.teal.shade900),
        title: Text(
          'Read Users',
          style: TextStyle(color: Colors.teal.shade900),
        ),
      ),
      body: FutureBuilder<List<UserData>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              _user = snapshot.data!;
              return ListView.builder(
                itemCount: _user.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(_user[index].firstName),
                  subtitle: Text(_user[index].email),
                  leading: Image.network(_user[index].image),
                  trailing:
                      Text(_user[index].active == '0' ? 'Active' : 'Offline'),
                ),
              );
            } else {
              return const Center(child: Text("Don't have any data ..!!"));
            }
          }),
    );
  }
}

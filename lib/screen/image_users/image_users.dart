import 'package:flutter/material.dart';
import 'package:rev/api/controller/image_user_api_controller.dart';

import '../../model/image_user.dart';

class ImageUsersScreen extends StatefulWidget {
  const ImageUsersScreen({Key? key}) : super(key: key);

  @override
  State<ImageUsersScreen> createState() => _ImageUsersScreenState();
}

class _ImageUsersScreenState extends State<ImageUsersScreen> {
  late Future<List<ImageUsers>> imageFuture;
  List<ImageUsers> _user = [];

  @override
  void initState() {
    imageFuture = ImageUserApiController().imageUsers();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.teal.shade900),
        title: Text(
          'Image User',
          style: TextStyle(color: Colors.teal.shade900),
        ),
      ),
      body: FutureBuilder<List<ImageUsers>>(
          future: imageFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              _user = snapshot.data!;
              return ListView.builder(
                itemCount: _user.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('ID: ${_user[index].id.toString()}'),
                    subtitle: Text(_user[index].info),
                    leading: Image.network(_user[index].image),
                    trailing: Text(
                        _user[index].visible == '0' ? 'Visible' : 'Invisible'),
                  ),
                ),
              );
            } else {
              return const Center(child: Text("Don't have any data ..!!"));
            }
          }),
    );
  }
}

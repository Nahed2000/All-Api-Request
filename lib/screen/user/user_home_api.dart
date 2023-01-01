import 'package:flutter/material.dart';
import 'package:rev/api/controller/user_api_controller.dart';
import 'package:rev/widget/custom_button.dart';

import '../../model/user_data.dart';
import 'read_user.dart';
import 'search_user.dart';

class HomeUserApi extends StatefulWidget {
  const HomeUserApi({Key? key}) : super(key: key);

  @override
  State<HomeUserApi> createState() => _HomeUserApiState();
}

class _HomeUserApiState extends State<HomeUserApi> {
  late Future<List<UserData>> future;

  @override
  void initState() {
    // TODO: implement initState
    future = UserApiController().readUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade900,
        title: const Text(
          'Home Api User',
          style: TextStyle(
              // color: Colors.black,
              fontSize: 22),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              title: 'Read User',
              onPress: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReadUsers(future: future),
                  )),
            ),
            SizedBox(height: 20),
            CustomButton(
              title: 'Search User',
              onPress: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchUser(),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

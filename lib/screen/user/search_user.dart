import 'package:flutter/material.dart';
import 'package:rev/api/controller/user_api_controller.dart';
import 'package:rev/widget/custom_button.dart';
import 'package:rev/widget/custom_text_field.dart';

import '../../model/user_data.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({Key? key}) : super(key: key);

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  List<UserData> user = [];
  bool isSearched = false;
  late TextEditingController nameController;

  late TextEditingController jobController;
  Future<List<UserData>>? _future;

  @override
  void initState() {
    nameController = TextEditingController();
    jobController = TextEditingController();
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
          'Search User',
          style: TextStyle(color: Colors.teal.shade900),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Column(
            children: [
              CustomTextField(controller: nameController, title: 'User Name'),
              const SizedBox(height: 20),
              CustomTextField(controller: jobController, title: 'Job Title'),
              const SizedBox(height: 20),
              CustomButton(
                title: 'Search',
                onPress: () async {
                  await performSearch();
                  setState(() {});
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                // width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Visibility(
                  // visible: user.isNotEmpty,
                  child: FutureBuilder<List<UserData>>(
                    builder: (context, snapshot) {
                      if (user.isNotEmpty) {
                        return ListView.builder(
                          itemCount: user.length,
                          itemBuilder: (context, index) => ListTile(
                            title: Text(user[index].firstName),
                            subtitle: Text(user[index].email),
                            leading: Image.network(user[index].image),
                            trailing: Text(user[index].active == '0'
                                ? 'Active'
                                : 'Offline'),
                          ),
                        );
                      } else if (user.isEmpty) {
                        // setState(() {
                        // });
                        return  Center(
                            child: Text("Don't have any data",style: TextStyle(color: Colors.black),));
                      }
                      else {
                        return Container();
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> performSearch() async {
    user.clear();
    if (checkData()) {
      await search();
      isSearched = !isSearched;
    }
  }

  bool checkData() {
    if (nameController.text.isNotEmpty && jobController.text.isNotEmpty) {
      return true;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Please Enter First Name and Job',
            style: TextStyle(fontSize: 18),
          ),
        ),
        backgroundColor: Colors.red,
      ),
    );
    return false;
  }

  Future<void> search() async {
    user = await UserApiController().searchUser(
        firstName: nameController.text, jobTitle: jobController.text);
    print(user.length);
  }
}

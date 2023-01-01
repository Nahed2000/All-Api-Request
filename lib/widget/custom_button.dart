import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key,
    required this.title,
    required this.onPress,
  }) : super(key: key);
  final void Function() onPress;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(
        title,
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey.shade100,
        shape: RoundedRectangleBorder(
          // side: BorderSide(width: 1,),
          borderRadius: BorderRadius.circular(15),
        ),
        minimumSize: Size(double.infinity, 75),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  final String deviceToken;
  Chat({required this.deviceToken});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "chat Screen",

            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 20),
          Text(
            "Device Token:",
            style: TextStyle(color: Colors.black),
          ),

          SizedBox(height: 10),
          Text(
            deviceToken,
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),

        ],
      ),
    );
  }
}
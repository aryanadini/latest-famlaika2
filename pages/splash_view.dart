
import 'dart:async';

import 'package:famlaika1/pages/login_request/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/colors.dart';
import '../constants/bottom.dart';
import 'homefamilytree/homesub/home2.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  // @override
  // Future<void> _checkLoginStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  //
  //   // Navigate to the appropriate page after checking the login status
  //   Navigator.of(context).pushReplacement(
  //     MaterialPageRoute(
  //       builder: (context) => isLoggedIn ? Home2() : Login(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    _checkLoginStatus(context);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body:Stack(
        children: [
          Positioned(
              width: 220,
              height: 65,
              top: 354,
              left: 70,
              child: Image(image:AssetImage("assets/images/imgspl.png")) ),
          Positioned(
              width: 215,
              height: 19,
              top: 427,
              left: 76,
              child: Text("A space for family memories ",style: TextStyle(fontFamily: 'Figtree',fontWeight:FontWeight.w400,
              fontSize: 16,color:Color(0xFFFFFFFF) ),))
        ],
      ) ,
    );
  }
  void _checkLoginStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => isLoggedIn ? Bottom() : Login(),
        ),
      );
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(title: Text('Gender Selection')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    // Handle female selection
                  },
                  child: Container(
                    width: 160.w,
                    padding: EdgeInsets.all(16.r),
                    margin: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.black54,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 30.sp,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Female',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontFamily: 'Figtree',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Handle male selection
                  },
                  child: Container(
                    width: 160.w,
                    padding: EdgeInsets.all(16.r),
                    margin: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.black54,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person_outline,
                            size: 30.sp,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Male',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontFamily: 'Figtree',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),


    );
  }
}
import 'package:famlaika1/constants/appbarConst.dart';
import 'package:famlaika1/pages/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/GradientButton.dart';

class BlockedPersonPage extends StatefulWidget {
  @override
  State<BlockedPersonPage> createState() => _BlockedPersonPageState();
}

class _BlockedPersonPageState extends State<BlockedPersonPage> {

  final List<Map<String, String>> blockedPersons = [
    {"name": "Alice", "image": 'assets/images/img_listsibling2.png'},
    {"name": "Bob", "image": 'assets/images/img_listsibling3.png'},
    {"name": "Charlie", "image": 'assets/images/img_listsibling4.png'},
    {"name": "Diana", "image": 'assets/images/img_spouse.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar:CustomAppBar(title: "Blocked Persons"),
      body: ListView.builder(
        itemCount: blockedPersons.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(blockedPersons[index]["image"]!), // Load image from the map
            ),
            title: Text(blockedPersons[index]["name"]!,
            style: TextStyle(color: Color(0xFFFFFFFFFF),fontFamily: "Figtree",fontSize: 16),
            ), // Display name from the map
            trailing: TextButton(
              onPressed: () {
                _showUnblockBottomSheet(context, blockedPersons[index]["name"]!,);
              },
              child: Text('Unblock',style: TextStyle(color: Color(0xFFF7B52C),fontFamily: "Figtree",fontSize: 16),),
            ),
          );
        },
      ),
    );
  }

  void _showUnblockBottomSheet(BuildContext context, String name) {
    showModalBottomSheet(
      backgroundColor: Colors.grey.shade900,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.h, // Set the desired width
                height: 40.w,
                child: Image(image: AssetImage("assets/images/img_block.png",),
                  fit: BoxFit.cover ,),
              ),
                // Image: AssetImage('assets/person.png'), // Replace with actual image path
                // radius: 40,

              SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  text: 'Unblock ',
                  style: TextStyle(color: Color(0xFFFFFFFFFF),
                      fontFamily: "Figtree",fontSize: 16),
                  children: [
                    TextSpan(
                      text: name,
                      style: TextStyle(color: Colors.yellow,fontFamily: "Figtree",fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Are you sure you want to ',style: TextStyle(color:
                  Color(0xFFFFFFFFFF),fontFamily: "Figtree",fontSize: 16)),
                  Text('unblock $name?', style: TextStyle(color: Colors.yellow,
                      fontFamily: "Figtree",fontSize: 16)),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 38.h,
                    width: 110.w,
                    alignment: Alignment.center,
                    child: GradientButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel',style: TextStyle(color:
                      Color(0xFFFFFFFFFF),fontFamily: "Figtree",fontSize: 14)),
                      isSolidColor: true,
                      solidColor: Color(0xFF4E4C4C),



                    ),
                  ),
                  Container(
                    height: 36.h,
                    width: 110.w,
                    alignment: Alignment.center,
                    child: GradientButton(
                      onPressed: () {
                        Navigator.pop(context); // Close BottomSheet
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SettingsPage()),
                        );
                      },
                      child: Text('Confirm'),








                    ),
                  )


                ],
              ),
            ],
          ),
        );
      },
    );
  }
}



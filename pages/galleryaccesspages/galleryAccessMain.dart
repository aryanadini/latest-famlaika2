import 'package:famlaika1/constants/appbarConst.dart';
import 'package:famlaika1/pages/galleryaccesspages/sentaccess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Tileofgalleryaccess.dart';
import 'gradientgalleryAccess.dart';
class RequestData {
  final String imagePath;
  final String name;

  RequestData({
    required this.imagePath,
    required this.name,
  });
}




class GalleryaccessMain extends StatefulWidget {
  @override
  _GalleryaccessMainState createState() => _GalleryaccessMainState();
}

class _GalleryaccessMainState extends State<GalleryaccessMain> {
  bool isReceivedSelected = true;

  final List<RequestData> requestDataList = [
    RequestData(imagePath: 'assets/images/img_listsibling3.png', name: 'John Doe'),
    RequestData(imagePath: 'assets/images/img_listsibling4.png', name: 'Jane Smith'),
    RequestData(imagePath: 'assets/images/img_listsibling2.png', name: 'Alice Johnson'),
    // Add more items as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: CustomAppBar(title: "Gallery Access"),
      body: Column(
        children: [
          SizedBox(height: 20),
          GradientGalleryAccess(
            isReceivedSelected: isReceivedSelected,
            onTabChange: (bool receivedSelected) {
              setState(() {
                isReceivedSelected = receivedSelected;
              });
            },
          ),

          Expanded(
            child: ListView(
              children: isReceivedSelected
                  ? [
                SizedBox(height: 8.0),



                RequestListTile(imagePath: "assets/images/img_father.png", name: 'John Doe'),


                RequestListTile(imagePath: 'assets/images/img_listsibling3.png', name: 'Jane Smith'),
                RequestListTile(imagePath: 'assets/images/img_mother.png', name: 'Alice Johnson'),

              //  RequestListTile(imagePath: 'assets/images/img_listsibling2.png', name: 'Emily Davis added you as a child'),
              ]
                  : [
                // Display "Sent" items here
                SizedBox(height: 8.0),


                sentListTile(imagePath: "assets/images/img_father.png", name: 'Diwal'),


                sentListTile(imagePath: 'assets/images/img_listsibling3.png', name: 'Jane '),
                sentListTile(imagePath: 'assets/images/img_mother.png', name: ' Johnson'),

              ],

              //   SizedBox(height: 16.0),
              //   Text(
              //     'New',
              //     style: TextStyle(
              //         fontSize: 18.0,
              //         fontWeight: FontWeight.w500,
              //         color: Colors.white,
              //         fontFamily: "Figtree"
              //     ),
              //   ),
              //   SizedBox(height: 16.0),
              //   REqLi(image: "assets/images/img_father.png",
              //     title: 'Charles James added you as spouse',),
              //
              //   Divider(thickness: 1,color:Color(0xFF383838) ,),
              //
              //   Text('Today', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500,fontFamily: "Figtree")),
              //   SizedBox(height: 16.0),
              //   REqLi(
              //     image: 'assets/images/img_listsibling3.png', // Replace with your image asset path
              //     title: 'John Doe added you as sibling',
              //   ),
              //   SizedBox(height: 10.h,),
              //
              //   REqLi(
              //     image: 'assets/images/img_mother.png', // Replace with your image asset path
              //     title: 'Victoria Tom added you as a daughter',
              //   ),
              //   Divider(thickness: 1,color:Color(0xFF383838) ,),
              //   Text('Yesterday', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500,fontFamily: "Figtree")),
              //   SizedBox(height: 16.0),
              //   REqLi(
              //     image: 'assets/images/img_listsibling2.png', // Replace with your image asset path
              //     title: 'Emily Davis added you as a child',
              //   ),
              //
              // )),



            ),
          ),


          // Expanded(
          //   child: ListView.builder(
          //     itemCount: requestDataList.length,// Number of items
          //     itemBuilder: (context, index) {
          //       final requestData = requestDataList[index];
          //       return RequestListTile(
          //         imagePath: requestData.imagePath,
          //         name: requestData.name,
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

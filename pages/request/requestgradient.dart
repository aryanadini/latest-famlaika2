import 'package:famlaika1/pages/request/requstlisttile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientRe extends StatefulWidget {
  late final bool isReceivedSelected;
  late final ValueChanged<bool> onTabChange;
  GradientRe({
    required this.isReceivedSelected,
    required this.onTabChange,
  });
  @override
  _GradientReState createState() => _GradientReState();
}

class _GradientReState extends State<GradientRe> {
  bool isReceivedSelected = true;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60.h,
          width: 320.w,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (!widget.isReceivedSelected) {
                      widget.onTabChange(true);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      gradient: widget.isReceivedSelected
                          ? LinearGradient(colors: [Colors.yellow, Colors.orange])
                          : null,
                      color: !widget.isReceivedSelected ? Color(0xFF262626) : null,
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
                    ),
                    child: Text(
                      'Received',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: widget.isReceivedSelected ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (widget.isReceivedSelected) {
                      widget.onTabChange(false);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      gradient: !widget.isReceivedSelected
                          ? LinearGradient(colors: [Colors.yellow, Colors.orange])
                          : null,
                      color: !widget.isReceivedSelected ? Color(0xFF262626) : null,
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(5)),
                    ),
                    child: Text(
                      'Sent',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:!widget.isReceivedSelected ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
       // if (isReceivedSelected)
        // SizedBox(height: 16.0),
        // Text(
        //   'New',
        //   style: TextStyle(
        //     fontSize: 18.0,
        //     fontWeight: FontWeight.w500,
        //     color: Colors.white,
        //     fontFamily: "Figtree"
        //   ),
        // ),
        // SizedBox(height: 16.0),
        // REqLi(image: "assets/images/img_father.png",
        //   title: 'Charles James added you as spouse',),
        //
        // Divider(thickness: 1,color:Color(0xFF383838) ,),
        //
        // Text('Today', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500,fontFamily: "Figtree")),
        // SizedBox(height: 16.0),
        // REqLi(
        //   image: 'assets/images/img_listsibling3.png', // Replace with your image asset path
        //   title: 'John Doe added you as sibling',
        // ),
        // SizedBox(height: 10.h,),
        //
        // REqLi(
        //   image: 'assets/images/img_mother.png', // Replace with your image asset path
        //   title: 'Victoria Tom added you as a daughter',
        // ),
        // Divider(thickness: 1,color:Color(0xFF383838) ,),
        // Text('Yesterday', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500,fontFamily: "Figtree")),
        // SizedBox(height: 16.0),
        // REqLi(
        //   image: 'assets/images/img_listsibling2.png', // Replace with your image asset path
        //   title: 'Emily Davis added you as a child',
        // ),

        // if (showSentSection)
        //   Padding(
        //     padding: EdgeInsets.only(top: 20.h),
        //     child: Container(
        //       width: 320.w,
        //       padding: EdgeInsets.all(15.w),
        //       decoration: BoxDecoration(
        //         color: Colors.grey[200],
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //       child: Column(
        //         children: [
        //           ListTile(
        //             leading: Icon(Icons.mail),
        //             title: Text('Sent Message 1'),
        //             subtitle: Text('This is the first sent message.'),
        //             trailing: Icon(Icons.more_vert),
        //           ),
        //           Divider(),
        //           ListTile(
        //             leading: Icon(Icons.mail),
        //             title: Text('Sent Message 2'),
        //             subtitle: Text('This is the second sent message.'),
        //             trailing: Icon(Icons.more_vert),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
      ],
    );
  }
}

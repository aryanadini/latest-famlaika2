import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../apiservice/api_services.dart';
import '../homefamilytree/homesub/home2.dart';

class REqLi extends StatefulWidget {
  final String image;
  final String title;
  final String requestId;
  final String relationId;

  const REqLi({required this.image,required this.requestId, required this.title, Key? key, required this.relationId}) : super(key: key);

  @override
  _REqLiState createState() => _REqLiState();
}

class _REqLiState extends State<REqLi> {
   Color acceptButtonColor = Color(0xFFF3802B);
   Color rejectButtonColor = Color(0xFF4E4C4C);
 Color selectedButtonColor = Color(0xFFF3802B);
  Color unselectedButtonColor = Color(0xFF4E4C4C);
   LinearGradient buttonGradient = LinearGradient(
     begin: Alignment(-1.0, 0.0),
     end: Alignment(1.0, 0.0),
     colors: [
       Color(0xFFF3802B),
       Color(0xFFFAE42C),
     ],
     stops: [-0.1577, 1.1939],
   );
  bool isAccepted = true;
  bool isRejected = false;
   bool areButtonsDisabled = false;
   Color buttonDisabledColor = Color(0xFF4E4C4C);

  int get relationId => relationId;




  void _onAcceptPressed(String requestId) async {
    setState(() {
      isAccepted = true;
      isRejected = false;
      areButtonsDisabled = true;
    });

    try {
      await ApiService.acceptRequest(widget.requestId, '2','');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Request accepted successfully'),
        ),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to accept request: $e'),
        ),
      );
    }
  }

  void _onRejectPressed(String requestId) async {
    setState(() {
      isAccepted = false;
      isRejected = true;
      areButtonsDisabled = true;
    });
    try {

      await ApiService.deleteRequest(relationId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Request rejected successfully'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to reject request: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: widget.image.isEmpty
                ? AssetImage('assets/images/img_16.png') as ImageProvider
                : NetworkImage(widget.image),
            radius: 24.0,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(widget.title, style: TextStyle(fontWeight:
              FontWeight.w400,color: Colors.white,fontSize: 12.sp,
                  fontFamily: "Figtree")),
              SizedBox(height: 8.0),
              Row(
                children: [
                  GestureDetector(
                    onTap:areButtonsDisabled ? null : () => _onAcceptPressed(widget.requestId),
                    // style: ElevatedButton.styleFrom(
                    //   primary: isAccepted ? selectedButtonColor : unselectedButtonColor,
                    // ),
                    child: Container(
                      height: 25.h,
                     width: 100.w,
                     // Adjust the width as needed
                     alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: isAccepted
                            ? buttonGradient
                            : null, // Apply gradient if accepted
                        color: areButtonsDisabled ? buttonDisabledColor : (!isAccepted ? buttonDisabledColor : null), // Apply solid color if not accepted
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        'Accept',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: "Figtree",
                          color: areButtonsDisabled ? Colors.white : (isAccepted ? Colors.black : Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: areButtonsDisabled ? null : () => _onRejectPressed(widget.requestId),
                    // onPressed: _onRejectPressed,
                    // style: ElevatedButton.styleFrom(
                    //
                    //   primary: isRejected ? selectedButtonColor : unselectedButtonColor,
                  child: Container(
                    height: 25.h,
                    width: 100.w, //// Adjust the width as needed
                   // padding: EdgeInsets.symmetric(vertical: 12.h),
                   alignment: Alignment.center,
                    decoration: BoxDecoration(
                    gradient: isRejected
                    ? buttonGradient
                        : null, // Apply gradient if rejected
                      color: areButtonsDisabled ? buttonDisabledColor : (!isRejected ? buttonDisabledColor : null), // Apply solid color if not rejected
                    borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                    'Reject',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Figtree",
                    color: isRejected ? Colors.black : Colors.white,
                    ),
                    ),
                    ),
                    ),



                ],
              ),
            ],
          ),
        ),

       // Divider(thickness: 1,color:Color(0xFF383838) ,),
      ],
    );
  }
}

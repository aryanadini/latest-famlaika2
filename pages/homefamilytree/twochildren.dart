// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../constants/Displaychildren.dart';
//
// class TwoChildrenWidget extends StatelessWidget {
//   final String firstChildImage;
//   final String firstChildName;
//   final String secondChildImage;
//   final String secondChildName;
//
//   TwoChildrenWidget({
//     required this.firstChildImage,
//     required this.firstChildName,
//     required this.secondChildImage,
//     required this.secondChildName,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned(
//           top: 0.79.sh,
//           left: 0.42.sw - 120.w,
//           child: DisplayChildren(
//             imagehgt: 50.h,
//             imagewdt: 58.w,
//             imagebradius: 40.r,
//             cthgt: 46.h,
//             ctwdt: 120.w,
//             imageUrl: firstChildImage,
//             persongname: firstChildName,
//             personrelation: "Child",
//             isEditoraddmember: false,
//             isDeleteMember: false,
//             relationType: '',
//           ),
//         ),
//         Positioned(
//           top: 0.79.sh,
//           left: 0.42.sw + 48.w,
//           child: DisplayChildren(
//             imagehgt: 50.h,
//             imagewdt: 58.w,
//             imagebradius: 40.r,
//             cthgt: 46.h,
//             ctwdt: 120.w,
//             imageUrl: secondChildImage,
//             persongname: secondChildName,
//             personrelation: "Child",
//             isEditoraddmember: false,
//             isDeleteMember: false,
//             relationType: '',
//           ),
//         ),
//       ],
//     );
//   }
// }

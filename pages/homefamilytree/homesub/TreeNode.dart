// import 'package:flutter/material.dart';
//
// class TreeNode extends StatelessWidget {
//   final String label;
//   final bool isCurrentUser;
//   final VoidCallback onTap;
//
//   const TreeNode({
//     required this.label,
//     this.isCurrentUser = false,
//     required this.onTap,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: onTap,
//           child: Container(
//             width: 80,
//             height: 100,
//             decoration: BoxDecoration(
//               color: isCurrentUser ? Colors.orange : Colors.grey[800],
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: 30,
//                   backgroundImage: isCurrentUser
//                       ? AssetImage('assets/images/me.jpg') // Replace with your image
//                       : null,
//                   child: isCurrentUser
//                       ? null
//                       : Icon(
//                     Icons.person,
//                     color: Colors.white,
//                     size: 30,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   '+ $label',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

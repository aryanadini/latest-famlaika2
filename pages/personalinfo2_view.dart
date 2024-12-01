// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:dart_date/dart_date.dart';
// import 'package:intl/intl.dart';
// class secpage extends StatefulWidget {
//   const secpage({super.key});
//
//   @override
//   State<secpage> createState() => _secpageState();
// }
//
// class _secpageState extends State<secpage> {
//
//   TextEditingController dateinput = TextEditingController();
//   TextEditingController dateController = TextEditingController();
//
//   final formKey = GlobalKey<FormState>();
//
//   String name = "";
//
//   @override
//   void initState() {
//     dateinput.text = ""; //set the initial value of text field
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//             height: 150,
//       child: Column(
//                   children: [
//                 Align(
//                   alignment: Alignment.topLeft,
//             child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//               child: Text(
//                   "Full Name",
//                   style: TextStyle(
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xFFFFFFFF),
//                   fontFamily: 'Figtree',
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//           ),
//
//           SizedBox(
//             height: 32,
//             child: TextField(style: TextStyle(color: Color(0xFFFFFFFF),
//                     fontFamily: 'Figtree',fontSize: 16,fontWeight: FontWeight.w400),
//                     decoration:
//
//               InputDecoration(
//
//                     border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide.none),
//                     fillColor: Colors.black.withOpacity(0.1),
//                     filled: true,
//               ),
//             ),
//           ),
//             Align(
//                   alignment: Alignment.topLeft,
//               child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//               child: Text(
//                   "Date of Birth",
//                   style: TextStyle(
//                   fontWeight: FontWeight.w400,
//                   fontFamily: 'figtree',
//                   color: Color(0xFFFFFFFF),
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//           ),
//
//           SizedBox(
//             height: 34,
//             width: 290,
//             child: TextField(style: TextStyle(color:
//             Color(0xFFFFFFFF),fontWeight: FontWeight.w400,fontSize: 16,fontFamily: 'Figtree'),
//                     controller: dateController,
//                     decoration: InputDecoration(
//
//                     suffixIcon: Icon(Icons.calendar_month),
//                     border:
//                 OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide.none),
//                     fillColor: Colors.black.withOpacity(0.1),
//                     filled: true,
//               ),
//                     readOnly: true,
//               onTap: () async {
//                 DateTime? pickedDate = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(2000),
//                     lastDate: DateTime(2124));
//                     if (pickedDate != null) {
//                     print(pickedDate);
//                     String formattedDate =
//                   DateFormat('dd-MM-yyyy').format(pickedDate);
//                     print(formattedDate);
//                   setState(() {
//                     dateController.text = formattedDate;
//                   });
//                 } else {
//                   print("Date is not selected");
//                 }
//               },
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
// }

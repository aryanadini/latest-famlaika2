// import 'package:famlaika1/constants/appbarConst.dart';
// import 'package:famlaika1/widgets/GradientButton.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
//
// import '../../constants/DisplaySibling.dart';
//
// class Sibling2famtree extends StatefulWidget {
//   final String siblingImage;
//   final String siblingName;
//   const Sibling2famtree({required this.siblingImage, required this.siblingName});
//
//   @override
//   State<Sibling2famtree> createState() => _Sibling2famtreeState();
// }
//
// class _Sibling2famtreeState extends State<Sibling2famtree> {
//   List<String> siblingimages = [
//     "assets/images/img_listsibling2.png",
//     "assets/images/img_listsibling3.png",
//     "assets/images/img_listsibling4.png",
//     "assets/images/img_listsiblig.png",
//     "assets/images/img_intersect_3.png",
//     "assets/images/img_intersect_1.png"
//
//   ];
//   List<String> siblingnames = ["Ancy Tom", "James Tom", "Tomy Tom", "Christopher", "Antony Tom","Tony Tom"];
//   String? siblingimg;
//   String? siblingnme;
//   bool selected = false;
//   ScrollController _scrollController=ScrollController();
//   bool isScrolledToEnd=false;
//   @override
//   void initState() {
// // TODO: implement initState
//     super.initState();
//     siblingimg = siblingimages[0];
//     siblingnme = siblingnames[0];
//     _scrollController.addListener(_scrollListener );
//   }
//   void _scrollListener(){
//     if (_scrollController.position.atEdge){
//       bool isTop=_scrollController.position.pixels==0;
//       if(!isTop){
//         setState(() {
//           isScrolledToEnd=true;
//         });
//       }
//     }else{
//       setState(() {
//         isScrolledToEnd=false;
//       });
//     }
//   }
//   @override
//   void dispose(){
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery
//         .of(context)
//         .size
//         .width.r;
//     var count = 4;
//     var widthFactor = .5.r;
//     void change() {
//       print("calling");
//       setState(() {
//         count = siblingimages.length;
//         widthFactor = 1.0.r;
//       });
//     }
//     return Scaffold(
//       backgroundColor: Colors.grey.shade900,
//       appBar: CustomAppBar(title: '${widget.siblingName}\'s Family Tree'),
//       body:SingleChildScrollView(
//         child: Container(
//           height:  1.sh,
//           //MediaQuery.of(context).size.height ,
//           width: 1.sw,
//           //MediaQuery.of(context).size.width ,
//           //670.r,
//           child: Stack(
//             children: [
//               Positioned(
//                   top: 0.1.sh,
//                   //MediaQuery.of(context).size.height * 0.1.h,
//                   left: 0.53.sw-15.w,
//                   //(MediaQuery.of(context).size.width * 0.5.w) - 15.w,
//                   child: Icon(Icons.favorite,color: Color(0xFFF7B52C),size: 24.sp,)
//
//
//               ),
//               Positioned(
//                   top:0.148.sh,
//                   //MediaQuery.of(context).size.height * 0.15.h,
//                   left: 0.53.sw-(0.01.sw),
//
//                   //(MediaQuery.of(context).size.width * 0.5.w) - 1.w,
//                   child: CContainer(
//                     cwidth:0.002.sw,
//                     cheight: 0.085.sh,
//                     //MediaQuery.of(context).size.height * 0.095,
//                   )
//               ), /// heart line
//               Positioned(
//                   top: 0.245.sh,
//                   //MediaQuery.of(context).size.height * 0.245,
//                   left:0.25.sw,
//                   //(MediaQuery.of(context).size.width * 0.25),
//                   child: CContainer(
//                     cheight: 0.001.sh,
//                     cwidth: selected == false ?  0.59.sw
//                     //(MediaQuery.of(context).size.width * 0.54) :
//                         : isScrolledToEnd==false ?
//                     0.8.sw
//                         : 0.468.sw,
//                     // (MediaQuery.of(context).size.width * 0.8):(MediaQuery.of(context).size.width * 0.4)
//
//
//                   )),
//               ///above sibling
//               Positioned(
//                   top: 0.245.sh,
//                   //MediaQuery.of(context).size.height * 0.245,
//                   left: 0.25.sw,
//                   //(MediaQuery.of(context).size.width * 0.25),
//                   child: CContainer(
//                     cheight: 0.51.sw,
//                     //(MediaQuery.of(context).size.width * 0.51),
//                     cwidth: 1,
//                   )),
//
//               ///near sibling
//               selected==false?
//               Positioned(
//                   top: 0.245.sh,
//                   //MediaQuery.of(context).size.height * 0.245,
//                   left: 0.42.sw,
//                   //(MediaQuery.of(context).size.width * 0.4),
//                   child: CContainer(
//                     cheight: 0.3.sw,
//                     //(MediaQuery.of(context).size.width * 0.3),
//                     cwidth: 1,
//                   )): Container(),
//
//               ///first sibilng line
//
//               Positioned(
//                   top: 0.531.sh,
//                   //MediaQuery.of(context).size.height * 0.531,
//                   left: 0.54.sw-1,
//                   //(MediaQuery.of(context).size.width * 0.5) - 1,
//                   child: CContainer(
//                     cwidth: 1,
//                     cheight: 0.115.sh,
//                     //MediaQuery.of(context).size.height * 0.115,
//                   )
//
//               ),
//
//               ///child line
//               Positioned(
//                   top: 0.53.sh,
//                   //MediaQuery.of(context).size.height * 0.53,
//                   left: 0.25.sw,
//                   //(MediaQuery.of(context).size.width * 0.25),
//                   child: CContainer(
//                     cheight: 1,
//                     cwidth: 0.5.sw,
//                     //(MediaQuery.of(context).size.width * 0.5),
//                   )),
//               /// me to spouse
//               selected == false ? Positioned(
//                 top: 0.29.sh,
//                 //MediaQuery.of(context).size.height * 0.29,
//                 left: 0.4.sw-48.w,
//                 //(MediaQuery.of(context).size.width * 0.4) - 48,
//                 child: DisplaySibling(
//                   imagehgt: 50.h,
//                   imagewdt: 58.w,
//                   imagebradius: 40.r,
//                   cthgt: 46.h,
//                   ctwdt: 120.w,
//                   imageUrl: siblingimages[0],
//                   persongname: siblingnme![0],
//                   personrelation: "Sibling",
//                   isEditoraddmember: false,
//                   isDeleteMember: false, relation_id: 0, onDelete: (int ) {  }, onEdit: () {  },
//
//                 ),
//               )///first sibling
//                   :Positioned(
//                 top:0.29.sh,
//                 //MediaQuery.of(context).size.height * 0.29,
//                 left:0.42.sw - 55.w,
//                 //(MediaQuery.of(context).size.width * 0.42) - 55,
//                 child: Container(
//                   color: Colors.transparent,
//                   height: 10.h,
//
//                   width: 10.w,
//                   // child: DisplaySibling(
//                   //   imagehgt: 80,
//                   //   imagewdt: 80,
//                   //   imagebradius: 40,
//                   //   cthgt: 56,
//                   //   ctwdt: 110,
//                   //   imageUrl: siblingimages[0],
//                   //   persongname: siblingnames[0],
//                   //   personrelation: "Sibling",
//                   // ),
//                 ),
//               ),
//
//               Positioned(
//                 top: 0.241.sh,
//                 //MediaQuery.of(context).size.height * 0.245,
//                 left: selected==false ?
//                 0.589.sw - 22.5.w : 0.32.sw - 10.5.w,
//                 //((MediaQuery.of(context).size.width * 0.55) - 22.5):((MediaQuery.of(context).size.width*0.32)-22.5),
//
//                 child: selected == false
//                     ? Padding(
//                   padding: EdgeInsets.only(
//                     left: 0.063.sw,
//                     // MediaQuery.of(context).size.width * 0.063
//                   ),
//                   child: Container(
//                     height: 80.h,
//                     width: 480.w,
//
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: count >= 4 ?5 : siblingimages
//                           .length + 1,
//                       itemBuilder: (context, index) =>
//                       !(index == count)
//                           ? InkWell(
//                         highlightColor: Colors.transparent,
//                         hoverColor: Colors.transparent,
//                         splashColor: Colors.transparent,
//                         onTap: () {
//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(
//                           //     builder: (context) => Sibling2famtree(
//                           //       siblingImage: siblingimages[index],
//                           //       siblingName: siblingnme![index],
//                           //     ),
//                           //   ),
//                           // );
//                           change();
//                           setState(() {
//
//                           });
//                         },
//                         child: Align(
//                           widthFactor: widthFactor,
//                           child: DisplaySmallWidget(
//                             //siblingname: siblingnames[index],
//                             // sinblingimage:
//                             //AssetImage("${siblingimages[index]}"),
//                             simagehgt: 40.h,
//                             simagewdt: 40.w,
//                             simagebradius: 20.r,
//                             siblingname: '',
//                             sinblingimage: (siblingimages[index]),
//                           ),
//                         ),
//                       )
//                           : InkWell(
//                         highlightColor: Colors.transparent,
//                         hoverColor: Colors.transparent,
//                         splashColor: Colors.transparent,
//                         onTap: () {
//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(
//                           //     builder: (context) => Siblingfamtree(
//                           //       siblingImage: siblingimages[index],
//                           //       siblingName: siblingnames[index],
//                           //     ),
//                           //   ),
//                           // );
//                           change();
//                           setState(() {
//                             selected = true;
//
//                           });
//                         },
//                         child: Align(
//                           widthFactor: widthFactor,
//                           child: DisplaySmallWidget(
//                             // siblingname: siblingnames[index],
//                             // sinblingimage: AssetImage("${siblingimages[index]}"),
//
//                             simagehgt: 40.h,
//                             simagewdt: 40.w,
//                             simagebradius: 40.r,
//                             stext: "2 +",
//                             siblingname: '',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                 )
//                 //   : Padding(
//                 // padding: const EdgeInsets.only(left: 20.0),
//                     : Container(
//                   height: 0.226.sh,
//                   //MediaQuery.of(context).size.height * 0.226,
//
//                   width: 0.3.sh,
//                   //MediaQuery.of(context).size.height * 0.3,/// show all frames
//                   child: InkWell(
//                     highlightColor: Colors.transparent,
//                     hoverColor: Colors.transparent,
//                     splashColor: Colors.transparent,
//                     onTap: (){
//
//                     },
//                     child: ListView.builder(
//                       controller: _scrollController,
//                       shrinkWrap: true,
//                       scrollDirection: Axis.horizontal,
//                       itemCount: siblingimages.length,
//                       itemBuilder: (BuildContext context,
//                           int index) {
//                         return InkWell(
//                           highlightColor: Colors.transparent,
//                           hoverColor: Colors.transparent,
//                           splashColor: Colors.transparent,
//                           onTap: () {
//                             // Navigator.push(
//                             //   context,
//                             //   MaterialPageRoute(
//                             //     builder: (context) => Siblingfamtree(
//                             //       siblingImage: siblingimages[index],
//                             //       siblingName: siblingnme![index],
//                             //     ),
//                             //   ),
//                             // );
//                             setState(() {
//                               selected = false;
//                             });
//                           },
//
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 2.0,right:30),
//                             child: Container(
//                               height:0.1.sh + 80.h,
//                               //MediaQuery.of(context).size.height * 0.1 + 80,
//                               width: 110.w,
//                               child: Stack(children: [
//                                 Positioned(
//                                   top: 4.h,
//                                   left: 65.w,
//                                   //110 / 2,
//                                   child: CContainer(
//                                     cwidth: 1,
//                                     cheight:0.1.sh+ 80.h,
//                                     //MediaQuery.of(context).size.height * 0.1,
//                                   ),
//                                 ), /// above siblings line vertical
//                                 Positioned(
//                                   bottom: 0,
//                                   left: 0,
//                                   child: DisplaySibling(
//
//                                     imagehgt: 50.h,
//                                     imagewdt: 58.w,
//                                     imagebradius: 40.r,
//                                     cthgt: 46.h,
//                                     ctwdt: 120.w,
//                                     imageUrl: siblingimages[index],
//                                     persongname: siblingnme![index],
//                                     personrelation: "Sibling",
//                                     isEditoraddmember: false,
//                                     isDeleteMember: false, relation_id: 0, onDelete: (int ) {  }, onEdit: () {  },
//                                   ),
//                                 ),
//                               ]),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//               // ),
//
//               Positioned(
//                 top: 0.04.sh,
//                 //MediaQuery.of(context).size.height * 0.04,
//                 left: 0.25.sw -55.w,
//                 //(MediaQuery.of(context).size.width * 0.25) - 55,
//                 child: DisplaySibling(
//                   imagehgt: 50.h,
//                   imagewdt: 58.w,
//                   imagebradius: 40.r,
//                   cthgt: 46.h,
//                   ctwdt: 120.w,
//                   isEditoraddmember: false,
//                   isDeleteMember: false, imageUrl: 'assets/images/img_father.png', persongname: 'Tom Hanks',
//                   personrelation: 'Father',relation_id: 0, onDelete: (int ) {  }, onEdit: () {  },
//                 ),
//               ), // father
//               Positioned(
//                 top: 0.04.sh,
//                 //MediaQuery.of(context).size.height * 0.04,
//                 left: 0.75.sw - 55.w,
//                 //(MediaQuery.of(context).size.width * 0.75) - 55,
//                 child: DisplaySibling(
//                   imagehgt: 50.h,
//                   imagewdt: 58.w,
//                   imagebradius: 40.r,
//                   cthgt: 46.h,
//                   ctwdt: 120.w,
//                   isEditoraddmember: false,
//                   isDeleteMember: false, imageUrl: 'assets/images/img_mother.png', persongname: 'Victoria',
//                   personrelation: 'Mother',relation_id: 0, onDelete: (int ) {  }, onEdit: () {  },
//                 ),
//               ), // mother
//               Positioned(
//                 top: 0.47.sh,
//                 //MediaQuery.of(context).size.height * 0.47,
//                 left:0.24.sw - 55.w,
//                 //(MediaQuery.of(context).size.width * 0.25) - 55,
//                 child: DisplaySibling(
//                   imagehgt: 50.h,
//                   imagewdt: 58.w,
//                   imagebradius: 40.r,
//                   cthgt: 46.h,
//                   ctwdt: 120.w,
//                   imageUrl: widget.siblingImage,
//                   persongname: widget.siblingName,
//                   personrelation: "Me",
//                   relation_id: 0,
//                   isEditoraddmember: false,
//                   isDeleteMember: false, onDelete: (int ) {  }, onEdit: () {  },
//                 ),
//               ), // me
//               Positioned(
//                 top: 0.47.sh,
//                 //MediaQuery.of(context).size.height * 0.47,
//                 left: 0.75.sw - 55.w,
//                 //(MediaQuery.of(context).size.width * 0.75) - 55,
//                 child: DisplaySibling(
//                   imagehgt: 50.h,
//                   imagewdt: 58.w,
//                   imagebradius: 40.r,
//                   cthgt: 46.h,
//                   ctwdt: 120.w,
//                   isEditoraddmember: false,
//                   isDeleteMember: false, imageUrl: 'assets/images/img_spousenewfam.png', persongname: 'Oliver James',
//                   personrelation: 'Spouse',relation_id: 0, onDelete: (int ) {  }, onEdit: () {  },
//                 ),
//               ), //spouse
//               Positioned(
//                 top: 0.63.sh,
//                 //MediaQuery.of(context).size.height * 0.63,
//                 left: 0.53.sw- 55.w,
//                 //(MediaQuery.of(context).size.width * 0.5) - 55,
//                 child: DisplaySibling(
//                   imagehgt: 50.h,
//                   imagewdt: 58.w,
//                   imagebradius: 40.r,
//                   cthgt: 46.h,
//                   ctwdt: 120.w,
//                   isEditoraddmember: false,
//                   isDeleteMember: false, imageUrl: 'assets/images/img_childnewfam.png', persongname: 'Benjamin',
//                   personrelation: 'Child', relation_id: 0, onDelete: (int ) {  }, onEdit: () {  },
//                 ),
//               ),
//               // child,
//               Positioned(
//                 top: 0.85.sh,
//                 left: 0.35.sw - 100.w,
//                 child: Container(
//                   height: 40.h,
//                   width: 325.w,
//                   child: GradientButton(
//                     onPressed: () {
//                       showModalBottomSheet(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return Container(
//                             padding: EdgeInsets.all(16.0),
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade900,
//                               borderRadius: BorderRadius.vertical(
//                                 top: Radius.circular(20.0),
//                               ),
//                             ),
//                             child: Stack(
//                               children: [
//                                 Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Icon(Icons.photo_outlined, color: Colors.white, size: 30),
//                                     SizedBox(height: 10),
//                                     Text(
//                                       'Are you sure?',
//                                       style: TextStyle(
//                                         fontFamily: 'Figtree',
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 16.sp,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                     SizedBox(height: 10),
//                                     Text(
//                                       "Do you really want to access ${widget.siblingName}'s gallery?",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         fontFamily: 'Figtree',
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 16.sp,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                     SizedBox(height: 20),
//                                     GradientButton(
//                                       onPressed: () {
//                                         showModalBottomSheet(
//                                           context: context,
//                                           builder: (BuildContext context)
//                                           {
//                                             return Container(
//                                               padding: EdgeInsets.all(16.0),
//                                               decoration: BoxDecoration(
//                                                 color: Colors.grey.shade900,
//                                                 borderRadius: BorderRadius
//                                                     .vertical(
//                                                   top: Radius.circular(20.0),
//                                                 ),
//                                               ),
//                                               child: Stack(
//                                                 children: [
//                                                   Column(
//                                                     mainAxisSize: MainAxisSize
//                                                         .min,
//                                                     crossAxisAlignment: CrossAxisAlignment
//                                                         .center,
//                                                     children: [
//                                                       Container(
//                                                         height:80.h,
//                                                         width: 350.w,
//                                                         decoration: BoxDecoration(
//                                                           shape: BoxShape.circle,
//
//                                                           color: Color(0xFF8FB021), // Tick icon circle color
//                                                         ),
//                                                         padding: EdgeInsets.all(
//                                                             8.0),
//                                                         child: Icon(
//                                                           Icons.check,
//                                                           color: Colors.white,
//                                                           size: 30,
//                                                         ),
//                                                       ),
//                                                       SizedBox(height: 10),
//                                                       Text(
//                                                         'Successfully Sent',
//                                                         style: TextStyle(
//                                                           fontFamily: 'Figtree',
//                                                           fontWeight: FontWeight
//                                                               .w600,
//                                                           fontSize: 16.sp,
//                                                           color: Colors.white,
//                                                         ),
//                                                       ),
//                                                       SizedBox(height: 5),
//                                                       Text(
//                                                         "Successfully sent request for access\n ${widget
//                                                             .siblingName}'s gallery.",
//                                                         textAlign: TextAlign
//                                                             .center,
//                                                         style: TextStyle(
//                                                           fontFamily: 'Figtree',
//                                                           fontWeight: FontWeight
//                                                               .w400,
//                                                           fontSize: 14.sp,
//                                                           color: Colors.white,
//                                                         ),
//                                                       ),
//                                                       SizedBox(height: 20),
//
//                                                     ],
//                                                   ),
//                                                   Positioned(
//                                                     top: 2.0.h,
//                                                     right: 2.0.w,
//                                                     child: GestureDetector(
//                                                       onTap: () {
//                                                         Navigator.pop(
//                                                             context); // Close the bottom sheet
//                                                       },
//                                                       child: Container(
//                                                         decoration: BoxDecoration(
//                                                           shape: BoxShape.circle,
//                                                           color: Colors.white
//                                                               .withOpacity(0.2),
//                                                           border: Border.all(
//                                                             color: Colors.white,
//                                                             width: 2.0,
//                                                           ),
//                                                         ),
//                                                         padding: EdgeInsets.all(4.0),
//                                                         child: Icon(
//                                                           Icons.close,
//                                                           size: 15.sp,
//                                                           color: Colors.white,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             );
//                                           },
//                                         );
//                                       },
//                                       child: Text(
//                                         'Request Gallery Access',
//                                         style: TextStyle(
//                                           fontFamily: 'Figtree',
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 14.sp,
//                                           color: Color(0xFF1E1E1E),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Positioned(
//                                   top: 2.0.h,
//                                   right: 2.0.w,
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       Navigator.pop(context); // Close the modal bottom sheet
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         border: Border.all(
//                                           color: Colors.white,
//                                           width: 2.0,
//                                         ),
//                                         color: Colors.white.withOpacity(0.2),
//                                       ),
//                                       padding: EdgeInsets.all(4.0),
//                                       child: Icon(
//                                         Icons.close,
//                                         color: Colors.white70,
//                                         size: 15.sp,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     },
//                     child: Text(
//                       "Request Gallery Access",
//                       style: TextStyle(
//                         fontFamily: 'Figtree',
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16.sp,
//                         color: Color(0xFF1E1E1E),
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//
//
//             ],
//
//           ),
//
//         ),
//       ),
//
//
//     );
//   }
// }
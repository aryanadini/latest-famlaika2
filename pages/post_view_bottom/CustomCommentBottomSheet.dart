// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
//
// class CommentPage extends StatefulWidget {
//   final List<Map<String, dynamic>> comments;
//   CommentPage({required this.comments});
//
//   @override
//   State<CommentPage> createState() => _CommentPageState();
// }
//
// class _CommentPageState extends State<CommentPage> {
//   final TextEditingController _commentController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   XFile? _selectedImage;
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> _pickImage(BuildContext context) async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = pickedFile;
//       });
//     }
//   }
//
//   void _addComment() {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         widget.comments.insert(0, {
//           'userImage': 'assets/img/userpic.jpg',
//           'username': 'New User',
//           'text': _commentController.text,
//           'time': 'Just now',
//         });
//         _commentController.clear();
//       });
//       FocusScope.of(context).unfocus();
//     }
//   }
//
//   Widget _buildCommentList() {
//     return ListView.builder(
//       controller: _scrollController,
//       itemCount: widget.comments.length,
//       itemBuilder: (context, index) {
//         final comment = widget.comments[index];
//         return Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     backgroundImage: AssetImage(comment['userImage']),
//                     radius: 15.0,
//                   ),
//                   SizedBox(width: 8.0),
//                   Expanded(
//                     child: Container(
//                       padding: EdgeInsets.all(12.0),
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade800,
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             comment['username'],
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           SizedBox(height: 4.0),
//                           Text(
//                             comment['text'],
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 14.0,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 35.h),
//                 child: Text(
//                   comment['time'],
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 12.0,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Comment Page"),
//         backgroundColor: Colors.pink,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: _buildCommentList(),
//           ),
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         backgroundImage: AssetImage('assets/img/userpic.jpg'),
//                         radius: 15.0,
//                       ),
//                       SizedBox(width: 8.0),
//                       Expanded(
//                         child: Container(
//                           padding: EdgeInsets.symmetric(horizontal: 16.0),
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade800,
//                             borderRadius: BorderRadius.circular(5.0),
//                           ),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: TextFormField(
//                                   controller: _commentController,
//                                   decoration: InputDecoration(
//                                     hintText: 'Write a comment...',
//                                     hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
//                                     border: InputBorder.none,
//                                   ),
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Comment cannot be blank';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () => _pickImage(context),
//                                 child: Image.asset(
//                                   'assets/images/album.png',
//                                   width: 30.w,
//                                   height: 30.h,
//                                 ),
//                               ),
//                               IconButton(
//                                 icon: Icon(Icons.emoji_emotions_outlined, color: Colors.white, size: 28.sp),
//                                 onPressed: () {},
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(CupertinoIcons.paperplane_fill, color: Colors.amber),
//                         onPressed: _addComment,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class CommentPage extends StatefulWidget {
  final List<Map<String, String>> comments;
  CommentPage({required this.comments});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
      });
    }
  }

  void _addComment() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        widget.comments.insert(0, {
          'userImage': 'assets/images/img_intersect2.png', // Add your user image path here
          'username': 'New User', // Replace with the actual user's name
          'text': _commentController.text,
          'time': 'Just now', // You can add logic to show the actual time here
        });
        _commentController.clear();
      });
      FocusScope.of(context).unfocus();
    }
  }

  Widget _buildCommentList() {
    return Padding(
      padding:  EdgeInsets.only(top: 20,right: 50),


        child: ListView.builder(
          controller: _scrollController,
          itemCount: widget.comments.length,
          itemBuilder: (context, index) {
            final comment = widget.comments[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(comment['userImage']!),
                        radius: 15.0,
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment['username']!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                comment['text']!,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 35.h),
                    child: Text(
                      comment['time']!,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
     // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey.shade900 ,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.only(top:60.0,left: 20),
            child: Text(
              'Newest',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: _buildCommentList(),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),

            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/img_intersect_2.png'), // Your user image path
                        radius: 15.0,
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _commentController,
                                  decoration: InputDecoration(
                                    hintText: 'Write a comment...',
                                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Comment cannot be blank';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _pickImage(context),
                                child: Image.asset(
                                  'assets/images/album.png',
                                  width: 30.w,
                                  height: 30.h,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.emoji_emotions_outlined, color: Colors.white, size: 28.sp),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(CupertinoIcons.paperplane_fill, color: Colors.amber),
                        onPressed: _addComment,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

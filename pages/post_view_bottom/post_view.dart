

import 'package:famlaika1/constants/imageDisplaypage.dart';
import 'package:famlaika1/pages/post_view_bottom/createpost_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../apiservice/api_services.dart';
import '../../constants/home2appbar.dart';
import 'CustomCommentBottomSheet.dart';

class postfeed extends StatefulWidget {
  late final File? postedImage;
  late final String postedText;

  postfeed({this.postedImage, required this.postedText, });
  @override
  State<postfeed> createState() => _postfeedState();
}

class _postfeedState extends State<postfeed> {
  late Future<Map<String, dynamic>> _profileFuture;
  Map<int, bool> _visibilityMap = {};
  String? _selectedPostId;
  bool _showContainer = false;
  final List<Map<String, dynamic>> posts = [
    {
      'userimage': 'assets/images/intersect_1.png',
      'username': 'John Doe',
      'timestamp': '2 days ago',
      'text': 'Loving the new updates!',
      'image': 'assets/images/postfeed1.png',
      'commentCount': 2,
      'comments': [
        {
          'userImage': 'assets/images/intersect_1.png',
          'username': 'Mark White',
          'text': 'Keep it up!',
          'time': '3 hours ago',
        },
        {
          'userImage': 'assets/images/intersect_3.png',
          'username': 'Sarah Green',
          'text': 'Great job!',
          'time': '5 hours ago',
        },
      ],
    },
    {
      'userimage': 'assets/images/intersect_2.png',
      'username': 'Jane Smith',
      'timestamp': '1 day ago',
      'text': 'Just finished a great workout session.',
      'image': 'assets/images/postfeed3.png',
      'commentCount': 1
      ,
      'comments': [
        {
          'userImage': 'assets/images/intersect_1.png',
          'username': 'Tom Brown',
          'text': 'Awesome!',
          'time': '2 hours ago',
        },
      ],
    },
    {
      'userimage': 'assets/images/intersect_3.png',
      'username': 'Alice Johnson',
      'timestamp': '3 hours ago',
      'text': 'Exploring new places!',
      'image': 'assets/images/postfeed1.png',
      'commentCount': 2,
      'comments': [
        {
          'userImage': 'assets/images/intersect_2.png',
          'username': 'David Brown',
          'text': 'Looks beautiful!',
          'time': '2 hours ago',
        },
        {
          'userImage': 'assets/images/intersect_1.png',
          'username': 'Emily Blue',
          'text': 'Where is this?',
          'time': '4 hours ago',
        },
      ],
    },
    // Add more posts as needed
  ];

  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
      });
      // Handle the picked image
    }
  }

  void _showCommentsBottomSheet(List<Map<String, dynamic>> comments) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        List<Map<String, String>> stringComments = comments.map((comment) {
          return comment.map((key, value) => MapEntry(key, value.toString()));
        }).toList();

        return CommentPage(comments: stringComments);
      },
    );
  }
  @override
  void initState() {
    super.initState();
    _profileFuture = ApiService().fetchProfile();
    // Check if there's data to add
    if (widget.postedImage != null && widget.postedText .isEmpty) {
      setState(() {
        posts.insert(0, {
          'userimage': 'assets/images/your_image.png',
          // Replace with the user's image
          'username': 'Your Name',
          // Replace with the user's name
          'timestamp': 'Just now',
          'text': widget.postedText,
          'image': widget.postedImage?.path,
          'commentCount': 1,
          'comments': [
            {
              'userImage': 'assets/images/intersect_2.png',
              'username': 'David Brown',
              'text': 'Looks beautiful!',
              'time': '2 hours ago',
            },
            {
              'userImage': 'assets/images/intersect_1.png',
              'username': 'Emily Blue',
              'text': 'Where is this?',
              'time': '4 hours ago',
            },
          ],
        });

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: Home2AppBar(titleImage: "assets/images/img_logo.png", showActions: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150.h,
              decoration: BoxDecoration(
                color: Color(0xFF262626),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 2.0.w,bottom: 26.h,left: 16.w,),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Stack(

                        children: [
                          GestureDetector(
                      onTap:(){
                      //   Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => CreatePostPage(),
                      //   ),
                      // );
                        },


                            child: FutureBuilder<Map<String, dynamic>>(
                              future: _profileFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(child: Text('Error: ${snapshot.error}'));
                                } else if (snapshot.hasData) {
                                  final profile = snapshot.data!;
                                  final profilePicUrl = profile['profile_pic'] ?? ''; // Adjust based on API response structure

                                  print('Profile Pic URL: $profilePicUrl');

                                  return CircleAvatar(
                                    radius: 40.0,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: profilePicUrl.isNotEmpty
                                        ? NetworkImage(profilePicUrl)
                                        : AssetImage('assets/images/user.png') as ImageProvider,
                                  );
                                } else {
                                  return Center(child: Text('No data available'));
                                }
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => _pickImage(context),
                              child: Container(
                                height: 24.h,
                                width: 24.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFF7B52C),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => CreatePostPage(),
                                    //   ),
                                    // );
                                  },
                                  icon: Icon(Icons.add, size: 10.sp, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0.h,
                      left: 0,
                      top: 106.h,
                      child: Text(
                        "Your Story",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            // Story Section
            Container(
              padding: EdgeInsets.all(16.0.w),
              decoration: BoxDecoration(
                color: Color(0xFF262626),
                borderRadius: BorderRadius.circular(10.0.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      FutureBuilder<Map<String, dynamic>>(
                        future: _profileFuture, // Your function to fetch the profile
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircleAvatar(
                              radius: 20.r,
                              backgroundColor: Colors.grey,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else if (snapshot.hasError) {
                            return CircleAvatar(
                              radius: 20.r,
                              backgroundColor: Colors.grey,
                              backgroundImage: AssetImage('assets/images/user.png'), // Default image in case of error
                            );
                          } else if (snapshot.hasData) {
                            final profile = snapshot.data!;
                            final profilePicUrl = profile['profile_pic'] ?? 'assets/images/user.png'; // Fallback to default image

                            return CircleAvatar(
                              radius: 20.r,
                              backgroundColor: Colors.grey,
                              backgroundImage: profilePicUrl.startsWith('http')
                                  ? NetworkImage(profilePicUrl)
                                  : AssetImage(profilePicUrl) as ImageProvider,
                            );
                          } else {
                            return CircleAvatar(
                              radius: 20.r,
                              backgroundColor: Colors.grey,
                              backgroundImage: AssetImage('assets/images/user.png'), // Default image if no data
                            );
                          }
                        },
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "What's on your mind?",
                        style: TextStyle(
                          color: Color(0xFF949292),
                          fontSize: 16.sp,
                          fontFamily: "Figtree",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    // child: TextField(
                    //   decoration: InputDecoration(
                    //     hintText: 'Type something...',
                    //     hintStyle: TextStyle(color: Colors.grey.shade500),
                    //     enabledBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.grey.shade700),
                    //     ),
                    //     focusedBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.grey.shade500),
                    //     ),
                    //     border: UnderlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.grey.shade700),
                    //     ),
                    //   ),
                    // ),
                    child: Divider(color: Colors.grey.shade800,),
                  ),
                  SizedBox(height: 16.h),
                  if (_selectedImage != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.file(
                          File(_selectedImage!.path),
                          width: double.infinity,
                          height: 200.h, // Adjust the height as needed
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _pickImage(context), // Image tapped
                        child: Image.asset(
                          'assets/images/album.png',
                          //fit: BoxFit.cover, // Fixes border issues
                          width: 30.w,
                          height: 30.h,
                        ),
                      ),
                      // IconButton(
                      //   icon: Icon(Icons.photo_outlined, color: Colors.white),
                      //   onPressed: () => _pickImage(context),
                      // ),
                      IconButton(
                        icon: Icon(Icons.emoji_emotions_outlined,
                          color: Colors.white70,size: 28.sp,),
                        onPressed: () {
                          // Handle emoji selection
                        },
                      ),
                      Spacer(),
                      Container(
                        height: 38.h,
                        width: 85.w,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFF3802B), Color(0xFFFAE42C)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreatePostPage(),
                              ),
                            );
                            // Handle post action
                          },
                          style: ElevatedButton.styleFrom(

                            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                            backgroundColor: Colors.transparent, // Make the button background transparent
                            shadowColor: Colors.transparent, // Remove shadow
                          ),
                          child: Text(
                            "Post",
                            style: TextStyle(
                              color: Color(0xFF1E1E1E),
                              fontSize: 16.sp,
                              fontFamily: "Figtree",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            // Display Posts
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                final post = posts[index];
                final comments = post['comments'] ?? [];
                final String? imagePath = post['image'];
                _visibilityMap.putIfAbsent(index, () => false);

                return Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF262626),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Stack(
                          children: [Row(
                            children: [
                              CircleAvatar(
                                radius: 20.r,
                                backgroundImage: AssetImage(post['userimage'] ?? ''),
                              ),
                              SizedBox(width: 8.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post['username'] ?? 'Unknown',
                                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    post['timestamp'] ?? '',
                                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                                  ),

                                ],
                              ),
                              Spacer(),
                             // if (_showContainer)

                                Visibility(
                                  visible: _visibilityMap[index] ?? false,
                                  child:
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade800,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _visibilityMap[index] = false;
                                              _showContainer = false;
                                             // _showBottomSheet(context);
                                             // _showContainer = false;
                                            });
                                            _showBottomSheet(context);
                                          },
                                          child: Text(
                                            'Add to Gallery',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _visibilityMap[index] = false;
                                              _showContainer = false;
                                            });
                                          },
                                          child: Text(
                                            'Hide',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              if (!(_visibilityMap[index] ?? false))
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _visibilityMap.updateAll((key, value) => false);
                                    _showContainer = !_showContainer;
                                    _visibilityMap[index] = !_visibilityMap[index]!;
                                  });
                                },
                              icon: Icon(CupertinoIcons.ellipsis_vertical,
                                  color: Colors.white),
                                                            ),

                              // IconButton(
                              //   onPressed: (){},
                              //   icon: Icon(CupertinoIcons.ellipsis_vertical, color: Colors.white),
                              // ),



                            ],
                          ),]
                        ),

                                                  ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            post['text'] ?? '',
                            style: TextStyle(color: Colors.white, fontSize: 14.sp),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        if (imagePath != null)
                          GestureDetector(
                            onTap: (){
                              // String text = post['text'] ?? '';
                              // String imagePath = post['imagePath'];

                              bool isFile = File(imagePath).existsSync();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageDisplayPage
                                    (imagePath: imagePath,
                                    isFile: isFile,
                                    text: post['text'] ?? '',
                                   ),
                                ),
                              );
                            },
                            child: Padding(padding: EdgeInsets.all(8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child:_buildImageWidget(imagePath)
                              // Image.asset(imagePath,
                              //   height: 200.h,
                              //   width: double.infinity,
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                            ),
                          ),


                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Row(
                                children: [

                                  SizedBox(width: 1.w),
                                  IconButton(
                                    onPressed: () {
                                      _showCommentsBottomSheet(comments);
                                    },
                                    icon: Icon(CupertinoIcons.chat_bubble_text, color: Colors.white),

                                  ),

                                  //SizedBox(width: 2.w),
                                  TextButton(
                                    onPressed: () {
                                      _showCommentsBottomSheet(comments);
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero, // Remove padding to align with text
                                      minimumSize: Size(0, 0), // Remove minimum size constraints
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink tap area
                                    ),
                                    child: Text(
                                      '${post['commentCount'] ?? 0} comments',
                                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14.sp),
                                    ),
                                  ) ,
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(CupertinoIcons.arrowshape_turn_up_right, color: Colors.white),
                                    onPressed: () {
                                      // Handle share action
                                    },
                                  ),


                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Divider(
                                color: Colors.grey.shade700,
                                thickness: 0.5,
                              ),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: comments.length > 2 ? 2 : comments.length,
                                itemBuilder: (BuildContext context, int commentIndex){
                                  final comment = comments[commentIndex];
                                  return Padding(padding:
                                  EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // CircleAvatar(
                                        //   radius: 12.r,
                                        //   backgroundImage: AssetImage(comment['userImage']),
                                        // ),
                                        SizedBox(width: 8.w,),
                                        Expanded(child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              comment['username'] ?? 'Unknown',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(width: 4.w,),
                                            TextButton(
                                              onPressed: () {
                                                _showCommentsBottomSheet(comments);
                                              },
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero, // Remove padding to align with text
                                                minimumSize: Size(0, 0), // Remove minimum size constraints
                                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                               // padding: EdgeInsets.zero, // Remove padding if you want it to behave like a regular text
                                               // alignment: Alignment.centerLeft, // Ensure the text is aligned as desired
                                              ),
                                              child: Text(
                                                comment['text'] ?? '',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                            )
                                          ],
                                        ))
                                      ],
                                    ),
                                  );

                            }
                            )


                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}
Widget _buildImageWidget(String imagePath) {
  bool isFile = File(imagePath).existsSync();

  return isFile
      ? Image.file(
    File(imagePath),
    height: 200.h,
    width: double.infinity,
    fit: BoxFit.cover,
  )
      : Image.asset(
    imagePath,
    height: 200.h,
    width: double.infinity,
    fit: BoxFit.cover,
  );
}
void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor:  Colors.grey.shade900,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true,

    builder: (context) {
      return Container(
        height: 180.h,
          width: double.infinity,
        child: Wrap(
          children: [Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFF8FB021),
                    child: Icon(Icons.check, color: Colors.white, size: 30),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Text(
                        'Successfully Added',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5.h,),
                      Text(
                        'Successfully added this post to your',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 5.h,),
                      Text(
                        'gallery.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),]
        ),
      );
    },
  );
}


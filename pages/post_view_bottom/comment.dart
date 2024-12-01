import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCommentOverlay extends StatelessWidget {
  final List<Map<String, dynamic>> comments;

  CustomCommentOverlay({required this.comments});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100.h,
      right: 0,
      left: 0,
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF333333),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10)],
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Color(0xFF444444),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Newest',
                      style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 20.r,
                            backgroundImage: AssetImage(comment['userImage']),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comment['username'],
                                  style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  comment['text'],
                                  style: TextStyle(color: Colors.grey.shade300, fontSize: 12.sp),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  comment['time'],
                                  style: TextStyle(color: Colors.grey.shade500, fontSize: 10.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Color(0xFF444444),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundImage: AssetImage('assets/images/intersect_1.png'), // Example user image
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Add your comment',
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.photo, color: Colors.white),
                                onPressed: () {
                                  // Handle gallery icon button
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.emoji_emotions, color: Colors.white),
                                onPressed: () {
                                  // Handle emoji icon button
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.send, color: Colors.white),
                                onPressed: () {
                                  // Handle send button
                                },
                              ),
                            ],
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showCustomCommentOverlay(BuildContext context, List<Map<String, dynamic>> comments) {
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, animation, secondaryAnimation) {
        return CustomCommentOverlay(comments: comments);
      },
    ),
  );
}

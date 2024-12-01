import 'package:famlaika1/constants/appbarConst.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class ActivityItem {
  final String profileImage;
  final String otherpro;
  final String othername;
  final String name;
  final String commentText;
  final String date;
  final String postImage;
  final int commentCount;

  ActivityItem({
    required this.otherpro,
    required this.othername,
    required this.profileImage,
    required this.name,
    required this.commentText,
    required this.date,
    required this.postImage,
    required this.commentCount,
  });
}
class ActivityPage extends StatelessWidget {
  final List<ActivityItem> activityItems = [
    ActivityItem(
      profileImage: 'assets/images/img_listsibling2.png',
      name: 'Alexandra James',
      commentText: 'My baby fills a place in your heart that you never knew was empty.',
      date: '1 day',
      postImage: 'assets/images/postfeed1.png',
      commentCount: 5, otherpro: 'assets/images/img_listsibling3.png',
      othername: 'Joe',
    ),
    ActivityItem(
      profileImage: 'assets/images/profile2.jpg',
      name: 'Alexandra James',
      commentText: 'Love the new update!',
      date: '2 days',
      postImage: 'assets/images/postfeed2.png',
      commentCount: 3, otherpro: 'assets/images/img_listsibling4.png',
      othername: 'John',
    ),
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: CustomAppBar(
        title: "Activity"
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text(
              'New',
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Figtree",
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),

            // First Column
            Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF262626)),
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFF383838)
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.penToSquare, color: Color(0xFFFFFFFF), size: 15),
                    onPressed: (){

                    },


                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'You changed your profile name',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: "Figtree",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Second Column - List View
            Expanded(
              child: ListView.builder(
                itemCount: activityItems.length, // Number of items
                itemBuilder: (context, index) {
                  final item = activityItems[index];
                  return Container(

                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF262626)),
                      borderRadius: BorderRadius.circular(5),
                        color: Color(0xFF383838)
                    ),
                    margin: EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // First Column in List Item
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(item.profileImage), // Replace with actual image
                              radius: 12,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${item.name} commented on this',
                                style: TextStyle(fontSize: 12,
                                  color: Colors.white,
                                  fontFamily: "Figtree",
                                  fontWeight: FontWeight.w400,),
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Color(0xFF4E4C4C)),
                        SizedBox(height: 8),

                        // Second Column in List Item
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(item.otherpro), // Replace with actual image
                              radius: 22,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.othername,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    item.date, // Replace with actual date
                                    style: TextStyle(color: Colors.grey.shade600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),

                        // Third Column in List Item
                        Text(
                         item.commentText,
                          style: TextStyle(color: Colors.white,
                            fontFamily: "Figtree",
                            fontWeight: FontWeight.w400,
                          fontSize: 14),
                        ),
                        SizedBox(height: 8),

                        // Fourth Column in List Item
                        Image.asset(
                          item.postImage, // Replace with actual image
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 8),

                        // Fifth Column in List Item
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(CupertinoIcons.chat_bubble_text,color: Colors.white,),
                              onPressed: () {
                                // Handle comment icon button press
                              },
                            ),
                            SizedBox(width: 4),
                            Text('5 comments'), // Replace with actual comment count
                            Spacer(),
                            IconButton(
                              icon: Icon(CupertinoIcons.arrowshape_turn_up_right,color: Colors.white,),
                              onPressed: () {
                                // Handle share icon button press
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



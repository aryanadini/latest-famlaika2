import 'package:flutter/material.dart';
import 'dart:io';

class ImageDetailPage extends StatelessWidget {
  final File? image;
  final String? text;

  ImageDetailPage({this.image, this.text});

  @override
  Widget build(BuildContext context) {
    // Example comments (replace with your dynamic data)
    List<String> comments = ['Alex: Wow', 'Jom: Very nice'];
    // Example gallery images (replace with your dynamic data)
    List<String> galleryImages = [
      'assets/gallery_image_1.jpg',
      'assets/gallery_image_2.jpg',
      'assets/gallery_image_3.jpg',
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text('Image Detail'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Detail Container
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFF2B2B2B),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/profile.jpg'),
                          radius: 24.0,
                        ),
                        SizedBox(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Profile Name',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Just now',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.more_vert, color: Colors.white),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      text ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    if (image != null)
                      Image.file(
                        image!,
                        fit: BoxFit.cover,
                      ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.comment, color: Colors.white),
                            SizedBox(width: 4.0),
                            Text(
                              '2 comments',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Icon(Icons.share, color: Colors.white),
                      ],
                    ),
                    Divider(color: Colors.grey),
                    // Comments Section
                    for (String comment in comments)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          comment,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              // My Gallery Section

              SizedBox(height: 8.0),

            ],
          ),
        ),
      ),
    );
  }
}

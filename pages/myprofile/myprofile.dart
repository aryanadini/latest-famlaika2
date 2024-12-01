import 'dart:io';

import 'package:famlaika1/constants/appbarConst.dart';
import 'package:famlaika1/pages/myprofile/Edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiservice/api_services.dart';
import 'ImageDetailPage.dart';

class ProfilePage extends StatefulWidget {
  //final List<File> images;
  final File? image;
  final File? postedImage;
  final String? postedText;


  ProfilePage({this.image,this.postedImage, this.postedText, });
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _mobileNumber;
  String gender = 'Unknown';
  late Future<Map<String, dynamic>> _profileFuture;
  File ? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      // Do something with the selected image
      print('Image path: ${image.path}');
      // For example, you can use it to update the profile picture
    }
  }

  bool showGallery = true;
  @override
  void initState() {
    super.initState();
    // Set _selectedImage to the postedImage if it's not null
    _selectedImage = widget.postedImage;
    _profileFuture = ApiService().fetchProfile();
    loadMobileNumber();
  }
  Future<void> loadMobileNumber() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedPhoneNumber = prefs.getString('phoneNumber'); // Retrieve the mobile number
    setState(() {
      _mobileNumber = storedPhoneNumber; // Assign it to the variable
    });
    print("Mobile number loaded: $_mobileNumber"); // Debugging line
  }
  Future<void> saveMobileNumber(String phoneNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneNumber', phoneNumber); // Save the mobile number
    print("Mobile number saved: $phoneNumber");
    loadMobileNumber(); // Reload the number after saving
  }


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: CustomAppBar(title: "My profile",
      actionWidget: IconButton(onPressed: (){}, icon: Icon(Icons.share_outlined,color: Colors.white,)),),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        FutureBuilder<Map<String, dynamic>>(
                          future: _profileFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Container(
                                width: 80,
                                height: 80,
                                child: Center(child: CircularProgressIndicator()),
                              );
                            } else if (snapshot.hasError) {
                              return Container(
                                width: 80,
                                height: 80,
                                child: Center(child: Text('Error loading image')),
                              );
                            } else if (snapshot.hasData) {
                              final profile = snapshot.data!;
                              final profilePicUrl = profile['profile_pic'] ?? 'assets/images/user.png'; // Default image if not available
                              final profileName = profile['name'] ?? 'Unknown';

                              return Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Color(0xFFF7B52C), width: 1),
                                    image: DecorationImage(
                                      image: NetworkImage(profilePicUrl), // Use NetworkImage for profile picture
                                      fit: BoxFit.cover,
                                    ),
                                  )
                              );
                            } else {
                              return Container(); // Fallback case if nothing is available
                            }
                          },
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.amber,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    FutureBuilder<Map<String, dynamic>>(
                      future: _profileFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text(
                            'Loading name...',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final profile = snapshot.data!;
                          final profileName = profile['name'] ?? 'Unknown';

                          return Text(
                            profileName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else {
                          return Container(); // Fallback case if nothing is available
                        }
                      },
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: Color(0xFF8FB021),
                          child: Icon(Icons.check, color: Colors.white, size: 8),
                        ),
                        SizedBox(width: 4),
                        Text('Active', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 16),
                Spacer(),
                Column(
                  children: [
                    Text('10', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Posts',style: TextStyle(color: Color(0xFF949292)),),
                  ],
                ),
                SizedBox(width: 16),
                Column(
                  children: [
                    Text('8', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Groups',style: TextStyle(color: Color(0xFF949292)),),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showGallery = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        gradient: showGallery
                            ? LinearGradient(colors: [Colors.yellow, Colors.orange])
                            : null,
                        color: showGallery ? null : Color(0xFF383838),
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(4)),
                      ),
                      child: Text(
                        'My Gallery',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: showGallery ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showGallery = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        gradient: !showGallery
                            ? LinearGradient(colors: [Colors.yellow, Colors.orange])
                            : null,
                        color: !showGallery ? null : Color(0xFF383838),
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(4)),
                      ),
                      child: Text(
                        'My Profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: !showGallery ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: showGallery
                  ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: 9, // Number of images
                itemBuilder: (context, index) {
                  if (index == 0 && _selectedImage != null) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         ImageDetailPage(
                        //           image: _selectedImage,
                        //           text: widget.postedText,
                        //         ),
                        //   ),
                        // );
                      },
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to ImageDetailPage for other images
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         ImageDetailPage(
                        //           image: _selectedImage,
                        //           text: widget.postedText,
                        //         ),
                        //   ),
                        // );
                      },
                      child: Container(
                        color: Colors.grey.shade300,
                        child: Image.asset('assets/gallery_image_$index.jpg',
                            fit: BoxFit.cover),
                      ),
                    );
                  }
                },
              )
                  : Padding(
                    padding:  EdgeInsets.only(bottom: 40.h),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF2B2B2B), // Background color
                        borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      ),
                      padding: EdgeInsets.all(16.0),

                      child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Basic Info",style: TextStyle(color:Color(0xFFFFFFFF),
                                              fontSize: 16.sp,fontFamily: "Figtree",
                                              fontWeight: FontWeight.bold,

                                            ),),
                                            IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute
                                              (builder: (context) => Editprofile()));},
                                                icon: FaIcon(FontAwesomeIcons.penToSquare, color: Colors.grey.shade400,
                                                    size: 18),),
                                          ],
                                        ),
                                        SizedBox(height: 12.h,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.grey.shade700, // Outline color
                                                  width: 1.0, // Border thickness
                                                ),
                                              ),
                                              child: CircleAvatar(
                                                backgroundColor:Color(0xFF262626) ,
                                                  child: Icon(Icons.phone,color: Colors.grey.shade400,)),
                                            ),
                                            SizedBox(width: 15.w,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Mobile Number',style: TextStyle(
                                                  fontSize: 14.sp,color: Color(0xFFFFFFFF),
                                                  fontFamily: "Figtree",
                                                  fontWeight: FontWeight.w500,),
                                                ),
                                                SizedBox(height: 4.h,),
                                                Text(
                                                  _mobileNumber ?? "111111",
                                                  style: TextStyle(
                                                  fontSize: 14.sp,fontFamily: "Figtree",
                                                  color: Color(0xFF575757),
                                                ),),

                                              ],
                                            ),

                                              ],
                                            ),



                                        SizedBox(height: 25.h,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.grey.shade700, // Outline color
                                                width: 1.0, // Border thickness
                                              ),
                                            ),
                                            child: CircleAvatar(
                                              backgroundColor:Color(0xFF262626) ,
                                              child: Icon(Icons.person,
                                                color: Colors.grey.shade400,),
                                            ),
                                          ),
                                            SizedBox(width: 15.w,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Gender: ",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Color(0xFFFFFFFF),
                                                    fontFamily: "Figtree",
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                FutureBuilder<Map<String, dynamic>>(
                                                  future: _profileFuture,
                                                  builder: (context, snapshot) {
                                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                                      return Text(
                                                        'Loading...',
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontFamily: "Figtree",
                                                          color: Color(0xFF575757),
                                                        ),
                                                      );
                                                    } else if (snapshot.hasError) {
                                                      return Text(
                                                        'Error',
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontFamily: "Figtree",
                                                          color: Color(0xFF575757),
                                                        ),
                                                      );
                                                    } else if (snapshot.hasData) {
                                                      final profile = snapshot.data!;
                                                      final genderValue = profile['gender'] ?? 0; // Default to 0 if gender is not available
                                                      final genderString = (genderValue == 1) ? 'Male' : (genderValue == 2) ? 'Female' : 'Unknown';

                                                      return Text(
                                                        genderString,
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontFamily: "Figtree",
                                                          color: Color(0xFF575757),
                                                        ),
                                                      );
                                                    } else {
                                                      return Text(
                                                        'Unknown',
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontFamily: "Figtree",
                                                          color: Color(0xFF575757),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 25.h),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.grey.shade700, // Outline color
                                                  width: 1.0, // Border thickness
                                                ),
                                              ),
                                              child: CircleAvatar(
                                                  backgroundColor:Color(0xFF262626) ,
                                                  child: Icon(Icons.cake,
                                                      color: Colors.grey.shade400)),
                                            ),
                                            SizedBox(width: 15.w),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Date of Birth:',
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Color(0xFFFFFFFF),
                                                    fontFamily: "Figtree",
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                FutureBuilder<Map<String, dynamic>>(
                                                  future: _profileFuture,
                                                  builder: (context, snapshot) {
                                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                                      return Text(
                                                        'Loading...',
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontFamily: "Figtree",
                                                          color: Color(0xFF575757),
                                                        ),
                                                      );
                                                    } else if (snapshot.hasError) {
                                                      return Text(
                                                        'Error',
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontFamily: "Figtree",
                                                          color: Color(0xFF575757),
                                                        ),
                                                      );
                                                    } else if (snapshot.hasData) {
                                                      final profile = snapshot.data!;
                                                      final dateOfBirth = profile['date_of_birth'] ?? 'Unknown'; // Default to 'Unknown' if date of birth is not available

                                                      return Text(
                                                        dateOfBirth,
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontFamily: "Figtree",
                                                          color: Color(0xFF575757),
                                                        ),
                                                      );
                                                    } else {
                                                      return Text(
                                                        'Unknown',
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontFamily: "Figtree",
                                                          color: Color(0xFF575757),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),

                                    //    SizedBox(height: 15.h,)


                                      ],
                                    ),
                    ),

                  ),
            ),
          ],
        ),
      ),
    );
  }
}

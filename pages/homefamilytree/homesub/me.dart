import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../apiservice/api_services.dart';
import '../../../constants/ImageConstant.dart';
import '../../../constants/colors.dart';
import '../../../widgets/custom_OutlinedButton.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_image_view.dart';
import '../../addmember/addmember_view.dart';
import '../../skeletontree/FamilyMemberProvider.dart';


class Famtree2 extends StatefulWidget {
  final String? mePhotoPath;
  final bool isGenderFixed;
  Famtree2({super.key, this.mePhotoPath, this.isGenderFixed=false});

  @override
  State<Famtree2> createState() => _Famtree2State();
}

class _Famtree2State extends State<Famtree2> {
  bool isSibling = false;
  bool isMale = Random().nextBool();
  String get relation {
    if (isSibling) {
      return isMale ? 'Brother' : 'Sister'; // Sibling relation
    }
    return isMale ? 'Son' : 'Daughter'; // Child relation
  }
  int get gender => isMale ? (isSibling ? 4 : 7) : (isSibling ? 5 : 6);
  late Future<Map<String, dynamic>> _profileFuture;
  @override
  void initState() {
    super.initState();
    _profileFuture = ApiService().fetchProfile(); // Fetch profile data
  }
  void _toggleGender() {
    setState(() {
      isMale = !isMale; // Toggle gender
    });
  }
  void _toggleRelation() {
    setState(() {
      isSibling = !isSibling; // Toggle relation between child and sibling
    });
  }
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Center(  // Center widget to place the entire structure in the center
          child: SingleChildScrollView(

            child: Column(
              children: [
                SizedBox(height: 5.h),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 530.h,
                    width: 345.w,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.03,
                          left: (MediaQuery.of(context).size.width * 0.45) - 15.w,
                          child: Icon(
                            Icons.favorite,
                            color: Color(0xFFF7B52C),
                            size: 24.h,
                          ),
                        ),
                        Positioned(
                          height: 200.h,
                          width: 215.w,
                          top: 67.h,
                          left: 55.w,
                          child: Image.asset("assets/images/img_union.png"),
                        ),
                        Positioned(
                          height: 320.h,
                          width: 145.w,
                          top: 170.h,
                          left: 98.w,
                          child: Image.asset("assets/images/img_Tunion.png"),
                        ),
                        _buildMotherButton(context),
                        _buildChildButton(context),
                        _buildMeButton(context),
                        _buildSpouseButton(context),
                        _buildSiblingsButton(context),
                        Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            height: 107.h,
                            width: 130.w,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                _buildFatherButton(context),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMotherButton(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 52.h,
          right: 17.w,
          child: CustomOutlinedButton(
            width: 120.w,
            text: "+Mother",
            margin: EdgeInsets.only(top: 59.h),
            leftIcon: Container(
              margin: EdgeInsets.only(right: 0),
            ),
            alignment: Alignment.topRight,
            onPressed: () {
              final familyTreeState = Provider.of<FamilyTreeProvider>(
                  context, listen: false);
              familyTreeState.addMember(false, "Mother", 2);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Addmember(
                    defaultMale: false,
                    isGenderFixed: true,
                    relation: "Mother",
                    gender: 2,
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 45.w, top: 2.h),
          child: CustomIconButton(
            onTap: () {
              final familyTreeState = Provider.of<FamilyTreeProvider>(context, listen: false);
              familyTreeState.addMember(false, "Mother", 2);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Addmember(
                    defaultMale: false,
                    isGenderFixed: true,
                    relation: "Mother",
                    gender: 2,
                  ),
                ),
              );
            },
            height: 50.h,
            width: 58.w,
            padding: EdgeInsets.all(15.w),
            alignment: Alignment.topRight,
            avatarImagePath: "assets/images/img_16.png",
            avatarSize: 30.w,
            child: CustomImageView(
              imagePath: ImageConstant.imgframe,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSiblingsButton(BuildContext context) {


    return Stack(
      children: [
        Positioned(
          bottom: 297.h,
          right: 17.w,
          child: CustomOutlinedButton(
            width: 120.w,
            text: "+Siblings",
            margin: EdgeInsets.only(bottom: 12.h),
            leftIcon: Container(
              margin: EdgeInsets.only(right: 0),
            ),
            alignment: Alignment.centerRight,
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Addmember(
                    defaultMale: true,
                    isGenderFixed: false,relation: "Brother",
                    gender: gender,
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 142.h,
            right: 40.w,
          ),
          child: CustomIconButton(
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Addmember(
                    defaultMale: true,
                    isGenderFixed: false,relation: "Brother",
                    gender: gender,
                  ),
                ),
              );
            },
            height: 50.h,
            width: 58.w,
            padding: EdgeInsets.all(15.w),
            alignment: Alignment.topRight,
            avatarImagePath: "assets/images/img_16.png",
            avatarSize: 30.w,
            child: CustomImageView(
              imagePath: ImageConstant.imgframe,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChildButton(BuildContext context) {

    return Stack(
      children: [
        Positioned(
          bottom: 80.h,
          right: 110.w,
          child: CustomOutlinedButton(
            width: 120.w,
            text: "+Child",
            leftIcon: Container(
              margin: EdgeInsets.only(right: 0),
            ),
            alignment: Alignment.bottomCenter,
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Addmember(
                    defaultMale: true,
                    isGenderFixed: false,relation: "Son",
                    gender: gender,
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 115.h, left: 3.w),
          child: CustomIconButton(
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Addmember(
                    defaultMale: true,
                    isGenderFixed: false,relation: "Son",
                    gender: gender,
                  ),
                ),
              );
            },
            height: 50.h,
            width: 58.w,
            padding: EdgeInsets.all(15.w),
            alignment: Alignment.bottomCenter,
            avatarImagePath: "assets/images/img_16.png",
            avatarSize: 30.w,
            child: CustomImageView(
              imagePath: ImageConstant.imgframe,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMeButton(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 175.h,
          left: 15.w,
          child: CustomOutlinedButton(
            width: 120.w,
            buttonTextStyle: theme.textTheme.bodyLarge!,
            text: "Me",
            margin: EdgeInsets.only(bottom: 107.h),
            alignment: Alignment.bottomLeft,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.only(right: 200.w, bottom: 210.h),
            child: CustomIconButton(
              height: 50.h,
              width: 58.w,
              padding: EdgeInsets.all(15.w),
              alignment: Alignment.bottomCenter,
              avatarImagePath: "assets/images/img_16.png",
              avatarSize: 30.w,
              child: CustomImageView(
                imagePath: ImageConstant.imgframe,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpouseButton(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 175.h,
          //left: 0.75.sw - 55.w,
          right: 17.w,
          child: CustomOutlinedButton(
            width: 120.w,
            text:"+Spouse",
            leftIcon: Container(
              margin: EdgeInsets.only(right: 0),
            ),
            alignment: Alignment.bottomRight,
            onPressed: () {
              final familyTreeState = Provider.of<FamilyTreeProvider>(context, listen: false);
              familyTreeState.addMember(false, "Spouse", 3);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Addmember(
                    defaultMale: false,
                    isGenderFixed: false,
                    relation: "Spouse",
                    gender: 3,
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 210.h, left: 200.w),
          child: CustomIconButton(
            onTap: () {
              final familyTreeState = Provider.of<FamilyTreeProvider>(context, listen: false);
              familyTreeState.addMember(false, "Spouse", 3);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Addmember(
                    defaultMale: false,
                    isGenderFixed: false,
                    relation: "Spouse",
                    gender: 3,
                  ),
                ),
              );
            },
            height: 50.h,
            width: 58.w,
            padding: EdgeInsets.all(15.w),
            alignment: Alignment.bottomCenter,
            avatarImagePath: "assets/images/img_16.png",
            avatarSize: 30.w,
            child: CustomImageView(
              imagePath: ImageConstant.imgframe,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFatherButton(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 50.h,
          left: 10.w,
          child: CustomOutlinedButton(
            width: 120.w,
            text: "+ Father",
            margin: EdgeInsets.only(top: 59.h),
            leftIcon: Container(

              margin: EdgeInsets.only(left:0.w),
              // child: Image(
              //   image: AssetImage("assets/images/img_plus.png"),
              //   height: 16.h,
              //   width: 16.w,
              // ),
            ),
            alignment: Alignment.bottomCenter,
            onPressed: () {
              Provider.of<FamilyTreeProvider>(context, listen: false)
                  .addMember(false, 'Father', 1);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Addmember(defaultMale: true,
                    isGenderFixed: true,relation: "Father",gender: 1,),
                ),
              );
            },
          ),
        ),
        Padding(padding: EdgeInsets.only(
            left: 40.w,bottom: 185.h)),
        CustomIconButton(
          onTap: () {
            Provider.of<FamilyTreeProvider>(context, listen: false)
                .addMember(false, 'Father', 1);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Addmember(defaultMale: true,
                  isGenderFixed: true,relation: "Father",gender: 1, ),
              ),
            );
          },
          height: 50.h,
          width: 58.w,
          padding: EdgeInsets.all(15.w),
          alignment: Alignment.topCenter,
          avatarImagePath: "assets/images/img_16.png",
          avatarSize: 30.w,
          child: CustomImageView(
            imagePath: ImageConstant.imgframe,
          ),
        ),
        // Positioned(
        //   top: 15.h,
        //   right: 75.w,
        //   child: CircleAvatar(
        //     radius: 15.w,
        //     backgroundColor: Color(0xFF949292),
        //     backgroundImage: AssetImage("assets/images/img_1.png"),
        //   ),
        // ),
      ],
    );
  }
}

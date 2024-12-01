import 'dart:math';
import 'package:famlaika1/constants/bottom.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:famlaika1/constants/ImageConstant.dart';
import 'package:famlaika1/constants/appDecoration.dart';
import 'package:famlaika1/constants/appbarConst.dart';
import 'package:famlaika1/pages/addmember/addmember_view.dart';
import 'package:famlaika1/widgets/custom_icon_button.dart';
import 'package:famlaika1/widgets/custom_image_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../apiservice/api_services.dart';
import '../../constants/DisplaySibling.dart';
import '../../constants/colors.dart';
import '../../widgets/custom_OutlinedButton.dart';
import '../addmember/MemberData.dart';
import 'FamilyMemberProvider.dart';
import 'FamilyMemberProvider.dart';

class Famtree extends StatefulWidget {
  final String? mePhotoPath;
  final bool isGenderFixed;
  Famtree({super.key, this.mePhotoPath, this.isGenderFixed=false});

  @override
  State<Famtree> createState() => _FamtreeState();
}

class _FamtreeState extends State<Famtree> {
  bool isSibling = false;
  bool isMale = Random().nextBool();
  String get relation {
    if (isSibling) {
      return isMale ? 'Brother' : 'Sister'; // Sibling relation
    }
    return isMale ? 'Son' : 'Daughter'; // Child relation
  }
  int get gender => isMale ? (isSibling ? 4 : 7) : (isSibling ? 5 : 6);
  // Map<String, dynamic> _generateGenderProperties() {
  //   bool isMale = Random().nextBool();
  //   return {
  //     'relation': isSibling ? (isMale ? 'Brother' : 'Sister') : (isMale ? 'Son' : 'Daughter'),
  //     'gender': isSibling ? (isMale ? 1 : 2) : (isMale ? 1 : 2),
  //     'isMale': isMale,
  //   };
  // }

  late Future<Map<String, dynamic>> _profileFuture;
  @override
  void initState() {
    super.initState();
    _profileFuture = ApiService().fetchProfile(); // Fetch profile data
  }

  void _navigateToAddMember(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Addmember(
          defaultMale: isMale,
          isGenderFixed: false,
          relation: relation,
          gender: gender,
        ),
      ),
    );
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
    final familyTreeState = Provider.of<FamilyTreeProvider>(context);
    return  SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: CustomAppBar(title: "Create Family tree",
          actionWidget: TextButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Bottom(),
              ),
            );
          }, child: Text("Skip",style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            fontFamily: "Figtree",
          ),)),

        ),

        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 16.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
          
                  width: 290.w,
          
                  //margin: EdgeInsets.only(right: 51.w),
                  child: RichText(text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Keep your family connected by adding them ',
                        style: TextStyle(fontSize: 14.sp,fontFamily: "Figtree", color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(text:'to your profile.',style: TextStyle(fontFamily: "Figtree",
                      fontSize: 14.sp,fontWeight: FontWeight.w600,color: Color(0xFFFFFFFF),height: 1.36.h
                      ))
                    ]
                  ))
                  // Text(
                  //   "Keep your family connected by adding them \nto your profile.",
                  //   maxLines: 2,
                  //   overflow: TextOverflow.ellipsis,
                  //   style: theme.textTheme.bodyMedium!.copyWith(height: 1.57.h),
                  // ),
                ),

                SizedBox(height: 33.h),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 502.h,
                    width: 345.w,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.03,
                          left: (MediaQuery.of(context).size.width * 0.44) - 15.w,
                          child:Icon(Icons.favorite,color: Color(0xFFF7B52C),
                          size: 24.h,
                          )
                          // Image(
                          //   image: AssetImage('assets/images/img_heart.png'),
                          //   height: 24.h,
                          //   width: 24.w,
                          //   alignment: Alignment.topCenter,
                          // ),
                        ),
                        Positioned(
                          height: 200.h,
                          width: 215.w,
                          top: 65.h,
                          left: 50.w,
                          // top: MediaQuery.of(context).size.height * 0.08,
                          //   left: (MediaQuery.of(context).size.width * 0.01) - 1.w,
          
                            child: Image.asset("assets/images/img_union.png")),
                        Positioned(
                            height: 320.h,
                            width: 130.w,
                            top: 170.h,
                            left: 98.w,
                            child: Image.asset("assets/images/img_Tunion.png",)),
                       ///me to spouse
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

    return
      Stack(
      children: [
        Positioned(
          top: 52.h,
          right: 23.w,

          child: CustomOutlinedButton(
            width: 110.w,
            text: "+ Mother",

            margin: EdgeInsets.only(top: 59.h),
            leftIcon: Container(
              margin: EdgeInsets.only(right: 0),
              // child: Image(
              //   image: AssetImage("assets/images/img_plus.png"),
              //   height: 16.h,
              //   width: 16.w,
              // ),
            ),
            alignment: Alignment.topRight,
            onPressed: () {
              final familyTreeState = Provider.of<FamilyTreeProvider>(
                  context, listen: false);
              familyTreeState.addMember(false, "Mother", 2);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Addmember(defaultMale: false,
                          isGenderFixed: true, relation: "Mother", gender: 2, ),
                  ),
                );


            }
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 45.w,top: 2.h),
          child: CustomIconButton(
            onTap: (){
              final familyTreeState = Provider.of<FamilyTreeProvider>(context, listen: false);
              familyTreeState.addMember(false, "Mother", 2);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Addmember(defaultMale: false,
                isGenderFixed: true, relation: "Mother", gender: 2, ),
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
        // Positioned(
        //   top: 15.h,
        //   right: 58.w,
        //   child: CircleAvatar(
        //     radius: 15.w,
        //     backgroundColor: Color(0xFF949292),
        //     backgroundImage: AssetImage("assets/images/img_1.png"),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildSiblingsButton(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 271.h,
          right: 20.w,
          child: CustomOutlinedButton(
            width: 110.w,
            text: "+ Siblings",
            margin: EdgeInsets.only(bottom: 12.h),
            leftIcon: Container(
              margin: EdgeInsets.only(right: 0),
              // child: Image(
              //   image: AssetImage("assets/images/img_plus.png"),
              //   height: 16.h,
              //   width: 16.w,
              // ),
            ),
            alignment: Alignment.centerRight,
            onPressed:() {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Addmember(defaultMale: true,
                    isGenderFixed: false,relation: "Brother",
                    gender: gender,),

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
            onTap: (){

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Addmember(defaultMale: true,
                    isGenderFixed: false,relation: "Brother",
                    gender: gender, ),
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
        // Positioned(
        //   top: 152.h,
        //   right: 53.w,
        //   child: CircleAvatar(
        //     radius: 15.w,
        //     backgroundColor: Color(0xFF949292),
        //     backgroundImage: AssetImage("assets/images/img_1.png"),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildChildButton(BuildContext context) {

    return Stack(
      children: [
        Positioned(
          bottom: 50.h,
          right: 110.w,
          child: CustomOutlinedButton(

            width: 110.w,
            text: "+ Child",
            leftIcon: Container(
              margin: EdgeInsets.only(right: 0),
              // child: Image(
              //   image: AssetImage("assets/images/img_plus.png"),
              //   height: 16.h,
              //   width: 16.w,
              // ),
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
          padding: EdgeInsets.only(bottom: 84.h,
              left: 3.w),
          child: CustomIconButton(
            onTap: ()  {

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
        // Positioned(
        //   top: 375.h,
        //   left: 155.w,
        //   child: CircleAvatar(
        //     radius: 15.w,
        //     backgroundColor: Color(0xFF949292),
        //     backgroundImage: AssetImage("assets/images/img_1.png"),
        //   ),
        // ),
      ],
    );
  }
  Widget _buildMeButton(BuildContext context) {

    return Stack(
      children: [
        Positioned(
          bottom: 150.h,
          left: 15.w,
          child: CustomOutlinedButton(
            width: 110.w,

            buttonTextStyle: theme.textTheme.bodyLarge!,
            text: "Me",
            margin: EdgeInsets.only(bottom: 107.h),
            alignment: Alignment.bottomLeft,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: 58.h,
            width: 58.w,
            margin: EdgeInsets.only(
              left: 40.w,
              bottom: 182.h,
            ),
            decoration: AppDecoration.outlineYellow.copyWith(
              borderRadius: BorderRadiusStyle.customBorderTL34,
            ),
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
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(29.w),
                    child: profilePicUrl.isNotEmpty
                        ? Image.network(
                      profilePicUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print('Error loading image: $error');
                        return Icon(Icons.error, size: 58.w, color: Colors.red);
                      },
                    )
                        : Icon(Icons.person, size: 58.w, color: Colors.grey),
                  );
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            ),

          ),
        ),
      ],
    );
  }

  Widget _buildSpouseButton(BuildContext context) {
    bool defaultMale = Random().nextBool();
    int gender = defaultMale ? 1 : 2;
    return Stack(
      children: [
        Positioned(
          bottom: 150.h,
          right: 21.w,
          child: CustomOutlinedButton(
            width: 110.w,
            text: "+ Spouse",

            leftIcon: Container(
              margin: EdgeInsets.only(right: 0),
              // child: Image(
              //   image: AssetImage("assets/images/img_plus.png"),
              //   height: 16.h,
              //   width: 16.w,
              // ),
            ),
            alignment: Alignment.centerRight,
            onPressed: () {
              Provider.of<FamilyTreeProvider>(context, listen: false)
                  .addMember(false, 'Spouse', 3);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Addmember(
                    defaultMale: defaultMale,
                    isGenderFixed: false,
                    relation: "Spouse",gender: gender,  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: 44.w,
            bottom: 182.h,
          ),
          child: CustomIconButton(
            onTap: () {
              Provider.of<FamilyTreeProvider>(context, listen: false)
                  .addMember(false, 'Spouse', 3);
                Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => Addmember(
                  defaultMale: defaultMale,
                  isGenderFixed: false,relation: "Spouse",
                  gender: gender,  ),
                ),
                );
                },
            height: 50.h,
            width: 58.w,

            padding: EdgeInsets.all(15.w),
            alignment: Alignment.bottomRight,
            avatarImagePath: "assets/images/img_16.png",
            avatarSize: 30.w,
            child: CustomImageView(
              imagePath: ImageConstant.imgframe,
            ),
          ),
        ),
        // Positioned(
        //   top: 277.h,
        //   right: 53.w,
        //   child: CircleAvatar(
        //     radius: 15.w,
        //     backgroundColor: Color(0xFF949292),
        //     backgroundImage: AssetImage("assets/images/img_1.png"),
        //   ),
        // ),
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
            width: 110.w,
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
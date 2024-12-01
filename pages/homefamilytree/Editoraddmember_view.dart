import 'dart:math';

import 'package:famlaika1/constants/appbarConst.dart';
import 'package:famlaika1/pages/addmember/addmember_view.dart';
import 'package:famlaika1/pages/homefamilytree/sibingfamilytree.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../apiservice/api_services.dart';
import '../../constants/DisplaySibling.dart';
import '../../constants/Displaychildren.dart';
import '../../constants/ImageConstant.dart';
import '../../widgets/custom_OutlinedButton.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_image_view.dart';
import '../skeletontree/FamilyMemberProvider.dart';

class Editoraddmember extends StatefulWidget {
  final String? userId;
  Editoraddmember({this.userId});

  @override
  State<Editoraddmember> createState() => _EditoraddmemberState();
}

class _EditoraddmemberState extends State<Editoraddmember> {
  bool isSibling = false;
   bool isMale = Random().nextBool();
  // int get relation {
  //   if (isSibling) {
  //     return isMale ? 4 : 5; // Sibling relation
  //   }
  //   return isMale ? 7 : 6; // Child relation
  // }
  int get  gender => isMale ? 1: 2;


  int selectedIndex = -1;
  final ApiService apiService = ApiService();

  Future<List<Map<String, dynamic>>>? _familyTreeFuture;

  //List<Map<String, dynamic>> profiles = [];
  int childCount = 0;
  double childWidthFactor = 1.0;

  void changeChild() {
    setState(() {
      // List<Map<String, dynamic>> children = profiles
      //     .where((profile) => profile['relation'] == 'child' || profile['relation'] == 6 || profile['relation'] == 7)
      //     .toList();

      // childCount = children.length; // Use the correct variable
      // childWidthFactor = 1.0.r; // Adjust this as needed
    });
  }

  //Future<List<dynamic>>? familyData;
  bool showExtraChildren = false;
  double scrollOffset = 100.0;
  late Future<Map<String, dynamic>> _profileFuture;


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


  List<String> childsimages = [
    "assets/images/img_listsibling2.png",

  ];
  List<String> childnames = [
    "Ancy Tom",

  ];
  List<String> siblingnames = [
    "assets/images/img_listsibling2.png",
  ];

  List<String> siblingimages = [
    "Ancy Tom"
  ];
  List<int> siblingRelations = [
    5, // Assuming 5 corresponds to SISTER
    4, // Assuming 4 corresponds to BROTHER
  ];

  Future<List<Map<String, dynamic>>> _fetchFamilyTree() async {
    await Future.delayed(Duration(seconds: 2)); // Simulated delay
    return [
      {
        'relation': 6,
        'profile_pic': 'assets/images/img_intersect_1.png',
        'name': 'Child 1'
      },
      {
        'relation': 7,
        'profile_pic': 'assets/images/img_intersect_2.png',
        'name': 'Child 2'
      },
      {
        'relation': 4,
        'profile_pic': 'assets/images/img_intersect_3.png',
        'name': 'Sibling 1'
      },
      {
        'relation': 5,
        'profile_pic': 'assets/images/img_intersect_4.png',
        'name': 'Sibling 2'
      },
      // Add more profiles as needed
    ];
  }

  String currentMechImage = "assets/images/img_me.png";
  String currentMechName = "Current me";

  String? childimg;
  String? childnme;
  bool selectedc = false;
  ScrollController _cscrollController = ScrollController();
  bool iscScrolledToEnd = false;


  String currentMeImage = "assets/images/img_me.png";
  String currentMeName = "Current me";

  String? siblingimg;
  String? siblingnme;
  bool selected = false;
  ScrollController _scrollController = ScrollController();
  bool isScrolledToEnd = false;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    _familyTreeFuture = apiService.fetchFamilyTree(userId: widget.userId);
    _profileFuture = ApiService().fetchProfile();
    //  familyMembersFuture = fetchFamilyTree(widget.userId);


    siblingimg = siblingimages[0];
    siblingnme = siblingnames[0];
    _scrollController.addListener(_scrollListener);
    childimg = childsimages[0];
    childnme = childnames[0];
    _cscrollController.addListener(_cscrollListener);
    _profileFuture = ApiService().fetchProfile();
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      bool isTop = _scrollController.position.pixels == 0;
      if (!isTop) {
        setState(() {
          isScrolledToEnd = true;
        });
      }
    } else {
      setState(() {
        isScrolledToEnd = false;
      });
    }
  }

  void _cscrollListener() {
    if (_cscrollController.position.atEdge) {
      bool isTop = _cscrollController.position.pixels == 0;
      if (!isTop) {
        setState(() {
          iscScrolledToEnd = true;
        });
      }
    } else {
      setState(() {
        iscScrolledToEnd = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();

    _cscrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width
        .r;
    var count = 4;
    var widthFactor = .5.r;
    void change() {
      print("calling");
      setState(() {
        count = siblingimages.length;
        widthFactor = 1.0.r;
      });
    }
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: CustomAppBar(title: "Edit or Add Member",
        actionWidget: TextButton(onPressed: () {

        }, child: Text("Skip", style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          fontFamily: "Figtree",
        ),)),
      ),


      body:


      SingleChildScrollView(
        child: Column(

          children: [
            SizedBox(height: 12.h,),
            Container(

              //color: Colors.pinkAccent,
              height: 65.h,
              width: 330.w,
              //color: Colors.pinkAccent,
              child: Align(
                alignment: Alignment.topLeft,

                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Select edit option for ‘Edit’ member and select ",
                        style: TextStyle(color: Color(0xFFFFFFFF),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: "‘Vacant space’ for adding family member.",
                        style: TextStyle(color: Color(0xFFFFFFFF),
                            fontSize: 16.sp,
                            height: 1.36.h,
                            fontWeight: FontWeight.w400),
                      ),
                    ]
                )),
                // Text(
                //   "Entering your personal details and\nsetting up your profile",
                //   maxLines: 2,
                //   overflow: TextOverflow.ellipsis,
                //   style: TextStyle(
                //     fontFamily: 'Figtree',
                //     fontWeight: FontWeight.w400,
                //     fontSize: 14.sp,
                //     color: Color(0xFFFFFFFF),
                //     height: 1.38.h,
                //   ),
                // ),
              ),
            ),
            Container(
                height: 1.sh,
                //MediaQuery.of(context).size.height ,
                width: 1.sw,
                //MediaQuery.of(context).size.width ,
                //670.r,

                child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _familyTreeFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        final profiles = snapshot.data!;

                        childsimages.clear();
                        childnames.clear();
                        siblingimages.clear();
                        siblingnames.clear();
                        //siblingRelations.clear();
                        bool isRelation3Present = false;
                        bool isRelation2Present = false;
                        bool isRelation1Present = false;
                        for (var profile in profiles) {
                          if (profile['relation'] == 6 ||
                              profile['relation'] == 7) {
                            // Use 'profile_pic' for image and 'name' for child's name
                            childsimages.add(profile['profile_pic'] ??
                                ''); // Add image, default to empty if null
                            childnames.add(profile['name'] ??
                                '');
                            // Add name, default to empty if null
                          }
                          else if (profile['relation'] == 4 ||
                              profile['relation'] == 5) {
                            // Use 'profile_pic' for image and 'name' for sibling's name
                            siblingimages.add(profile['profile_pic'] ??
                                ''); // Add image, default to empty if null
                            siblingnames.add(profile['name'] ??
                                '');
                            //siblingRelations.add(profile['relation'] ?? );// Add name, default to empty if null
                          }
                          else if (profile['relation'] == 3) {
                            isRelation3Present = true;
                          }
                          else if (profile['relation'] == 2) {
                            isRelation2Present = true;
                          }
                          else if (profile['relation'] == 1) {
                            isRelation1Present = true;
                          }
                        }


                        return Stack(
                          children: [

                            for (var profile in profiles)
                              if (profile['relation'] == 1)

                                Positioned(
                                  top: 0.04.sh,
                                  //MediaQuery.of(context).size.height * 0.04,
                                  left: 0.25.sw - 55.w,
                                  //(MediaQuery.of(context).size.width * 0.25) - 55,
                                  child: DisplaySibling(
                                    imagehgt: 50.h,
                                    imagewdt: 58.w,
                                    imagebradius: 40.r,
                                    cthgt: 46.h,
                                    ctwdt: 120.w,
                                    isDeleteMember: false,
                                    isEditoraddmember: true,
                                    imageUrl: profile['profile_pic'] ??
                                        'assets/images/img_intersect_3.png',
                                    persongname: profile['name'] ?? 'Unknown',
                                    personrelation: getRelationName(
                                        profile['relation']),
                                    gender: profile['gender'] ?? '',
                                    mobileNumber: profile['mobile'] ?? '',
                                    dateOfBirth: profile['dateOfBirth'] ?? '',
                                    relation_id: 0,
                                    onDelete: (int ) {  }, onEdit: () {  },
                                  ),
                                )


                              // father
                              else
                                if (profile['relation'] == 2)

                                  Positioned(
                                    top: 0.04.sh,
                                    //MediaQuery.of(context).size.height * 0.04,
                                    left: 0.75.sw - 55.w,
                                    //(MediaQuery.of(context).size.width * 0.75) - 55,
                                    child: DisplaySibling(
                                      imagehgt: 50.h,
                                      imagewdt: 58.w,
                                      imagebradius: 40.r,
                                      cthgt: 46.h,
                                      ctwdt: 120.w,
                                      isDeleteMember: false,
                                      isEditoraddmember: true,
                                      imageUrl: profile['profile_pic'],
                                      persongname: profile['name'] ?? 'name',
                                      personrelation: getRelationName(
                                          profile['relation']),
                                      gender: profile['gender'] ?? 3,
                                      mobileNumber: profile['mobileNumber'] ??
                                          '',
                                      dateOfBirth: profile['dateofbirth'] ??
                                          '',
                                      relation_id: 0, onDelete: (int ) {  }, onEdit: () {  },
                                    ),
                                  )


                                else
                                  if (profile['relation'] == 3)

                                    Positioned(
                                      top: 0.47.sh,
                                      //MediaQuery.of(context).size.height * 0.47,
                                      left: 0.75.sw - 55.w,
                                      //(MediaQuery.of(context).size.width * 0.75) - 55,
                                      child: DisplaySibling(
                                        imagehgt: 50.h,
                                        imagewdt: 58.w,
                                        imagebradius: 40.r,
                                        cthgt: 46.h,
                                        ctwdt: 120.w,
                                        isDeleteMember: false,
                                        imageUrl: profile['profile_pic'],
                                        persongname: profile['name'] ?? 'name',
                                        relationType: 'Spouse',
                                        personrelation: getRelationName(
                                            profile['relation']),
                                        gender: profile['gender'] ?? 3,
                                        mobileNumber: profile['mobile_number'] ??
                                            '',
                                        dateOfBirth: profile['date_of_birth'] ??
                                            '',
                                        relation_id: 0, onDelete: (int ) {  }, onEdit: () {  },

                                      ),
                                    ),

                            if (!isRelation3Present) ...[
                              Positioned(
                                top: 0.47.sh,
                                left: 0.75.sw - 55.w,
                                bottom: 0.38.sh,
                                right: 30.w,
                                child: CustomOutlinedButton(
                                  width: 120.w,
                                  height: 50.w,
                                  text: "+Spouse",
                                  leftIcon: Container(
                                    margin: EdgeInsets.only(right: 0),
                                  ),
                                  alignment: Alignment.bottomRight,
                                  onPressed: () {
                                    final familyTreeState = Provider.of<
                                        FamilyTreeProvider>(
                                        context, listen: false);
                                    familyTreeState.addMember(
                                        false, "Spouse", 3);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Addmember(
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
                                padding: EdgeInsets.only(
                                    bottom: 300.h, left: 190.w),
                                child: CustomIconButton(
                                  onTap: () {
                                    final familyTreeState = Provider.of<
                                        FamilyTreeProvider>(
                                        context, listen: false);
                                    familyTreeState.addMember(
                                        false, "Spouse", 3);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Addmember(
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
                              )

                            ], if (!isRelation2Present) ...[
                              Positioned(
                                top: 0.12.sh,
                                left: 0.75.sw - 55.w,
                                // top: 52.h,
                                right: 27.w,
                                child: CustomOutlinedButton(
                                  width: 120.w,
                                  height: 45.h,
                                  text: "Mother",
                                  margin: EdgeInsets.only(top: 59.h),
                                  leftIcon: Container(
                                    margin: EdgeInsets.only(right: 0),
                                  ),
                                  alignment: Alignment.topRight,
                                  onPressed: () {
                                    final familyTreeState = Provider.of<
                                        FamilyTreeProvider>(
                                        context, listen: false);
                                    familyTreeState.addMember(
                                        false, "Mother", 2);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Addmember(
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
                                padding: EdgeInsets.only(
                                    right: 58.w, top: 40.h),
                                child: CustomIconButton(
                                  onTap: () {
                                    final familyTreeState = Provider.of<
                                        FamilyTreeProvider>(
                                        context, listen: false);
                                    familyTreeState.addMember(
                                        false, "Mother", 2);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Addmember(
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
                            if (!isRelation1Present) ...[
                              Positioned(
                                top: 0.12.sh,
                                //MediaQuery.of(context).size.height * 0.04,
                                left: 0.25.sw - 55.w,
                                // top: 50.h,
                                // left: 10.w,
                                child: CustomOutlinedButton(
                                  width: 120.w,
                                  height: 45.h,
                                  text: "+ Father",
                                  margin: EdgeInsets.only(top: 59.h),
                                  leftIcon: Container(

                                    margin: EdgeInsets.only(left: 0.w),
                                    // child: Image(
                                    //   image: AssetImage("assets/images/img_plus.png"),
                                    //   height: 16.h,
                                    //   width: 16.w,
                                    // ),
                                  ),
                                  alignment: Alignment.bottomCenter,
                                  onPressed: () {
                                    Provider.of<FamilyTreeProvider>(
                                        context, listen: false)
                                        .addMember(false, 'Father', 1);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Addmember(defaultMale: true,
                                              isGenderFixed: true,
                                              relation: "Father",
                                              gender: 1,),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // Padding(padding: EdgeInsets.only(
                              //     left: 20.w,bottom: 190.h)),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: 160.w, top: 40.h),
                                child: CustomIconButton(
                                  onTap: () {
                                    Provider.of<FamilyTreeProvider>(
                                        context, listen: false)
                                        .addMember(false, 'Father', 1);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Addmember(defaultMale: true,
                                              isGenderFixed: true,
                                              relation: "Father",
                                              gender: 1,),
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
                              ),

                            ],


                            Positioned(

                                top: 0.1.sh,
                                //MediaQuery.of(context).size.height * 0.1.h,
                                left: 0.53.sw - 15.w,
                                //(MediaQuery.of(context).size.width * 0.5.w) - 15.w,
                                child: Icon(
                                  Icons.favorite, color: Color(0xFFF7B52C),
                                  size: 24.sp,)


                            ),
                            Positioned(
                                top: 0.148.sh,
                                //MediaQuery.of(context).size.height * 0.15.h,
                                left: 0.53.sw - (0.01.sw),

                                //(MediaQuery.of(context).size.width * 0.5.w) - 1.w,
                                child: CContainer(
                                  cwidth: 0.002.sw,
                                  cheight: 0.085.sh,
                                  //MediaQuery.of(context).size.height * 0.095,
                                )
                            ),

                            /// heart line
                            Positioned(
                                top: 0.245.sh,
                                //MediaQuery.of(context).size.height * 0.245,
                                left: 0.25.sw,
                                //(MediaQuery.of(context).size.width * 0.25),
                                child: CContainer(
                                  cheight: 0.001.sh,
                                  cwidth: (selected == false)
                                      ? (profiles.any((
                                      profile) => profile['relation'] == 6) ||
                                      profiles.any((
                                          profile) => profile['relation'] == 7)
                                      ? 0.61.sw
                                      : 0.538.sw)
                                  //(MediaQuery.of(context).size.width * 0.54) :
                                      : (isScrolledToEnd == false
                                      ? 0.8.sw
                                      : 0.468.sw),
                                  // (MediaQuery.of(context).size.width * 0.8):(MediaQuery.of(context).size.width * 0.4)


                                )),

                            ///above sibling
                            Positioned(
                                top: 0.245.sh,
                                //MediaQuery.of(context).size.height * 0.245,
                                left: 0.25.sw,
                                //(MediaQuery.of(context).size.width * 0.25),
                                child: CContainer(
                                  cheight: 0.51.sw,
                                  //(MediaQuery.of(context).size.width * 0.51),
                                  cwidth: 1,
                                )),

                            ///near sibling

                            ///first sibilng line
                            if (profiles.any((profile) =>
                            profile['relation'] == 6) ||
                                profiles.any((profile) =>
                                profile['relation'] == 7)) ...[
                              Positioned(
                                top: 0.585.sh + 1.h / 2 - 0.110.sh / 2,
                                // Center of the upper horizontal line
                                left: (0.01.sw + 0.5.sw) - 0.5,
                                // Center of the upper horizontal line
                                child: Container(
                                  width: 1,
                                  // Thickness of the vertical line
                                  height: 0.110.sh,
                                  // Height of the vertical line
                                  color: Color(0xFFF7B52C), // Line color
                                ),
                              ),
                            ],
                            // _buildNoChildren(context),
                            if (childsimages.length >= 2)
                              _buildHorizontalLine(),
                            if (childsimages.isEmpty) ...[
                              _buildNoChildren(context),
                            ] else
                              if (childsimages.length == 1) ...[
                                _buildSingleChild(),
                              ] else
                                if (childsimages.length == 2) ...[
                                  _buildTwoChildren(),
                                ] else
                                  ...[
                                    _buildMultipleChildren(),
                                  ],


                            if (childsimages.length > 2) ...[
                              if (!selectedc) ...[
                                Positioned(
                                    top: 0.64.sh,
                                    //MediaQuery.of(context).size.height * 0.245,
                                    left: 0.42.sw,
                                    //(MediaQuery.of(context).size.width * 0.4),
                                    child: CCContainer(
                                      cheight: 0.3.sw,
                                      //(MediaQuery.of(context).size.width * 0.3),
                                      cwidth: 1,
                                    )), Container(

                                ),
                                Positioned(
                                  top: 0.69.sh,
                                  //MediaQuery.of(context).size.height * 0.29,
                                  left: 0.4.sw - 48.w,
                                  //(MediaQuery.of(context).size.width * 0.4) - 48,
                                  child: DisplayChildren(
                                    imagehgt: 50.h,
                                    imagewdt: 58.w,
                                    imagebradius: 40.r,
                                    cthgt: 46.h,
                                    ctwdt: 120.w,
                                    imageUrl: childsimages[0],
                                    persongname: childnames[0],
                                    personrelation: "Child",
                                    isEditoraddmember: true,
                                    isDeleteMember: false,
                                    relationType: '',
                                    relation_id: 0, onDelete: (int ) {  },
                                  ),
                                ),


                                ///first child
                              ] else
                                ...[ Positioned(
                                  top: 0.69.sh,
                                  //MediaQuery.of(context).size.height * 0.29,
                                  left: 0.42.sw - 55.w,
                                  //(MediaQuery.of(context).size.width * 0.42) - 55,
                                  child: Container(
                                    color: Colors.transparent,
                                    height: 10.h,

                                    width: 10.w,
                                  ),
                                ),
                                ],
                            ],


                            ///child line
                            Positioned(
                                top: 0.53.sh,
                                //MediaQuery.of(context).size.height * 0.53,
                                left: 0.25.sw,
                                //(MediaQuery.of(context).size.width * 0.25),
                                child: CContainer(
                                  cheight: 1,
                                  cwidth:
                                  //(profiles.any((profile) => profile['relation'] == 6) ||
                                  //     profiles.any((profile) => profile['relation'] == 7))
                                  //     ? 0.0.sw
                                  (profiles.any((
                                      profile) => profile['relation'] == 3)
                                      ? 0.433.sw
                                      : 0.433.sw),
                                  //(MediaQuery.of(context).size.width * 0.5),
                                )),

                            /// me to spouse
                            //    selected == false ?


                            // Assuming profiles contains the necessary data


                            if (siblingimages.length > 2) ...[
                              if (!selected) ...[
                                Positioned(
                                    top: 0.245.sh,
                                    //MediaQuery.of(context).size.height * 0.245,
                                    left: 0.42.sw,
                                    //(MediaQuery.of(context).size.width * 0.4),
                                    child: CContainer(
                                      cheight: 0.3.sw,
                                      //(MediaQuery.of(context).size.width * 0.3),
                                      cwidth: 1,
                                    )),
                                Positioned(
                                  top: 0.29.sh,
                                  //MediaQuery.of(context).size.height * 0.29,
                                  left: 0.4.sw - 48.w,
                                  //(MediaQuery.of(context).size.width * 0.4) - 48,
                                  child: DisplaySibling(
                                    imagehgt: 50.h,
                                    imagewdt: 58.w,
                                    imagebradius: 40.r,
                                    cthgt: 46.h,
                                    ctwdt: 120.w,
                                    imageUrl: siblingimages[0],
                                    persongname: siblingnames[0],
                                    personrelation:"Sibling",
                                    //getRelationName(siblingRelations[0]),
                                    isEditoraddmember: true,
                                    isDeleteMember: false,
                                    relationType: '',
                                    relation_id: 0, onDelete: (int ) {  }, onEdit: () {  },
                                  ),
                                ),

                                ///first sibling
                              ] else
                                ...[Positioned(
                                  top: 0.29.sh,
                                  //MediaQuery.of(context).size.height * 0.29,
                                  left: 0.42.sw - 80.w,
                                  //(MediaQuery.of(context).size.width * 0.42) - 55,
                                  child: Container(
                                    color: Colors.transparent,
                                    height: 10.h,

                                    width: 10.w,
                                  ),
                                ),
                                ],
                            ],

                            if (siblingimages.length == 1)
                              Positioned(
                                top: 0.299.sh + 1.h / 2 - 0.110.sh / 2,
                                // Center of the upper horizontal line
                                left: (0.01.sw + 0.4.sw) - 0.5,
                                // Center of the upper horizontal line
                                child: Container(
                                  width: 1,
                                  // Thickness of the vertical line
                                  height: 0.05.sh,
                                  // Height of the vertical line
                                  color: Color(0xFFF7B52C), // Line color
                                ),
                              ),
                            //    _buildNoSiblings(context),
                            if (siblingimages.length == 1)
                              _buildSingleSibling(),
                            if (siblingimages.isEmpty ||
                                siblingnames.isEmpty) _buildNoSiblings(context),
                            if (siblingimages.length ==
                                1) _buildSingleSibling(),
                            // _buildNoSiblings(context),
                            if (siblingimages.length == 2) _buildTwoSiblings(),
                            if (siblingimages.length >
                                2) _buildMultipleSiblings(),


                            Positioned(
                              top: 0.47.sh,
                              left: 0.24.sw - 55.w,
                              child: FutureBuilder<Map<String, dynamic>>(
                                future: _profileFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(child: Text(
                                        'Error: ${snapshot.error}'));
                                  } else if (snapshot.hasData) {
                                    final profile = snapshot.data!;
                                    final profilePicUrl = profile['profile_pic'] ??
                                        ''; // Adjust based on API response structure
                                    print('Profile Pic URL: $profilePicUrl');

                                    return DisplaySibling(
                                      imagehgt: 50.h,
                                      imagewdt: 58.w,
                                      imagebradius: 40.r,
                                      cthgt: 46.h,
                                      ctwdt: 120.w,
                                      isEditoraddmember: false,
                                      isDeleteMember: false,
                                      imageUrl: profilePicUrl.isNotEmpty
                                          ? profilePicUrl
                                          : 'assets/images/user.png',
                                      persongname: 'Me',
                                      // Adjust based on API response structure
                                      personrelation: profile['relation'] ??
                                          '',
                                      relation_id: 0, onDelete: (int ) {  }, onEdit: () {  },// Adjust based on API response structure
                                    );
                                  } else {
                                    return Center(
                                        child: Text('No data available'));
                                  }
                                },
                              ),
                            ),


                            //                   //spouse
                            //

                          ],
                        );
                      } else {
                        return Center(child: Text('No data available'));
                      }
                    }


                )

            ),
          ],
        ),
      ),
    );
  }

  String getRelationName(int relationValue) {
    switch (relationValue) {
      case 1:
        return 'FATHER';
      case 2:
        return 'MOTHER';
      case 3:
        return 'SPOUSE';
      case 4:
        return 'BROTHER';
      case 5:
        return 'SISTER';
      case 6:
        return 'DAUGHTER';
      case 7:
        return 'SON';
      default:
        return 'UNKNOWN';
    }
  }

  Widget _buildHorizontalLine() {
    double lineWidth;
    if (selectedc == false) {
      lineWidth = 0.42.sw; // Default width when not selected
    } else {
      // Width calculation for when selected or scrolled
      lineWidth = iscScrolledToEnd
          ? 0.76.sw // Adjust this based on your requirement
          : (2.sw + scrollOffset); // Width when scrolled
    }
    return Positioned(
      top: 0.64.sh,
      left: selectedc == false
          ? 0.42.sw

          : iscScrolledToEnd == false
          ? 0.01.sw
          : 0.01.sw,

      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 0.001.sh,
        width: selectedc == false
            ? 0.42.sw
            : iscScrolledToEnd == false
            ? 2.sw + scrollOffset
            : 0.76.sw,
        child: CCContainer(
          cheight: 0.0002.sh,
          cwidth: double.infinity,
        ),
      ),
    );
  }

  Widget _buildNoChildren(BuildContext context) {
    Map<String, dynamic> _generateGenderProperties() {
      bool isMale = Random().nextBool();
      return {
        'relation': isMale ? 'Son' : 'Daughter',
        'gender': isMale ? 7 : 6,
        'isMale': isMale,
      };
    }

    return Stack(
      children: [
        Positioned(
          bottom: 160.h,
          right: 120.w,
          child: CustomOutlinedButton(
            width: 120.w,
            height: 45.h,
            text: "+Child",
            leftIcon: Container(
              margin: EdgeInsets.only(right: 0),
            ),
            alignment: Alignment.bottomCenter,
            onPressed: () {
              final familyTreeState = Provider.of<FamilyTreeProvider>(
                  context, listen: false);
              var genderProps = _generateGenderProperties();
              familyTreeState.addMember(
                  genderProps['isMale'], genderProps['relation'],
                  genderProps['gender']);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Addmember(

                        defaultMale: true,
                        isGenderFixed: false,relation: "Son",
                        gender: gender,
                      ),
                ),
              );
            },
          ),
        ),
        Positioned(
          top: 366.h, // Position of the vertical line
          right: 175.w, // Position of the vertical line
          child: Container(
            width: 1, // Width of the line
            height: 75.h, // Height of the line
            color: Colors.amber, // Line color
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 194.h, left: 3.w),
          child: CustomIconButton(
            onTap: () {
              final familyTreeState = Provider.of<FamilyTreeProvider>(
                  context, listen: false);
              var genderProps = _generateGenderProperties();
              familyTreeState.addMember(
                  genderProps['isMale'], genderProps['relation'],
                  genderProps['gender']);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Addmember(

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


  Widget _buildSingleChild() {
    Map<String, dynamic> _generateGenderProperties() {
      bool isMale = Random().nextBool();
      return {
        'relation': isMale ? 'Son' : 'Daughter',
        'gender': isMale ? 7 : 6,
        'isMale': isMale,
      };
    }
    if (childsimages.isNotEmpty && childnames.isNotEmpty) {
      return Stack(
          children: [
            Positioned(
              top: 0.62.sh,
              left: (0.01.sw + 0.31.sw) - 0.34,
              child: DisplayChildren(
                imagehgt: 50.h,
                imagewdt: 58.w,
                imagebradius: 40.r,
                cthgt: 46.h,
                ctwdt: 120.w,
                imageUrl: childsimages[0],
                persongname: childnames[0],
                personrelation: "Child",
                // isEditoraddmember: true,
                isDeleteMember: false,
                relationType: '',
                relation_id: 0, onDelete: (int ) {  },
              ),
            ),
            Positioned(
              bottom: 158.h,
              right: 1.w,
              child: CustomOutlinedButton(
                width: 115.w,
                height: 45.h,
                text: "+Child",
                leftIcon: Container(
                  margin: EdgeInsets.only(right: 0),
                ),
                alignment: Alignment.bottomCenter,
                onPressed: () {
                  final familyTreeState = Provider.of<FamilyTreeProvider>(
                      context, listen: false);
                  var genderProps = _generateGenderProperties();
                  familyTreeState.addMember(
                      genderProps['isMale'], genderProps['relation'],
                      genderProps['gender']);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Addmember(

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
              padding: EdgeInsets.only(bottom:198.h, left: 240.w),
              child: CustomIconButton(
                onTap: () {
                  final familyTreeState = Provider.of<FamilyTreeProvider>(
                      context, listen: false);
                  var genderProps = _generateGenderProperties();
                  familyTreeState.addMember(
                      genderProps['isMale'], genderProps['relation'],
                      genderProps['gender']);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Addmember(

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
          ]
      );
    }else {
      return _buildNoChildren(context);
    }
  }

  Widget _buildTwoChildren() {
    return Stack(
      children: [
        _buildHorizontalLine2(),
        _buildVerticalLine(0.66.sw - 55.w),
        _buildVerticalLine(0.22.sw - 25.w),
        _buildVerticalLine(0.9.sw - 25.w),
        _buildChild(0.69.sh, 0.5.sw - 55.w, childsimages[0], childnames[0]),
        _buildChild(0.69.sh, 0.15.sw - 55.w, childsimages[1], childnames[1]),
        _buildChildButton2(context, 0.69.sh, 0.99.sw - 55.w),
      ],
    );
  }
  Widget _buildHorizontalLine2() {
    return Positioned(
      top: 0.64.sh - 1.h, // Adjust the top value as needed to position it correctly above the vertical lines
      left: 0.301.sw - 55.w, // Start from the left position of the first child
      right: 0.17.sw,
      child: Container(
        width: 0.607.sw, // Adjust the width to span between the two vertical lines
        height: 1.h, // Height of the horizontal line
        color: Color(0xFFF7B52C),
      ),
    );
  }


  Widget _buildMultipleChildren() {
    return Positioned(
      top: 0.635.sh,
      left: selectedc == false ? 0.589.sw - 22.5.w : 0.01.sw - 10.5.w,
      child: selectedc == false
          ? Padding(
        padding: EdgeInsets.only(left: 0.063.sw),
        child: _buildChildListView(childsimages.length + 1),
      )
          : _buildExpandedChildListView(),
    );
  }

  Widget _buildVerticalLine(double left) {
    return Positioned(
      top: 0.64.sh,
      left: left,
      child: Container(
        height: 46.h,
        width: 1.w,
        color: Color(0xFFF7B52C),
      ),
    );
  }
  Widget _buildChildButton2(BuildContext context,double top, double left) {
    Map<String, dynamic> _generateGenderProperties() {
      bool isMale = Random().nextBool();
      return {
        'relation': isMale ? 'Son' : 'Daughter',
        'gender': isMale ? 7 : 6,
        'isMale': isMale,
      };
    }

    return Stack(
      children: [
        Positioned(
          top: top,
          bottom: 109.h,
          right: 3.w,
          // left: left + 120.w + 10.w,
          child: CustomOutlinedButton(
            width: 105.w,
            height: 45.h,
            text: "+Child",
            leftIcon: Container(
              margin: EdgeInsets.only(right: 0),
            ),
            alignment: Alignment.bottomCenter,
            onPressed: () {
              final familyTreeState = Provider.of<FamilyTreeProvider>(context, listen: false);
              var genderProps = _generateGenderProperties();
              familyTreeState.addMember(genderProps['isMale'], genderProps['relation'], genderProps['gender']);

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
          padding: EdgeInsets.only(bottom: 148.h, left: 250.w),
          child: CustomIconButton(
            onTap: () {
              final familyTreeState = Provider.of<FamilyTreeProvider>(context, listen: false);
              var genderProps = _generateGenderProperties();
              familyTreeState.addMember(genderProps['isMale'], genderProps['relation'], genderProps['gender']);

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

  Widget _buildChild(double top, double left, String imageUrl, String name) {
    return Positioned(
      top: top,
      left: left,
      child: DisplayChildren(
        imagehgt: 50.h,
        imagewdt: 58.w,
        imagebradius: 40.r,
        cthgt: 46.h,
        ctwdt: 120.w,
        imageUrl: imageUrl,
        persongname: name,
        personrelation: "Child",
        // isEditoraddmember: false,
        isDeleteMember: false,
        relationType: '',
        relation_id: 0, onDelete: (int ) {  },
      ),
    );
  }

  Widget _buildChildListView(int childCount) {
    double scrollOffset = _scrollController.hasClients ? _scrollController
        .offset : 0.0;

    var width = MediaQuery
        .of(context)
        .size
        .width
        .r;
    var count = 4;
    var widthFactor = .5.r;
    var childCount = 4;
    var childWidthFactor = 0.5.r;
    void change() {
      print("calling");
      setState(() {
        count = childsimages.length;
        widthFactor = 1.0.r;
      });
    }
    void changeChild() {
      setState(() {
        childCount = childsimages.length;
        childWidthFactor = 1.0.r;
      });
    }
    double itemWidth = 80.w; // Width of each child item
    double listWidth = childCount >= 3
        ? 480.w
        : (childsimages.length * itemWidth) + itemWidth;
    return Container(
      height: 80.h,
      width: 480.w,
      child: ListView.builder(
        controller: _cscrollController,
        scrollDirection: Axis.horizontal,
        itemCount: childCount >= 4 ? 5 : childsimages.length + 1,
        itemBuilder: (context, index) {
          if (index < childCount) {
            return index < childsimages.length
                ? _buildChildListItem(index)
                : SizedBox.shrink();
          } else {
            return _buildSeeMoreItem();
          }
        },
      ),
    );
  }


  Widget _buildExpandedChildListView() {
    return Container(
      height: 0.2.sh,
      width: 0.5.sh,
      child: ListView.builder(
          controller: _cscrollController,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: childsimages.length+1,
          itemBuilder: (BuildContext context, int index) {
            if (index < childsimages.length) {
              // Display sibling items
              return _buildExpandedChildItem(
                  childsimages[index], childnames[index]);
            }

            else {
              // Display the add siblings button at the end
              return Container(
                alignment: Alignment.center,
                width: 130.w,
                height: 125.h,
                //height: 120.h,// Adjust the width as needed
                child: _buildChildButton(context,),
              );
            }
          }
      ),
    );
  }
  Widget _buildChildButton(BuildContext context) {
    Map<String, dynamic> _generateGenderProperties() {
      bool isMale = Random().nextBool();
      return {
        'relation': isMale ? 'Son' : 'Daughter',
        'gender': isMale ? 7 : 6,
        'isMale': isMale,
      };
    }

    return Stack(
      children: [
        Positioned(
            top: 3.h,
            right: 65.w,
            child: Container(
              height: 45.h, // Height of the vertical line
              width: 1.w,
              color: Colors.amber,
            )),
        Positioned(
          bottom: 1.h,
          right: 10.w,
          child: CustomOutlinedButton(
            width: 115.w,
            height: 45.h,
            text: "+Child",
            leftIcon: Container(
              margin: EdgeInsets.only(right: 0),
            ),
            alignment: Alignment.bottomCenter,
            onPressed: () {
              final familyTreeState = Provider.of<FamilyTreeProvider>(context, listen: false);
              var genderProps = _generateGenderProperties();
              familyTreeState.addMember(genderProps['isMale'], genderProps['relation'], genderProps['gender']);

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
          padding: EdgeInsets.only(bottom: 40.h, left: 3.w),
          child: CustomIconButton(
            onTap: () {
              final familyTreeState = Provider.of<FamilyTreeProvider>(context, listen: false);
              var genderProps = _generateGenderProperties();
              familyTreeState.addMember(genderProps['isMale'], genderProps['relation'], genderProps['gender']);

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
  Widget _buildChildListItem(int index) {
    double scrollOffset = _scrollController.hasClients ? _scrollController
        .offset : 0.0;
    var width = MediaQuery
        .of(context)
        .size
        .width
        .r;
    var count = 4;
    var widthFactor = .5.r;
    var childCount = 4;
    var childWidthFactor = 0.5.r;
    void change() {
      print("calling");
      setState(() {
        count = siblingimages.length;
        widthFactor = 1.0.r;
      });
    }
    void changeChild() {
      setState(() {
        childCount = childsimages.length;
        childWidthFactor = 1.0.r;
      });
    }

    return InkWell(
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          selectedc = true; // Expand on click
        });
      },
      child: Align(
        widthFactor: childWidthFactor,
        child: DisplaySmallchildWidget(
          simagehgt: 40.h,
          simagewdt: 40.w,
          simagebradius: 20.r,
          childname: '',
          childimage: (childsimages[index]),
        ),
      ),
    );
  }


  Widget _buildSeeMoreItem() {
    double scrollOffset = _scrollController.hasClients ? _scrollController
        .offset : 0.0;
    var width = MediaQuery
        .of(context)
        .size
        .width
        .r;
    var count = 4;
    var widthFactor = .5.r;
    var childCount = 4;
    var childWidthFactor = 0.5.r;
    void change() {
      print("calling");
      setState(() {
        count = siblingimages.length;
        widthFactor = 1.0.r;
      });
    }
    void changeChild() {
      setState(() {
        childCount = childsimages.length;
        childWidthFactor = 1.0.r;
      });
    }
    return InkWell(
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          selectedc = true; // Expand on click
        });
      },
      child: Align(
        widthFactor: childWidthFactor,
        child: DisplaySmallchildWidget(
          simagehgt: 40.h,
          simagewdt: 40.w,
          simagebradius: 40.r,
          stext: "2 +",
          childname: '',
        ),
      ),
    );
  }

  Widget _buildExpandedChildItem(String imageUrl, String name) {
    return InkWell(
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          selectedc = false;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 2.0, right: 30),
        child: Container(
          height: 0.1.sh + 80.h,
          width: 120.w,
          child: Stack(
            children: [
              Positioned(
                top: 4.h,
                left: 55.w,
                child: CCContainer(
                  cwidth: 1,
                  cheight: 0.1.sh + 80.h,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: DisplayChildren(
                  imagehgt: 50.h,
                  imagewdt: 58.w,
                  imagebradius: 40.r,
                  cthgt: 46.h,
                  ctwdt: 120.w,
                  imageUrl: imageUrl,
                  persongname: name,
                  personrelation: "child",
                  // isEditoraddmember: false,
                  isDeleteMember: false,
                  relationType: '',
                  relation_id: 0, onDelete: (int ) {  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChildImages(List<String> images) {
    return Row(
      children: images.map((imagePath) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(imagePath),
        );
      }).toList(),
    );
  }


  Widget _buildNoSiblings(BuildContext context) {
    Map<String, dynamic> _generateGenderProperties() {
      bool isMale = Random().nextBool();
      return {
        'relation': isMale ? 'Sister' : 'Brother',
        'gender': isMale ? 5 : 4,
        'isMale': isMale,
      };
    }

    return Stack(
      children: [
        Positioned(
          top: 240.h,
          right: 27.w,
          child: CustomOutlinedButton(
            width: 117.w,
            height: 45.h,
            text: "+Siblings",
            margin: EdgeInsets.only(bottom: 12.h),
            leftIcon: Container(
              margin: EdgeInsets.only(right: 0),
            ),
            alignment: Alignment.centerRight,
            onPressed: () {
              final familyTreeState = Provider.of<FamilyTreeProvider>(
                  context, listen: false);
              var genderProps = _generateGenderProperties();
              familyTreeState.addMember(
                  genderProps['isMale'], genderProps['relation'],
                  genderProps['gender']);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Addmember(

                        defaultMale: true,
                        isGenderFixed: false,relation: "Brother",
                        gender: gender,
                      ),
                ),
              );
            },
          ),
        ),
        Positioned(
          top: 169.h, // Position of the vertical line
          right: 75.w, // Position of the vertical line
          child: Container(
            width: 1, // Width of the line
            height: 29.h, // Height of the line
            color: Colors.amber, // Line color
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 197.h,
            right: 60.w,
          ),

          child: CustomIconButton(
            onTap: () {
              final familyTreeState = Provider.of<FamilyTreeProvider>(
                  context, listen: false);
              var genderProps = _generateGenderProperties();
              familyTreeState.addMember(
                  genderProps['isMale'], genderProps['relation'],
                  genderProps['gender']);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Addmember(

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


  Widget _buildSingleSibling() {
    Map<String, dynamic> _generateGenderProperties() {
      bool isMale = Random().nextBool();
      return {
        'relation': isMale ? 'Sister' : 'Brother',
        'gender': isMale ? 5 : 4,
        'isMale': isMale,
      };
    }

    if (siblingimages.isNotEmpty && siblingnames.isNotEmpty) {
      return Stack(
          children: [
            Positioned(
              top: 0.27.sh,
              left: (0.01.sw + 0.25.sw) - 0.64,
              child: DisplaySibling(
                imagehgt: 50.h,
                imagewdt: 58.w,
                imagebradius: 40.r,
                cthgt: 46.h,
                ctwdt: 120.w,
                imageUrl: siblingimages[0],
                persongname: siblingnames[0],
                personrelation: "Sibling",
                // isEditoraddmember: false,
                isDeleteMember: false,
                relationType: '',
                relation_id: 0, onDelete: (int ) {  }, onEdit: () {  },
              ),
            ),
            Positioned(
              top: 242.h,
              right: 15.w,
              child: CustomOutlinedButton(
                width: 120.w,
                height: 45.h,
                text: "+Siblings",
                margin: EdgeInsets.only(bottom: 12.h),
                leftIcon: Container(
                  margin: EdgeInsets.only(right: 0),
                ),
                alignment: Alignment.centerRight,
                onPressed: () {
                  final familyTreeState = Provider.of<FamilyTreeProvider>(
                      context, listen: false);
                  var genderProps = _generateGenderProperties();
                  familyTreeState.addMember(
                      genderProps['isMale'], genderProps['relation'],
                      genderProps['gender']);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Addmember(

                            defaultMale: true,
                            isGenderFixed: false,relation: "Brother",
                            gender: gender,
                          ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: 170.h,
              right: 76.w,
              child: Container(
                width: 1.w,
                height: 30.h, // Adjust the height as needed
                color: Colors.amber, // Adjust the color as needed
              ),),
            Padding(
              padding: EdgeInsets.only(
                top: 198.h,
                right: 40.w,
              ),
              child: CustomIconButton(
                onTap: () {
                  final familyTreeState = Provider.of<FamilyTreeProvider>(
                      context, listen: false);
                  var genderProps = _generateGenderProperties();
                  familyTreeState.addMember(
                      genderProps['isMale'], genderProps['relation'],
                      genderProps['gender']);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Addmember(


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
          ]
      );
    } else {
      return _buildNoSiblings(context);
    }
  }


  Widget _buildTwoSiblings() {
    return Stack(
      children: [


        _buildVerticalLines(1.01.sw - 55.w),
        _buildVerticalLines(0.4.sw - 25.w),
        _buildSibling(0.29.sh, 0.88.sw - 55.w,
            siblingimages[0], siblingnames[0]),
        _buildSibling(0.29.sh, 0.65.sw - 55.w,
            siblingimages[1], siblingnames[1]),
        _buildVerticalLines(0.7.sw - 25.w),
        _buildSiblingsButton2(context)

      ],
    );
  }
  Widget _buildSiblingsButton2(BuildContext context) {
    Map<String, dynamic> _generateGenderProperties() {
      bool isMale = Random().nextBool();
      return {
        'relation': isMale ? 'Sister' : 'Brother',
        'gender': isMale ? 5 : 4,
        'isMale': isMale,
      };
    }

    return Stack(
      children: [
        Positioned(
          bottom: 385.h,
          left: 0.w,
          right: 180.w,
          child: CustomOutlinedButton(
            width: 117.w,
            height: 45.h,
            text: "+Siblings",
            margin: EdgeInsets.only(bottom: 12.h),
            leftIcon: Container(
              margin: EdgeInsets.only(left: 0),
            ),
            alignment: Alignment.centerRight,
            onPressed: () {
              final familyTreeState = Provider.of<FamilyTreeProvider>(context, listen: false);
              var genderProps = _generateGenderProperties();
              familyTreeState.addMember(genderProps['isMale'], genderProps['relation'], genderProps['gender']);

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
            top: 210.h,
            right: 195.w,
          ),
          child: CustomIconButton(
            onTap: () {
              final familyTreeState = Provider.of<FamilyTreeProvider>(context, listen: false);
              var genderProps = _generateGenderProperties();
              familyTreeState.addMember(genderProps['isMale'], genderProps['relation'], genderProps['gender']);

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
  // Adjust this value as needed
  // Positioned(
  //   top: 0.29.sh + 60.h, // Adjust to place properly after the second sibling
  //   left: 0.42.sw - 55.w, // Adjust as needed
  //child:
  // _buildNoSiblings(context),
  // ),

  Widget _buildMultipleSiblings() {
    double scrollOffset = _scrollController.hasClients ? _scrollController
        .offset : 0.0;
    var width = MediaQuery
        .of(context)
        .size
        .width
        .r;
    var count = 4;
    var widthFactor = .5.r;
    var childCount = 4;
    var childWidthFactor = 0.5.r;
    void change() {
      print("calling");
      setState(() {
        count = siblingimages.length;
        widthFactor = 1.0.r;
      });
    }

    return Positioned(
      top: 0.24.sh,
      left: selected == false ? 0.589.sw - 22.5.w : 0.5.sw - 80.5.w,
      child: Column(
        children: [
          selected == false
              ? Padding(
            padding: EdgeInsets.only(left: 0.063.sw),
            child: _buildSiblingListView(siblingimages.length + 1),
          )
              : _buildExpandedSiblingListView(),
          //  _buildSiblingsButton(context),
        ],
      ),
    );
  }

  Widget _buildVerticalLines(double left) {
    return Positioned(
      top: 0.245.sh,
      left: left,
      child: Container(
        height: 46.h,
        width: 1.w,
        color: Color(0xFFF7B52C),
      ),
    );
  }

  Widget _buildSibling(double top, double left, String imageUrl, String name) {
    Map<String, dynamic> _generateGenderProperties() {
      bool isMale = Random().nextBool();
      return {
        'relation': isMale ? 'Sister' : 'Brother',
        'gender': isMale ? 5 : 4,
        'isMale': isMale,
      };
    }
    double scrollOffset = _scrollController.hasClients ? _scrollController
        .offset : 0.0;
    var width = MediaQuery
        .of(context)
        .size
        .width
        .r;
    var count = 4;
    var widthFactor = .5.r;
    var childCount = 3;
    var childWidthFactor = 0.5.r;
    void change() {
      print("calling");
      setState(() {
        count = siblingimages.length;
        widthFactor = 1.0.r;
      });
    }
    return Stack(
      children: [
        Positioned(
          top: top,
          left: left,
          child: DisplaySibling(
            imagehgt: 50.h,
            imagewdt: 58.w,
            imagebradius: 40.r,
            cthgt: 46.h,
            ctwdt: 119.w,
            imageUrl: imageUrl,
            persongname: name,
            personrelation: "Sibling",
            isDeleteMember: false,
            relationType: '',
            relation_id: 0, onDelete: (int ) {  }, onEdit: () {  },
          ),
        ),
        //"+Siblings" Button


        //
      ],
    );
  }
  Widget _buildSiblingList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: siblingimages.length,
      itemBuilder: (context, index) {
        return _buildSibling(
          0.29.sh + (index * 60.h), // Adjust vertical spacing as needed
          0.98.sw - 55.w, // Adjust horizontal positioning as needed
          siblingimages[index],
          siblingnames[index],
        );
      },
    );
  }

  Widget _buildSiblingListView(int count) {
    var width = MediaQuery
        .of(context)
        .size
        .width
        .r;
    var count = 4;
    var widthFactor = .5.r;
    var childCount = 4;
    var childWidthFactor = 0.5.r;
    void change() {
      print("calling");
      setState(() {
        count = siblingimages.length;
        widthFactor = 1.0.r;
      });
    }

    double itemWidth = 80.w; // Width of each sibling item
    double listWidth = count >= 3
        ? 480.w
        : (siblingimages.length * itemWidth) + itemWidth;

    return Container(
      height: 80.h,
      width: listWidth,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: count >= 4 ? 5 : siblingimages.length + 1,
        itemBuilder: (context, index) {
          if (index < count) {
            return index < siblingimages.length
                ? _buildSiblingListItem(index)
                : SizedBox.shrink();
          } else {
            return _buildSeeMoreItems();
          }
        },
      ),
    );
  }


  Widget _buildExpandedSiblingListView() {
    Map<String, dynamic> _generateGenderProperties() {
      bool isMale = Random().nextBool();
      return {
        'relation': isMale ? 'Sister' : 'Brother',
        'gender': isMale ? 5 : 4,
        'isMale': isMale,
      };
    }
    double scrollOffset = _scrollController.hasClients ? _scrollController
        .offset : 0.0;
    var width = MediaQuery
        .of(context)
        .size
        .width
        .r;
    var count = 4;
    var widthFactor = .5.r;
    var childCount = 4;
    var childWidthFactor = 0.5.r;
    void change() {
      print("calling");
      setState(() {
        count = siblingimages.length;
        widthFactor = 1.0.r;
      });
    }
    return Container(
      height: 0.2.sh,
      width: 0.3.sh,
      child: ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: siblingimages.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < siblingimages.length) {
            // Display sibling items
            return _buildExpandedSiblingItem(
                siblingimages[index], siblingnames[index]);
          } else {
            // Display the add siblings button at the end
            return Container(
              alignment: Alignment.center,
              width: 125.w,
              height: 125.h,
              //height: 120.h,// Adjust the width as needed
              child: _buildSiblingsButton(context),
            );

            //   Container(
            //   alignment: Alignment.center,
            //   padding: EdgeInsets.only(left: 10.w),
            //   width: 150.w, // Adjust the width as needed
            //   child:
            //   _buildSiblingsButton(context),
            // );
          }
        },
      ),
    );
  }
  Widget _buildSiblingsButton(BuildContext context) {
    Map<String, dynamic> _generateGenderProperties() {
      bool isMale = Random().nextBool();
      return {
        'relation': isMale ? 'Sister' : 'Brother',
        'gender': isMale ? 5 : 4,
        'isMale': isMale,
      };
    }

    return Stack(
      children: [
        Positioned(
            top: 3.h,
            right: 65.w,
            child: Container(
              height: 45.h, // Height of the vertical line
              width: 1.w,
              color: Colors.amber,
            )),
        Positioned(
          top: 90.h,
          // bottom: 197.h,
          // right: 17.w,
          child: CustomOutlinedButton(
            width: 120.w,
            height: 40.h,
            text: "+Siblings",
            margin: EdgeInsets.only(bottom: 12.h),
            leftIcon: Container(
              margin: EdgeInsets.only(right: 0),
            ),
            alignment: Alignment.centerRight,
            onPressed: () {
              final familyTreeState = Provider.of<FamilyTreeProvider>(context, listen: false);
              var genderProps = _generateGenderProperties();
              familyTreeState.addMember(genderProps['isMale'], genderProps['relation'], genderProps['gender']);

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
            top: 45.h,
            right: 35.w,
          ),
          child: CustomIconButton(
            onTap: () {
              final familyTreeState = Provider.of<FamilyTreeProvider>(context, listen: false);
              var genderProps = _generateGenderProperties();
              familyTreeState.addMember(genderProps['isMale'], genderProps['relation'], genderProps['gender']);

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

  Widget _buildSiblingListItem(int index) {
    return InkWell(
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => Siblingfamtree(
      //         siblingImage: siblingimages[index],
      //         siblingName: siblingnames[index],
      //       ),
      //     ),
      //   );
      //   setState(() {
      //     selected = false;
      //   });
      // },
      child: Align(
        widthFactor: 0.5.r,
        child: DisplaySmallWidget(
          simagehgt: 40.h,
          simagewdt: 40.w,
          simagebradius: 20.r,
          sinblingimage: (siblingimages[index]),
          siblingname: '',
        ),
      ),
    );
  }


  Widget _buildSeeMoreItems() {
    return InkWell(
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          selected = true; // Expand on click
        });
      },
      child: Align(
        widthFactor: 0.5.r,
        child: DisplaySmallWidget(
          simagehgt: 40.h,
          simagewdt: 40.w,
          simagebradius: 40.r,
          stext: "2 +",
          siblingname: '',
        ),
      ),
    );
  }


  Widget _buildExpandedSiblingItem(String imageUrl, String name) {
    return Container(

      //height: 0.226.sh,
      //MediaQuery.of(context).size.height * 0.226,

        width: 0.25.sh,
        //    color: Colors.yellow,
        //MediaQuery.of(context).size.height * 0.3,/// show all frames

        child: InkWell(
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          // highlightColor: Colors.transparent,
          onTap: () {
            // Navigator.push(
            //   context
            //   // MaterialPageRoute(
            //   //   builder: (context) => Siblingfamtree(
            //   //     siblingImage: imageUrl, // Pass the imageUrl
            //   //     siblingName: name,       // Pass the name
            //   //   ),
            //   // ),
            // );
            // setState(() {
            //   selected = false; // Collapse the expanded item after navigating
            // });
          },
          child: Padding(
              padding: const EdgeInsets.only(left: 2.0, right: 30),
              child: Container(
                  height: 0.1.sh + 80.h,
                  width: 120.w,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 4.h,
                        left: 55.w,
                        child: CCContainer(
                          cwidth: 1,
                          cheight: 0.1.sh + 80.h,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: SingleChildScrollView(
                          child: DisplaySibling(
                            imagehgt: 50.h,
                            imagewdt: 58.w,
                            imagebradius: 40.r,
                            cthgt: 46.h,
                            ctwdt: 120.w,
                            imageUrl: imageUrl,
                            persongname: name,
                            personrelation: "Sibling",
                            //   isEditoraddmember: false,
                            isDeleteMember: false,
                            relationType: '',
                            relation_id: 0, onDelete: (int ) {  }, onEdit: () {  },
                          ),
                        ),
                      ),
                      // Positioned(
                      //   bottom: 0,
                      //   right: 0,
                      //   child: _buildSiblingsButton(context),
                      // ),

                    ],
                  )
              )
          ),
        )
    );
  }


}
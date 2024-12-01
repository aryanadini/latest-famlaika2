import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../apiservice/api_services.dart';
import '../../constants/DisplaySibling.dart';
import '../../constants/Displaychildren.dart';
import '../../constants/appbarConst.dart';
import '../addmember/addmember_view.dart';

class DeleteMember extends StatefulWidget {
  final Function onDelete;
  final String? userId;
  const DeleteMember({this.userId,required this.onDelete});

  @override
  State<DeleteMember> createState() => _DeleteMemberState();
}

class _DeleteMemberState extends State<DeleteMember> {

  // List<Map<String, dynamic>> membersList = [];
  int selectedIndex = -1;
  final ApiService apiService = ApiService();

  Future<List<Map<String, dynamic>>>? _familyTreeFuture;

  //List<Map<String, dynamic>> profiles = [];
  //List<Map<String, dynamic>> _familyMembers = [];
  List<Map<String, dynamic>> _profiles = [];
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
  List<int> childRelationIds = [];
  List<String> siblingnames = [
    "assets/images/img_listsibling2.png",
  ];

  List<String> siblingimages = [
    "Ancy Tom"
  ];
  List<int> siblingRelationIds = [];
  Future<List<Map<String, dynamic>>> _fetchFamilyTree() async {
    // Replace with your API call

    await Future.delayed(Duration(seconds: 2)); // Simulated delay
    return [
      {'relation': 6, 'profile_pic': 'assets/images/img_intersect_1.png', 'name': 'Child 1'},
      {'relation': 7, 'profile_pic': 'assets/images/img_intersect_2.png', 'name': 'Child 2'},
      {'relation': 4, 'profile_pic': 'assets/images/img_intersect_3.png', 'name': 'Sibling 1'},
      {'relation': 5, 'profile_pic': 'assets/images/img_intersect_4.png', 'name': 'Sibling 2'},
      // Add more profiles as needed
    ];
  }
  String currentMechImage="assets/images/img_me.png";
  String currentMechName="Current me";

  String? childimg;
  String? childnme;
  bool selectedc = false;
  ScrollController _cscrollController=ScrollController();
  bool iscScrolledToEnd=false;



  String currentMeImage="assets/images/img_me.png";
  String currentMeName="Current me";

  String? siblingimg;
  String? siblingnme;
  bool selected = false;
  ScrollController _scrollController=ScrollController();
  bool isScrolledToEnd=false;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    _familyTreeFuture = _fetchFamilyTree();
    _familyTreeFuture = apiService.fetchFamilyTree(userId: widget.userId);
    _profileFuture = ApiService().fetchProfile();

    //  familyMembersFuture = fetchFamilyTree(widget.userId);


    siblingimg = siblingimages[0];
    siblingnme = siblingnames[0];
    _scrollController.addListener(_scrollListener );
    childimg=childsimages[0];
    childnme=childnames[0];
    _cscrollController.addListener(_cscrollListener);
    _profileFuture = ApiService().fetchProfile();

  }

  void _scrollListener(){
    if (_scrollController.position.atEdge){
      bool isTop=_scrollController.position.pixels==0;
      if(!isTop){
        setState(() {
          isScrolledToEnd=true;
        });
      }
    }else{
      setState(() {
        isScrolledToEnd=false;
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
  void dispose(){
    _scrollController.dispose();

    _cscrollController.dispose();
    super.dispose();
  }
  // void _deleteMember(String userId) async {
  //   try {
  //     // Call your API to delete the member from the backend
  //     await apiService.fetchFamilyTree(userId); // Ensure this method exists and works
  //
  //     // Update the local state to remove the member from the family tree
  //     setState(() {
  //       // Assuming you have a way to find and remove the member from your profiles list
  //       _familyTreeFuture = _fetchFamilyTree(); // Refresh the family tree data
  //     });
  //   } catch (error) {
  //     // Handle error (e.g., show a Snackbar or dialog)
  //     print('Error deleting member: $error');
  //   }
  // }
  List<Map<String, dynamic>> _localProfiles = []; // Local copy for rendering



  // Future<void> _deleteLocalMember(Map<String, dynamic> profile) async {
  //   String requestId = profile['id'].toString(); // Assume 'id' holds the request ID
  //   int relationId = profile['relation']; // Get the relation_id from the profile
  //   try {
  //     // Make sure to call the API with the proper URL
  //     await ApiService.deleteRequest( relationId);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Member deleted successfully!')),
  //     );
  //     widget.onDelete();
  //     setState(() {
  //       _profiles.removeWhere((item) =>
  //       item['id'].toString() == requestId && item['relation'] == relationId);
  //       // Remove only the deleted member
  //      // _familyTreeFuture = _fetchFamilyTree(); // Refresh the family tree
  //     });
  //   } catch (e) {
  //     // Handle error, show message
  //     print('Error deleting member: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to delete member: $e')),
  //     );
  //   }
  // }

  Future<bool> onDelete(int relation_id) async {
    print('Attempting to delete member with ID: $relation_id');
    final bool result = await ApiService.deleteRequest(relation_id);
    print('Delete result: $result'); // This should show true or false
    return result;
  }
  void deleteProfile(int relation_id) async {
    if (!mounted) return;
    final bool result = await onDelete(relation_id);
    if (result) {
      setState(() {
        _profiles.removeWhere((profile) => profile['rid'] == relation_id);
      });
      // Check if the widget is still mounted
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Member successfully deleted from the family tree.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
    else {
      // Check if the widget is still mounted
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete member. Please try again.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );

    }
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width.r;
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
      appBar: CustomAppBar(title: "Delete Member"),
      body: SingleChildScrollView(
        child: Column(

          children: [
            SizedBox(height:12.h ,),
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
                        text: "Click on the member space for remove the ",
                        style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16.sp,fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: "member.",
                        style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16.sp,height: 1.36.h,fontWeight: FontWeight.w400),
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
                height:  1.sh,
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
                      } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        List<Map<String, dynamic>> _profiles = snapshot.data!;

                        childsimages.clear();
                        childnames.clear();
                        childRelationIds.clear();
                        siblingimages.clear();
                        siblingnames.clear();
                        siblingRelationIds.clear();

                        for (var profile in _profiles) {
                          if (profile['relation'] == 6 || profile['relation'] == 7) {
                            // Use 'profile_pic' for image and 'name' for child's name
                            childsimages.add(profile['profile_pic'] ?? ''); // Add image, default to empty if null
                            childnames.add(profile['name'] ?? ''); // Add name, default to empty if null
                            childnames.add(profile['name'] ?? '');
                            childRelationIds.add(profile['rid'] ??'');
                            // Add name, default to empty if null
                          }
                          else if (profile['relation'] == 4 || profile['relation'] == 5) {
                            // Use 'profile_pic' for image and 'name' for sibling's name
                            siblingimages.add(profile['profile_pic'] ?? ''); // Add image, default to empty if null
                            siblingnames.add(profile['name'] ?? ''); // Add name, default to empty if null
                            siblingnames.add(profile['name'] ?? '');
                            siblingRelationIds.add(profile['rid'] ?? '');// Add name, default to empty if null
                          }
                        }



                        return Stack(
                          children: [

                            for (var profile in _profiles)
                              if (profile['relation'] == 1)

                                Positioned(
                                  top: 0.04.sh,
                                  //MediaQuery.of(context).size.height * 0.04,
                                  left: 0.25.sw -55.w,
                                  //(MediaQuery.of(context).size.width * 0.25) - 55,
                                  child: DisplaySibling(
                                    imagehgt: 50.h,
                                    imagewdt: 58.w,
                                    imagebradius: 40.r,
                                    cthgt: 46.h,
                                    ctwdt: 120.w,
                                    isEditoraddmember: false,
                                    isDeleteMember: true,
                                    imageUrl: profile['profile_pic'] ?? 'assets/images/img_intersect_3.png',
                                    persongname: profile['name'] ?? 'Unknown',
                                    personrelation: getRelationName(profile['relation']),
                                    gender: profile['gender'] ?? 3,
                                    mobileNumber: profile['mobile'] ?? '',
                                    dateOfBirth: profile['date_of_birth'] ?? '',
                                    relation_id: profile['rid'] ?? '',
                                    onDelete: deleteProfile, onEdit: () {  },


                                  ),
                                )



                              // father
                              else if (profile['relation'] == 2)

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
                                      isEditoraddmember: false,
                                      isDeleteMember: true,
                                      imageUrl: profile['profile_pic'] ,
                                      persongname:profile['name'] ?? 'name',
                                      personrelation: getRelationName(profile['relation']),
                                      gender: profile['gender'] ?? 3,
                                      mobileNumber: profile['mobile_number'] ?? '',
                                      dateOfBirth: profile['date_of_birth'] ?? '',
                                      relation_id: profile['rid'] ?? '',
                                      onDelete: onDelete, onEdit: () {  },
                                  ),
                                )


                              else if (profile['relation'] == 3)

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
                                        isEditoraddmember: false,
                                        isDeleteMember: true,
                                        imageUrl: profile['profile_pic'] ,
                                        persongname:profile['name'] ?? 'name',
                                        relationType: 'Spouse',
                                        personrelation: getRelationName(profile['relation']),
                                        gender:profile['gender'] ?? 3 ,
                                        mobileNumber: profile['mobile_number'] ?? '',
                                        dateOfBirth: profile['date_of_birth'] ?? '',
                                       // relation_id: 0, onDelete: (int ) {  },
                                        relation_id: profile['rid'] ?? '',
                                        onDelete: onDelete, onEdit: () {  },

                                    ),
                                  ),


                            Positioned(

                                top: 0.1.sh,
                                //MediaQuery.of(context).size.height * 0.1.h,
                                left: 0.53.sw-15.w,
                                //(MediaQuery.of(context).size.width * 0.5.w) - 15.w,
                                child: Icon(Icons.favorite,color: Color(0xFFF7B52C),size: 24.sp,)


                            ),
                            Positioned(
                                top:0.148.sh,
                                //MediaQuery.of(context).size.height * 0.15.h,
                                left: 0.53.sw-(0.01.sw),

                                //(MediaQuery.of(context).size.width * 0.5.w) - 1.w,
                                child: CContainer(
                                  cwidth:0.002.sw,
                                  cheight: 0.085.sh,
                                  //MediaQuery.of(context).size.height * 0.095,
                                )
                            ), /// heart line
                            Positioned(
                                top: 0.245.sh,
                                //MediaQuery.of(context).size.height * 0.245,
                                left:0.25.sw,
                                //(MediaQuery.of(context).size.width * 0.25),
                                child: CContainer(
                                  cheight: 0.001.sh,
                                  cwidth: (selected == false)
                                      ? (_profiles.any((profile) => profile['relation'] == 6) || _profiles.any((profile) => profile['relation'] == 7)
                                      ? 0.538.sw
                                      : 0.275.sw)
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
                            if (_profiles.any((profile) => profile['relation'] == 6) ||
                                _profiles.any((profile) => profile['relation'] == 7)) ...[
                              Positioned(
                                top: 0.585.sh + 1.h / 2 - 0.110.sh / 2, // Center of the upper horizontal line
                                left: (0.01.sw + 0.5.sw) - 0.5, // Center of the upper horizontal line
                                child: Container(
                                  width: 1, // Thickness of the vertical line
                                  height: 0.110.sh, // Height of the vertical line
                                  color: Color(0xFFF7B52C), // Line color
                                ),
                              ),],
                            if (childsimages.length >= 2)
                              _buildHorizontalLine(),
                            if (childsimages.isEmpty) ...[
                              _buildNoChildren(),
                            ] else if (childsimages.length == 1) ...[
                              _buildSingleChild(),
                            ] else if (childsimages.length == 2) ...[
                              _buildTwoChildren(),
                            ] else ...[
                              _buildMultipleChildren(),
                            ],


                            if (childsimages.length > 2) ...[
                              if (!selectedc) ...[
                                Positioned(
                                    top:0.64.sh,
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
                                  left: 0.4.sw-48.w,
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
                                    isEditoraddmember: false,
                                    isDeleteMember: true, relationType: '',


                                    relation_id: childRelationIds[0], // Ensuring relation_id is an int
                                    onDelete: onDelete,

                                  ),
                                ),


                                ///first child
                              ] else ...[ Positioned(
                                top:0.69.sh,
                                //MediaQuery.of(context).size.height * 0.29,
                                left:0.42.sw - 55.w,
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
                                  (_profiles.any((profile) => profile['relation'] == 3)
                                      ? 0.433.sw
                                      : 0.26.sw),
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
                                  left: 0.4.sw-48.w,
                                  //(MediaQuery.of(context).size.width * 0.4) - 48,
                                  child: DisplaySibling(
                                    imagehgt: 50.h,
                                    imagewdt: 58.w,
                                    imagebradius: 40.r,
                                    cthgt: 46.h,
                                    ctwdt: 120.w,
                                    imageUrl: siblingimages[0],
                                    persongname: siblingnames[0],
                                    personrelation: "Sibling",
                                    isEditoraddmember: false,
                                    isDeleteMember: true, relationType: '',
                                   // relation_id: 0, onDelete: (int ) {  },
                                    relation_id: siblingRelationIds[0], // Ensuring relation_id is an int
                                    onDelete: onDelete, onEdit: () {  },

                                  ),
                                ),///first sibling
                              ] else ...[Positioned(
                                top:0.29.sh,
                                //MediaQuery.of(context).size.height * 0.29,
                                left:0.42.sw - 80.w,
                                //(MediaQuery.of(context).size.width * 0.42) - 55,
                                child: Container(
                                  color: Colors.transparent,
                                  height: 10.h,

                                  width: 10.w,
                                ),
                              ),
                              ],
                            ],

                            if (siblingimages.length==1)
                              Positioned(
                                top: 0.299.sh + 1.h / 2 - 0.110.sh / 2, // Center of the upper horizontal line
                                left: (0.01.sw + 0.83.sw) - 0.5, // Center of the upper horizontal line
                                child: Container(
                                  width: 1, // Thickness of the vertical line
                                  height: 0.110.sh, // Height of the vertical line
                                  color: Color(0xFFF7B52C), // Line color
                                ),
                              ),
                            if (siblingimages.length==1)
                              _buildSingleSibling(),
                            if (siblingimages.isEmpty || siblingnames.isEmpty) _buildNoSiblings(),
                            if (siblingimages.length == 1) _buildSingleSibling(),
                            if (siblingimages.length == 2) _buildTwoSiblings(),
                            if (siblingimages.length > 2) _buildMultipleSiblings(),


                            Positioned(
                              top: 0.47.sh,
                              left: 0.24.sw - 55.w,
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

                                    return DisplaySibling(
                                      imagehgt: 50.h,
                                      imagewdt: 58.w,
                                      imagebradius: 40.r,
                                      cthgt: 46.h,
                                      ctwdt: 120.w,
                                      isEditoraddmember: false,
                                      isDeleteMember: false,
                                      imageUrl: profilePicUrl.isNotEmpty ? profilePicUrl : 'assets/images/user.png',
                                      persongname: 'Me', // Adjust based on API response structure
                                      personrelation: profile['relation'] ?? '',
                                    //relation_id: 0, onDelete: (int ) {  },// Adjust based on API response structure
                                      relation_id: 0, // Ensuring relation_id is an int
                                      onDelete: onDelete, onEdit: () {  },
// Adjust based on API response structure
                                    );
                                  } else {
                                    return Center(child: Text('No data available'));
                                  }
                                },
                              ),
                            ),


                            //                   //spouse
                            //

                          ],
                        );



                      }else{
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

  Widget _buildNoChildren() {
    return Container(); // Or some placeholder if needed
  }

  Widget _buildSingleChild() {
    return Positioned(
      top: 0.62.sh,
      left: (0.01.sw + 0.34.sw) - 0.34,
      child: DisplayChildren(
        imagehgt: 50.h,
        imagewdt: 58.w,
        imagebradius: 40.r,
        cthgt: 46.h,
        ctwdt: 120.w,
        imageUrl: childsimages[0],
        persongname: childnames[0],
        personrelation: "Child",
        isEditoraddmember: false,
        isDeleteMember: true,
        relationType: '',

        relation_id:childRelationIds[0], // Ensuring relation_id is an int
        onDelete: onDelete,
      ),
    );
  }

  Widget _buildTwoChildren() {
    return Stack(
      children: [
        _buildVerticalLine(0.99.sw - 55.w),
        _buildVerticalLine(0.489.sw - 25.w),
        _buildChild(0.69.sh, 0.78.sw - 55.w, childsimages[0], childnames[0]),
        _buildChild(0.69.sh, 0.38.sw - 55.w, childsimages[1], childnames[1]),
      ],
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
        isEditoraddmember: false,
        isDeleteMember: true,
        relationType: '',

        relation_id:childRelationIds[0],// Correctly use i here
        onDelete: onDelete,
      ),
    );
  }
  Widget _buildChildListView(int childCount) {
    double scrollOffset = _scrollController.hasClients ? _scrollController.offset : 0.0;

    var width = MediaQuery
        .of(context)
        .size
        .width.r;
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
        itemCount:childCount >= 4 ?5 : childsimages.length + 1,
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
        itemCount: childsimages.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildExpandedChildItem(childsimages[index], childnames[index]);
        },
      ),
    );
  }
  Widget _buildChildListItem(int index) {

    double scrollOffset = _scrollController.hasClients ? _scrollController.offset : 0.0;
    var width = MediaQuery
        .of(context)
        .size
        .width.r;
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
    double scrollOffset = _scrollController.hasClients ? _scrollController.offset : 0.0;
    var width = MediaQuery
        .of(context)
        .size
        .width.r;
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
                  isEditoraddmember: false,
                  isDeleteMember: true,
                  relationType: '',

                  relation_id: childRelationIds[0], // Correctly use i here
                  onDelete: onDelete,
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


  Widget _buildNoSiblings() {
    return Container(

    ); // Display nothing or add a placeholder if needed
  }


  Widget _buildSingleSibling() {


    if (siblingimages.isNotEmpty && siblingnames.isNotEmpty) {
      return Positioned(
        top: 0.29.sh,
        left: (0.01.sw + 0.64.sw) - 0.64,
        child: DisplaySibling(
          imagehgt: 50.h,
          imagewdt: 58.w,
          imagebradius: 40.r,
          cthgt: 46.h,
          ctwdt: 120.w,
          imageUrl: siblingimages[0],
          persongname: siblingnames[0],
          personrelation: "Sibling",
          isEditoraddmember: false,
          isDeleteMember: true,
          relationType: '',
          //relation_id: 0, onDelete: (int ) {  },
          relation_id:siblingRelationIds[0], // Correctly use i here
          onDelete: onDelete, onEdit: () {  },

        ),
      );
    }else {
      return _buildNoSiblings();
    }
  }


  Widget _buildTwoSiblings() {
    return Stack(
      children: [
        _buildVerticalLines(0.99.sw - 55.w),
        _buildVerticalLines(0.489.sw - 25.w),
        _buildSibling(0.29.sh, 0.8.sw - 55.w,
            siblingimages[0], siblingnames[0]),
        _buildSibling(0.29.sh, 0.42.sw - 55.w,
            siblingimages[1], siblingnames[1]),
      ],
    );
  }
  Widget _buildMultipleSiblings() {
    double scrollOffset = _scrollController.hasClients ? _scrollController.offset : 0.0;
    var width = MediaQuery
        .of(context)
        .size
        .width.r;
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
      child: selected == false
          ? Padding(
        padding: EdgeInsets.only(left: 0.063.sw),
        child: _buildSiblingListView(siblingimages.length + 1),
      )
          : _buildExpandedSiblingListView(),
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
    double scrollOffset = _scrollController.hasClients ? _scrollController.offset : 0.0;
    var width = MediaQuery
        .of(context)
        .size
        .width.r;
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
      top: top,
      left: left,
      child: DisplaySibling(
        imagehgt: 50.h,
        imagewdt: 58.w,
        imagebradius: 40.r,
        cthgt: 46.h,
        ctwdt: 120.w,
        imageUrl: imageUrl,
        persongname: name,
        personrelation: "Sibling",
        isEditoraddmember: false,
        isDeleteMember: true,
        relationType: '',

        relation_id: siblingRelationIds[0], // Correctly use i here
        onDelete: onDelete, onEdit: () {  },

      ),
    );
  }
  Widget _buildSiblingListView(int count) {
    var width = MediaQuery
        .of(context)
        .size
        .width.r;
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
    double scrollOffset = _scrollController.hasClients ? _scrollController.offset : 0.0;
    var width = MediaQuery
        .of(context)
        .size
        .width.r;
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
      width: 0.385.sh,
      child: ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: siblingimages.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildExpandedSiblingItem(siblingimages[index],
              siblingnames[index]);
        },
      ),
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
                            isEditoraddmember: false,
                            isDeleteMember: true,
                            relationType: '',

                            relation_id: siblingRelationIds[0], // Correctly use i here
                            onDelete: onDelete, onEdit: () {  },
                          ),
                        ),
                      ),
                    ],
                  )
              )
          ),
        )
    );
  }



}
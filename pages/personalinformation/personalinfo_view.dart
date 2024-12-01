import 'dart:convert';
import 'dart:developer';

import 'package:famlaika1/pages/skeletontree/famtree_view.dart';
import 'package:http/http.dart' as http;
import 'package:famlaika1/widgets/GradientButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../apiservice/api_services.dart';
import '../../apiservice/auth_service.dart';
import '../../constants/appbarConst.dart';

import 'dart:io';

import '../login_request/login_view.dart';
import 'PersonalInfoProvider.dart';

class Personalinfo extends StatefulWidget {
  final String accessToken;

  const Personalinfo({required this.accessToken});

  @override
  State<Personalinfo> createState() => _PersonalinfoState();
}

class _PersonalinfoState extends State<Personalinfo> {

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final ApiService _apiService = ApiService();
  String accessToken = "accessToken";

  File? _image;
  final ImagePicker _picker = ImagePicker();

  // final ApiService _apiService = ApiService();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _uploadProfilePhoto(); // Call the upload method
    }
  }

  Future<void> _uploadProfilePhoto() async {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    final imageFile = profileProvider.image;
    if (imageFile == null) {
      print('No image selected.');
      return;
    }

    try {
      print('Uploading image...');
     await _apiService.uploadProfilePhoto(imageFile);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile photo updated successfully.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile photo: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _pickImageFromGallery() async {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileProvider.pickImage(File(pickedFile.path)); // Set the selected image
      await _uploadProfilePhoto(); // Call the upload function after selecting the image
    }
  }

  Future<void> _pickImageFromCamera() async {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        profileProvider.pickImage(File(pickedFile.path));
      } else {
        // Optionally handle the case where no image was picked
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No image selected.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      print('Error picking image from camera: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _submitProfile(BuildContext context) async {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    String fullName = profileProvider.fullNameController.text.trim();
    String gender = female ? '2' : '1';
    String dateOfBirth = dateController.text.trim();
    print('Full Name: $fullName');
    print('Gender: $gender');
    bool success = await _apiService.updateProfile(
      fullName,
      gender,
      dateOfBirth,
      accessToken: accessToken, // Pass the access token
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2), // Duration for how long the Snackbar is visible
        ),
      );

      print('Profile updated successfully.');
      // Navigate to the next page if profile update is successful
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Famtree()), // Replace NextPage with your target page
      );
    } else {
      // Handle the case when profile update fails
      // Show a dialog or message to the user to re-authenticate
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile. Please re-authenticate.')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()), // Replace LoginPage with your login page
      );
      // Optionally, navigate the user back to the login screen

    }
  }







  bool female = true;
  late Color mcolor;
  Color fcolor = Colors.grey;

  TextEditingController dateinput = TextEditingController();
  //TextEditingController dateController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String name = "";

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }








  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return
    Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade900,
      appBar:CustomAppBar(title: 'Personal Information', ),

      body: Container(

    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width * double.maxFinite,
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
    text: 'Entering your personal details and setting up ',
    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16.sp,fontWeight: FontWeight.w400),
    ),
    TextSpan(
    text: 'your profile',
    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16.sp,height: 1.36.h,fontWeight: FontWeight.w400),
    ),
    ]
    )),

    ),

    ),

    Stack(
    children: [

    GestureDetector(

    onTap: _pickImageFromGallery,

    child: Container(
    width: 130.r,
    height: 130.r,
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(
    color: profileProvider.image != null
        ? Color(0xFFF7B52C)
        : Color(0xFF2B2B2B),
    width: 2.0,
    )
    ),

    child: CircleAvatar(
    radius: 65.r, // CircleAvatar radius
    backgroundColor: Color(0xFF2B2B2B),
    backgroundImage: profileProvider.image != null
        ? FileImage(profileProvider.image!)
        : null,

    child:profileProvider.image == null
    ? Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Image.asset("assets/images/uploagimgperson.png",width: 42.w,),
    // Icon(
    //   Icons.person,
    //   size: 55.sp, // Icon size
    //   color: Color(0xFF737272),
    // ),

    TextButton(

    onPressed: (){
    _pickImageFromGallery;
    },
    //_pickImageFromGallery,
    child: Text(
    "Upload Photo",
    style: TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.white,
    fontSize: 12.sp, // Text size
    ),
    ),

    ),
    ],
    )
        : null,
    ),
    ),
    ),
    Positioned(
    top: 90.h, // Position below the CircleAvatar
    right: 12.w, // Align to the right of CircleAvatar
    child: Container(

    height: 30.h, // Container height
    width: 30.w, // Container width
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: Color(0xFFF7B52C),
    ),

    child: Center(
    child: SizedBox(
    height: 30.h,
    width: 30.w,
    child: IconButton(
    padding: EdgeInsets.all(0),

    icon: Icon(
    Icons.camera_alt_outlined,
    color: Colors.white,
    size: 20.sp, // Icon size
    ),
    onPressed: _pickImageFromCamera,
    ),
    ),
    ),
    ),
    ),
    ],
    ),


    Padding(
    padding: const EdgeInsets.all(20.0).r,
    child: Container(
    height: 270.h,
    width: 340.w,
    color: Color(0xFF2B2B2B),
    child: Padding(
    padding: const EdgeInsets.all(8.0).r,
    child: Column(

    children: [

    Padding(
    padding: EdgeInsets.only(left: 10,).r,
    child: Align(
    alignment: Alignment.topLeft,
    child: Text(
    "Gender",
    style: TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: 'Figtree',
    color: Color(0xFFFFFFFF),
    ),
    ),
    ),
    ),

    Container(

    margin: EdgeInsets.all(1).r,
    child: Column(
    children: [
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Expanded(
    child: InkWell(
    onTap: () {
    female = true;
    setState(() {});
    },
    child: Container(
    padding: EdgeInsets.all(10.r),
    margin: EdgeInsets.all(10.r),
    decoration: BoxDecoration(
    border: Border.all(color: profileProvider.isFemale
        ? Colors.amber
        : Colors.grey.shade800),
    borderRadius: BorderRadius.circular(5.r),

    color:profileProvider.isFemale
        ? Colors.amber.withOpacity(0.1)
        : Colors.black.withOpacity(0.1),
    ),
    child: Row(
    children: [
    SizedBox(width: 2.w,),
    CircleAvatar(
    backgroundColor:Colors.black.withOpacity(0.1) ,
    child:
    Image.asset("assets/images/femalegender.png",
      color: profileProvider.isFemale
          ? Colors.amber
          : Colors.grey,
    ),
    // Icon(
    //   Icons.person_2_rounded,
    //   size: 20.sp,
    //   color: female ? Colors.amber : Colors.grey,
    // ),
    ),
    SizedBox(width: 5.w,),
    Text(
    ' Female',
    textScaleFactor: 1.2.sp,
    style: TextStyle(
    fontFamily: 'Figtree',
    fontSize: 12.sp,
    color: profileProvider.isFemale ?Colors.white
        :Colors.grey,
    ),
    ),
    ],
    ),
    ),
    ),
    ),
    Expanded(
    child: InkWell(
    onTap: () {
      profileProvider.setGender(false);
    },
    child: Container(
    padding: EdgeInsets.all(10.r),
    margin: EdgeInsets.all(10.r),
    decoration: BoxDecoration(
    border: Border.all( color: profileProvider.isFemale
        ? Colors.grey.shade800
        : Colors.amber),
    borderRadius: BorderRadius.circular(5.r),
      color:  profileProvider.isFemale
            ? Colors.black.withOpacity(0.1)
            : Colors.amber.withOpacity(0.1)
    ),
    child: Row(
    children: [
    SizedBox(width: 10.w,),
    CircleAvatar(
    backgroundColor:Colors.black.withOpacity(0.1),
    child: Image.asset("assets/images/malegender.png",color: female ? Colors.grey : Colors.amber)),
    // Icon(
    //   CupertinoIcons.person_alt_circle,
    //   size: 40.sp,
    //   color: female ? Colors.grey : Colors.amber,
    // ),
    SizedBox(width: 7.w,),
    Text(
    'Male',
    textScaleFactor: 1.2.sp,
    style: TextStyle(
    fontSize: 12.sp,
    fontFamily: 'Figtree',
      color: profileProvider.isFemale
          ? Colors.grey
          : Colors.white,
    ),
    ),
    ],
    ),
    ),
    ),
    ),
    ],
    ),
    Align(
    alignment: Alignment.topLeft,
    child: Padding(
    padding: const EdgeInsets.all(8.0).r,
    child: Text(
    "Full Name",
    style: TextStyle(
    fontWeight: FontWeight.w400,
    color: Color(0xFFFFFFFF),
    fontFamily: 'Figtree',
    fontSize: 14.sp,
    ),
    ),
    ),
    ),
    SizedBox(
    height: 40.h,
    width: 300.w,
    child: TextField(
    controller:profileProvider.fullNameController,
    style: TextStyle(
    color: Color(0xFFFFFFFF),
    fontFamily: 'Figtree',
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    ),
    decoration: InputDecoration(
    label: Text("Enter full name",style: TextStyle(color: Color(0xFF4E4C4C),fontSize: 12.sp),),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10).r,
    borderSide: BorderSide.none,
    ),
    fillColor: Colors.black.withOpacity(0.1),
    filled: true,
    ),
    ),
    ),
    Align(
    alignment: Alignment.topLeft,
    child: Padding(
    padding: const EdgeInsets.all(8.0).r,
    child: Row(
    children: [

    Text(
    "Date of Birth",
    style: TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: 'figtree',
    color: Color(0xFFFFFFFF),
    fontSize: 14.sp,
    ),
    ),
    SizedBox(width: 5.w,),
    Text("(optional)", style: TextStyle(fontSize: 12,color: Color(0xFF4E4C4C)),)
    ],
    ),
    ),
    ),
    SizedBox(
    height: 40.h,
    width: 300.w,
    child: TextField(
    style: TextStyle(
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    fontFamily: 'Figtree',
    ),
    controller:profileProvider. dateController,
    decoration: InputDecoration(
    label: Text("DD/MM/YYYY",style: TextStyle(fontSize: 12,color: Color(0xFF4E4C4C)),),
    suffixIcon: Image.asset("assets/images/calender.png",),
    // Icon(
    //   Icons.calendar,
    //   color: Color(0xFFFFFFFF),
    // ),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10).r,
    borderSide: BorderSide.none,

    ),
    fillColor: Colors.black.withOpacity(0.1),
    filled: true,
    ),
    readOnly: true,
    onTap: () async {
    DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1960),
    lastDate: DateTime(2124),
    builder: (BuildContext context, Widget? child){
    return Theme(data: ThemeData.light().copyWith(
    primaryColor: Color(0xFFF7B52C),
    hintColor: Color(0xFF4E4C4C),
    colorScheme: ColorScheme.light(
    primary: Color(0xFFF7B52C),
    surface: Color(0xFFF7B52C),
    onSurface: Color(0xFF4E4C4C),
    ),
    dialogBackgroundColor: Colors.white,
    textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
    primary: Color(0xFF4E4C4C),
    )
    )
    ), child: child!,);
    }

    );
    if (pickedDate != null) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
    profileProvider.updateDate(
      formattedDate.toString().split(' ')[0],
    );
    }
    },
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    ),
    ),
    SizedBox(height: 10.h),
    profileProvider.isLoading
        ? CircularProgressIndicator()
    : Container(
    height: 40.h,
    width: 325.w,
    decoration: BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.circular(20).r,
    ),

    child: GradientButton(

    // color: Color(0xFFF7B52C),
    onPressed: () => _submitProfile(context),
    //     () {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => Famtree()));
    // },
    child: Text(
    'Continue',
    style: TextStyle(
    fontFamily: 'Figtree',
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
    color: Color(0xFF1E1E1E),
    ),
    ),
    ),
    ),
    ],
    ),
    )
    );

  }

}
import 'dart:io';
import 'package:famlaika1/constants/appbarConst.dart';
import 'package:famlaika1/constants/bottom.dart';
import 'package:famlaika1/pages/homefamilytree/homesub/home2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../../apiservice/api_services.dart';
import '../../widgets/GradientButton.dart';
import 'MemberProvider.dart';


class Addmember extends StatefulWidget {
  final String? profilePic;
  final String? name;
  final String? mobileNumber;
  final String? dateOfBirth;
  final String relation;
  final int gender;
  final bool defaultMale;
  final int? relationValue;
  //inal bool isSibling;
  final bool isGenderFixed;
  const Addmember({super.key,required this.relation, required this.defaultMale,
    this.isGenderFixed = false,
    required this.gender,this.profilePic,this.name,
    this.mobileNumber,this.dateOfBirth,this.relationValue
    //required this.isSibling,
  });


  @override
  State<Addmember> createState() => _AddmemberState();
}

class _AddmemberState extends State<Addmember> {
  File? _image;
  String selectedRelation='';

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }


  late bool female;

  late Color mcolor;
  Color fcolor = Colors.grey;

  TextEditingController dateinput = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String dateOfBirth = '';
  String? imageUrl;
  final formKey = GlobalKey<FormState>();
  String? mobileNumber;
  String name = "";
  final TextEditingController _PhoneNumberController = TextEditingController();
  TextEditingController _FullNameController = TextEditingController();
  TextEditingController _RelationController = TextEditingController();
  final ApiService _apiService = ApiService();
  String accessToken = "accessToken";
  FocusNode focusNode = FocusNode();
  bool isSibling = false;
  @override
  void initState() {
    super.initState();
    _RelationController = TextEditingController();
    female = !widget.defaultMale;

    isSibling = (widget.relation == 'Brother' || widget.relation == 'Sister');
    _updateRelationOptions();
    _updateGender();
    dateinput.text = ""; // set the initial value of text field
   _RelationController.text = widget.relation;
    if (widget.relation == 'Brother') {
      selectedRelation = '4'; // Brother value
    } else if (widget.relation == 'Sister') {
      selectedRelation = '5'; // Sister value
    } else if (widget.relation == 'Son') {
      selectedRelation = '7'; // Son value
    } else if (widget.relation == 'Daughter') {
      selectedRelation = '6'; // Daughter value
    }


    print('Initializing Addmember with:');
    print('Name: ${widget.name}');
    print('Mobile Number: ${widget.mobileNumber}');
    print('Date of Birth: ${widget.dateOfBirth}');
    print('Gender: ${widget.gender}');
    print('Relation: ${widget.relation}');
    print('Profile Pic: ${widget.profilePic}');
    if (widget.name != null) {
      _FullNameController.text = widget.name!;
    }
    if (widget.mobileNumber != null) {
      _PhoneNumberController.text = widget.mobileNumber!;
    }
    if (widget.dateOfBirth != null) {
      dateController.text = widget.dateOfBirth!.toString().split(' ')[0];
      dateController.text = widget.dateOfBirth!;
    }
    female = widget.defaultMale ? false : true;
    imageUrl = widget.profilePic;
  }
  void _updateRelationOptions() {
    selectedRelation = '';
    isSibling = false;
    int relationValue = 0;
    // Check if gender is fixed
    if (widget.isGenderFixed) {
      if (widget.gender == 2) {
        // For Female
        selectedRelation = (widget.relation == 'Spouse') ? 'Spouse' : 'Mother';
      } else if (widget.gender == 1) {
        // For Male
        selectedRelation = (widget.relation == 'Spouse') ? 'Spouse' : 'Father';
      }
    } else {
      // Gender is not fixed
      if (widget.relation == 'Spouse') {
        // If relation is Spouse, set selectedRelation based on defaultMale logic
        selectedRelation = female ? 'Spouse' : 'Spouse';
      }else if (widget.relation == 'Brother') {
        // Handle sibling relation when gender is not fixed
        selectedRelation = female ? 'Sister' : 'Brother'; // Assuming `female` is a boolean indicating the gender
       // isSibling = true;
      }else if (widget.relation == 'Son') {
        // Handle sibling relation when gender is not fixed
        selectedRelation = female ? 'Daughter' : 'Son'; // Assuming `female` is a boolean indicating the gender
      //  isSibling = true;
      }
    }

    // Set the text controller and print debug info
    _RelationController.text = selectedRelation;
    print('Gender: ${widget.gender}');
    print('Is Gender Fixed: ${widget.isGenderFixed}');
    print('Selected Relation: $selectedRelation');
    print('Is Sibling: $isSibling');
  }



  List<Map<String, String>> getRelationOptions() {
    if (widget.relation == 'Brother') {
      // Handle sibling relation when gender is not fixed
      selectedRelation = female ? 'Sister' : 'Brother'; // Assuming `female` is a boolean indicating the gender
      // isSibling = true;
    } else if (widget.relation == 'Son') {
      // Handle sibling relation when gender is not fixed
      selectedRelation = female ? 'Daughter' : 'Son'; // Assuming `female` is a boolean indicating the gender
      //  isSibling = true;
    }
    return []; // Return empty list if no matching relations
  }
  void _updateGender() {
    // Assuming gender values: 6 for female, 7 for male, and 5 for sister
    female = (widget.gender == 6 || widget.gender == 5);
    //male=(widget.gender==4 || widget.gender==7);
  }

  Future<void> _submitForm() async {
    if (formKey.currentState!.validate()) {
      try {
        String name = _FullNameController.text;
        int gender = female ? 2 : 1;
        int relation = _getRelationCode(_RelationController.text);
        String mobile = _PhoneNumberController.text;
        String dateOfBirth = dateController.text;
        bool noMobile = false;
        print('Name: $name');
        print('Gender: $gender');
        print('Relation: $relation');
        print('Mobile: $mobile');
        print('Date of Birth: $dateOfBirth');
        print('No Mobile: ${noMobile ? '1' : '0'}');
        print('Profile Photo Path: ${_image?.path}');

        // Change to your logic if needed
        // String dateOfBirth =  dateController.text ;
        final response = await ApiService.addMember(
          //final response = await ApiService.addMember(
          name: name,
          gender: gender,
          relation: relation,
          mobile: mobile,
          dateOfBirth: dateOfBirth,
          noMobile: noMobile,
          profilePhoto: _image,
          accessToken: accessToken,
        );

        if (response['status'] == 200) {
          print('Success Status Code: 200');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response['message']),
              backgroundColor: Colors.green,),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                Bottom()), // Replace NextPage with your target page
          ); // Replace with your bottom page route
        } else {
          _handleError(response);
          // print('Error Status Code: ${response['status']}');
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text(response['message'])),
          // );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add member: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Please complete the form and add a profile photo')),
      );
    }
  }

  int _getRelationCode(String relation) {
    switch (relation) {
      case 'Father':
        return 1;
      case 'Mother':
        return 2;
      case 'Spouse':
        return 3;
      case 'Brother':
        return 4;
      case 'Sister':
        return 5;
      case 'Daughter':
        return 6;
      case 'Son':
        return 7;
      default:
        return 0;
    }
  }

  void _handleError(Map<String, dynamic> response) {
    if (response['status'] == 422) {
      String errorMessage = 'Please fill in the required fields:\n';
      if (response['detail'] != null) {
        if (response['detail'] is List) {
          for (var error in response['detail']) {
            errorMessage +=
            '- ${error['msg']}\n'; // Adjust this if the structure is different
          }
        } else {
          // Handle case where detail is a string
          errorMessage += '- ${response['detail']}\n';
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage.trim())),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response['message']}')),
      );
    }
  }
  void _toggleGender() {
    setState(() {
      female = !female;
      _updateRelationOptions(); // Update the relation options when gender changes
    });
  }

  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade900,
      appBar: CustomAppBar(title: 'Add Member',
        actionWidget: TextButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Bottom(),
            ),
          );
        }, child: Text("Skip", style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          fontFamily: "Figtree",
        ),)),
      ),

      body: SingleChildScrollView(

        child: Form(
          key: formKey,
          child: Column(
            // height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width * double.maxFinite,

            children: [
            SizedBox(height:12.h,),
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
                      text: "Let's start by adding a new family member to ",
                      style: TextStyle(color: Color(0xFFFFFFFF),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: "your family tree.",
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
                        color: _image != null ? Color(0xFFF7B52C) : Color(
                            0xFF2B2B2B),
                        width: 2.0,
                      )
                  ),
                  child: CircleAvatar(
                      radius: 65.r, // CircleAvatar radius
                      backgroundColor: Color(0xFF2B2B2B),
                      backgroundImage: _image != null
                          ? FileImage(_image!)


                      : (imageUrl != null && imageUrl!.isNotEmpty
              ? NetworkImage(imageUrl!) as ImageProvider
                  : null),
          child: _image == null && (imageUrl == null || imageUrl!.isEmpty)
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/uploagimgperson.png", width: 42.w,),
              // Icon(
              //   Icons.person,
              //   size: 55.sp, // Icon size
              //   color: Color(0xFF737272),
              // ),
              TextButton(
                onPressed: _pickImageFromGallery,
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
    height: 414.h,
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
    if (!widget.isGenderFixed) {


    setState(() {
    female = true;
    _updateRelationOptions();
    });
    }
    },
    child: Container(
    padding: EdgeInsets.all(10.r),
    margin: EdgeInsets.all(10.r),
    decoration: BoxDecoration(
    border: Border.all(color: female ? Colors.amber :Colors.grey.shade800),
    borderRadius: BorderRadius.circular(5.r),

    color:female ? Colors.amber.withOpacity(0.1) : Colors.black.withOpacity(0.1),
    ),
    child: Row(
    children: [
    SizedBox(width: 2.w,),
    CircleAvatar(
    backgroundColor:Colors.black.withOpacity(0.1) ,
    child:
    Image.asset("assets/images/femalegender.png", color:female ? Colors.amber : Colors.grey ,)

    ),
    SizedBox(width: 5.w,),
    Text(
    ' Female',
    textScaleFactor: 1.2.sp,
    style: TextStyle(
    fontFamily: 'Figtree',
    fontSize: 12.sp,
    color: female ? Colors.white : Colors.grey,
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
    if (!widget.isGenderFixed) {

    setState(() {
    female = false;
    _updateRelationOptions();
    });
    }
    },
    child: Container(
    padding: EdgeInsets.all(10.r),
    margin: EdgeInsets.all(10.r),
    decoration: BoxDecoration(
    border: Border.all(color:female ? Colors.grey.shade800 : Colors.amber),
    borderRadius: BorderRadius.circular(5.r),
    color:female ? Colors.black.withOpacity(0.1) : Colors.amber.withOpacity(0.1),
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
    color: female ? Colors.grey : Colors.white,
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
    child: TextFormField(
    controller: _FullNameController,

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
    SizedBox(height: 3.h), // Space between the fields
    Align(
    alignment: Alignment.topLeft,
    child: Padding(
    padding: const EdgeInsets.all(8.0).r,

    child: Text(
    "Relation",
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
    child: TextFormField(
    cursorColor: Color(0xFFF7B52C),
    keyboardType: TextInputType.text,

    controller: _RelationController,
    readOnly: true,
    style: TextStyle(
    color: Color(0xFFFFFFFF),
    fontFamily: 'Figtree',
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    ),
    decoration: InputDecoration(
    // label: Text(
    //   "Enter relation",
    //   style: TextStyle(color: Color(0xFF4E4C4C), fontSize: 12.sp),
    // ),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10).r,
    borderSide: BorderSide.none,
    ),
    fillColor: Colors.black.withOpacity(0.1),
    filled: true,
    ),

    ),

    ),

    SizedBox(height: 5.h), // Space between the fields
    Align(
    alignment: Alignment.topLeft,
    child: Padding(
    padding: const EdgeInsets.all(5.0).r,
    child: Text(
    "Mobile Number",
    style: TextStyle(
    fontWeight: FontWeight.w400,
    color: Color(0xFFFFFFFF),
    fontFamily: 'Figtree',
    fontSize: 14.sp,
    ),
    ),
    ),
    ),
    IntlPhoneField(

    controller: _PhoneNumberController,
    focusNode: focusNode,
    style: TextStyle(
    color: Color(0xFFFFFFFF),
    fontFamily: 'Figtree',
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    ),
    decoration: InputDecoration(
    label: Text(
    "000 000 0000",

    style: TextStyle(color: Color(0xFF4E4C4C), fontSize: 12.sp),
    ),
    fillColor: Colors.black.withOpacity(0.1),
    filled: true,
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10).r,
    borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10).r,
    borderSide: BorderSide.none,
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 14.5).r,
    ),
    languageCode: "en",
    initialCountryCode: "IN",
    onChanged: (phone) {
    //_PhoneNumberController.text = phone.completeNumber;
    print(phone.completeNumber);
    },
    onCountryChanged: (country) {
    print('Country changed to: ' + country.name);
    },


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
    child: TextFormField(

    style: TextStyle(
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    fontFamily: 'Figtree',
    ),
    controller: dateController,
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
    setState(() {
    dateController.text = formattedDate;
    dateOfBirth = formattedDate;
    // print("Selected Date of Birth: $dateOfBirth");
    });
    print("Selected Date of Birth: $dateOfBirth");
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
    // SizedBox(height: 10.h),
    Container(
    height: 40.h,
    width: 325.w,
    decoration: BoxDecoration(
    //color: Colors.pinkAccent,
    borderRadius: BorderRadius.circular(20).r,
    ),
    child: GradientButton(

    // color: Color(0xFFF7B52C),

    onPressed: _submitForm,

    // if (_FullNameController.text.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Please enter your Name.'),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    //   return;
    // }
    //
    //
    // if (_RelationController.text.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Please enter your Relation.'),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    //   return;
    // }
    // if (_PhoneNumberController.text.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Please enter your phone number.'),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    //   return;
    // }
    // Navigator.push(context, MaterialPageRoute(builder: (_) => Bottom()));


    child: Text(
    'Add Member',
    style: TextStyle(
    fontFamily: 'Figtree',
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
    color: Color(0xFF1E1E1E),
    ),
    ),
    ),
    ),
    SizedBox(height: 45.h,)
    ],

    ),
    ),
    )
    ,


    );
  }
}

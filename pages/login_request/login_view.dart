
import 'package:http/http.dart' as http;

import 'package:famlaika1/widgets/GradientButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../constants/colors.dart';

import '../../apiservice/api_services.dart';
import '../otp/otp_view.dart';
import 'login_provider.dart'; // Assuming this is a file where you've defined your size utils

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String _countryCode = 'IN';
  GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _phoneNumberController = TextEditingController();
//  bool _isLoading = false;
  final ApiService apiService = ApiService();

  FocusNode focusNode = FocusNode();

  void _handleRequestOTP() async {

    final String phoneNumber = _phoneNumberController.text.trim();
    if (!_isValidPhoneNumber(phoneNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid phone number")),
      );
      return;
    }

    Provider.of<LoginProvider>(context, listen: false).setLoading(true);
    // setState(() {
    //   _isLoading = true;
    // });

   // final apiService = ApiService();

    try {
      final response = await apiService.generateOtp( phoneNumber);

      Provider.of<LoginProvider>(context, listen: false).setLoading(false);
      if (response.containsKey('message') && response['message'] == "OTP sent successfully.") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('phoneNumber', phoneNumber);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Otp(phoneNumber: phoneNumber,),
          ),
        );

      } else if (response.containsKey('error')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response['error']}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unexpected response format: $response')),
        );
      }
    } catch (error) {
      Provider.of<LoginProvider>(context, listen: false).setLoading(false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }
  // catch (error) {
  //   setState(() {
  //   _isLoading = false;
  //   });
  //
  //   ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(content: Text('Error: $error')),
  //   );
  //   }
 // }
  bool _isValidPhoneNumber(String phoneNumber) {
    // Basic validation for phone number format
    final regex = RegExp(r'^\d{10}$'); // Adjust regex based on expected phone number format
    return regex.hasMatch(phoneNumber);
  }

    @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: SizedBox(
            height: 650.h, // Using .h for responsive height
            width: double.maxFinite,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  width: 420.23.w, // Using .w for responsive width
                  height: 740.h,
                  top: -40.h,
                  left: -110.w,
                  child: Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(bottom: 369.h),
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(195.r), // Using .r for responsive radius
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(29, 29, 29, 0),
                          Color(0xFF313131),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Positioned(
                  width: 220.99.w,
                  height: 260.h,
                  top: 37.h,
                  left: 15.w,
                  child: Image.asset(
                    "assets/images/img_grp128f.png",
                    height: 230.h,
                    width: 200.w,
                    alignment: Alignment.center,
                  ),
                ),
                Positioned(
                  width: 172.w,
                  height: 70.h,
                  top: 350.h,
                  left: 16.w,
                  child: Text(
                    'Hello, Let\'s get started!',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Figtree',
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.36,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
                Positioned(
                  width: 420.w,
                  height: 60.h,
                  top: 425.h,
                  left: 16.w,
                  child: Text(
                    'Bring your family closer together\nwith Famlaika.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Figtree',
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      height: 1.36,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
                Positioned(
                  width: 55.w,
                  height: 55.h,
                  top: 70.h,
                  left: 280.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      //borderRadius: BorderRadius.circular(25.r),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff5DB9A7),
                        )
                      ],
                    ),
                    child:
                    Image.asset(
                      "assets/images/img_intersect_1.png",
                      height: 40.h,
                      width: 31.w,
                    ),
                  ),
                ),
                Positioned(
                  width: 95.w,
                  height: 95.h,
                  top: 140.h,
                  left: 260.w,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.circular(25.r),
                      // boxShadow: [
                      //  BoxShadow(color: Color(0xffA69AF5)),
                      // ],
                    ),
                    child: Image.asset("assets/images/img_13.png",
                    ),
                  ),
                ),
                Positioned(
                  width: 55.w,
                  height: 55.h,
                  top: 230.h,
                  left: 247.w,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.circular(25.r),
                      boxShadow: [
                        BoxShadow(color: Color(0xffE67657)),
                      ],
                    ),
                    child: Image.asset("assets/images/img_intersect_3.png"),
                  ),
                ),
                Positioned(
                  width: 97.w,
                  height: 97.h,
                  top: 270.h,
                  left: 160.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      //borderRadius: BorderRadius.circular(25.r),
                      // boxShadow: [
                      //   BoxShadow(color: Color(0xFFF0994B)),
                      // ],
                    ),
                    child: Image.asset(
                      "assets/images/img_intersect_4.png",
                      height: 45.h,
                      width: 45.w,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Image.asset(
                            "assets/images/img_Ellipse69.png",
                            height: 121.h,
                            width: 29.w,
                          ),
                          margin: EdgeInsets.only(
                            top: 220.h,
                            bottom: 54.h,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 10.w,
                              bottom: 54.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 266.h,
                                  width: 286.w,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 241.w,
                                            top: 53.h,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(height: 38.h),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                      ),
                                      SizedBox(
                                        height: 7.h,
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: SizedBox(
                                          height: 239.h,
                                          width: 214.w,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Container(
                                                  margin: EdgeInsets.only(right: 30.w),
                                                  padding: EdgeInsets.all(20.w),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(92.r),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SizedBox(height: 3.h),
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
                                SizedBox(height: 7.h),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.all(10.w),
                  child: Container(
                    height: 165.h,
                    width: 325.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 7.h,),
                        Container(
                          height: 30.h,
                          //color: Colors.pinkAccent,
                          child: Text(
                            "Enter Mobile Number",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Figtree',
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                        Container(
                          height: 57.h,
                          //color: Colors.pinkAccent,

                          child: Form(
                            key: _formKey,
                            child: IntlPhoneField(
                              controller: _phoneNumberController,
                              focusNode: focusNode,
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),

                              ),
                              decoration: InputDecoration(
                                fillColor: Color(0xFF2F2F2F),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                   // color: Colors.transparent
                                  ),
                                 // borderRadius: BorderRadius.circular(10.0).r,

                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                   // color: Colors.white,
                                  ),
                                  //borderRadius: BorderRadius.circular(10.0).r,
                                ),
                                // enabledBorder: OutlineInputBorder(
                                //   borderSide: BorderSide(
                                //     color: Colors.transparent,
                                //   ),
                                //   //borderRadius: BorderRadius.circular(10.0).r,
                                // ),
                                contentPadding: EdgeInsets.symmetric(vertical: 14.5).r
                              ),
                              languageCode: "en",
                              initialCountryCode: "IN",
                              onChanged: (phoneNumber) {
                                print(phoneNumber.completeNumber);
                              },
                              onCountryChanged: (country) {
                                print('Country changed to: ' + country.name);
                              //  _countryCode = country.code;
                              },
                            ),
                          ),
                        ),
                         SizedBox(height: 10.h),
                        //_isLoading
                       // ? CircularProgressIndicator()

                        Container(
                          height: 40.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(

                          ),


                          child: GradientButton(

                            child: Text(
                              'Request OTP',
                              style: TextStyle(
                                fontFamily: 'Figtree',
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                                color: Color(0xFF1E1E1E),
                              ),
                            ),
                           // color: Color(0xFFF7B52C),
                            onPressed:
                          _handleRequestOTP,


                          )
      ),

                      ],
                    ),
                  ),

                ),

                    Consumer<LoginProvider>(
                      builder:(context, loginProvider, child) {
                        if (loginProvider.isLoading)
                          return Stack(
                            children: [
                              ModalBarrier(
                                color: Colors.black54,
                                dismissible: false,
                              ),
                              Center(
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          );

                        return SizedBox.shrink();
    }
          )
                    

       
      ],
                
          ),
            
          ),
        ),
        
      ),
    );
  }
}

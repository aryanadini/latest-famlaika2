import 'dart:convert';
import 'dart:developer';

import 'package:famlaika1/pages/personalinformation/personalinfo_view.dart';
import 'package:famlaika1/widgets/GradientButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../apiservice/api_services.dart';
import '../../apiservice/auth_service.dart';
import '../../constants/appbarConst.dart';
import '../../constants/colors.dart';
import '../homefamilytree/homesub/home2.dart';
import '../request/request_view.dart';
import 'OtpProvider.dart';

class Otp extends StatefulWidget {
  final String phoneNumber;

  Otp({super.key, required this.phoneNumber});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final _pinPutController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();
  final storage = FlutterSecureStorage();
  bool _isLoading = false;
  @override
  void dispose() {
    _pinPutController.dispose();
    focusNode.dispose();
    super.dispose();
  }
  Future<void> verifyOtp(String otp, String phoneNumber,) async {
    setState(() {
      _isLoading = true;  // Set loading to true when verification starts
    });
    try {
      final response = await _apiService.post(
        '/verify_otp',
        body: jsonEncode({
          'mobile': phoneNumber,
          'otp': otp,
        }), headers: {},
      );

      // Log the full response body for debugging
     // log('Full response body: ${response.body}');

      final responseBody = jsonDecode(response.body);
      String message = responseBody['message'] ?? responseBody['error'] ?? 'Incorrect OTP';
      final errorCode = response.statusCode;

      if (response.statusCode == 200) {
        String accessToken = responseBody['access_token'];

        await authService.setAccessToken(accessToken);
        // Handle successful verification
        log('Verification successful: $message');
        log('Access Token: $accessToken');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Verification successful!'),
            backgroundColor: Colors.green,
          ),
        );
        final profileResponse = await http.get(
          Uri.parse('http://www.famlaika.com/profile'),
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        );
        if (profileResponse.statusCode == 200) {
          final profileData = jsonDecode(profileResponse.body);
          String nextPage = profileData['next_page']['go_to'];

          // Navigate to the appropriate page based on the profile response
          if (nextPage == 'profile_update') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Personalinfo (accessToken: accessToken)),
            );
          } else if (nextPage == 'request_list') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Requestview(accessToken: accessToken)),
            );
          } else if (nextPage == 'home_page') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home2(accessToken: accessToken, userId: '',)),
            );
          }
        } else {
          log('Failed to fetch profile: ${profileResponse.body}');
        }
      } else {
        String errorMessage;

        switch (errorCode) {
          case 400:
            errorMessage = 'Bad request (400): $message';
            break;
          case 401:
            errorMessage = ' $message';
            break;
          case 402:
            errorMessage = ' $message';
            break;
          case 403:
            errorMessage = '$message';
            break;
          case 404:
            errorMessage = '$message';
            break;
          case 500:
            errorMessage = ' $message';
            break;
          default:
            errorMessage = 'Verification failed ($errorCode): $message';
            break;
        }

        print(errorMessage);


        log(errorMessage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.transparent,
          ),
        );
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      log('Error verifying OTP: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error verifying OTP. Please try again later.'),
         // backgroundColor: Colors.transparent,
        ),
      );
    }
    finally {
      setState(() {
        _isLoading = false;  // Set loading to false when verification ends
      });
    }
  }





  @override
  Widget build(BuildContext context) {
    final otpProvider = Provider.of<OtpProvider>(context);
    final defaultPinTheme = PinTheme(
      width: 58.w,
      height: 58.h,
      textStyle: TextStyle(
        fontFamily: 'Figtree',
        fontSize: 20.sp,
        color: Color.fromRGBO(255, 255, 255, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(56, 56, 56, 1)),
        borderRadius: BorderRadius.circular(8.r),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(47, 47, 47, 1)),
      borderRadius: BorderRadius.circular(8.r),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(56, 56, 56, 1),
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(title: 'OTP Verification',
          // backgroundColor: Colors.grey.shade900,
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   icon: Icon(Icons.arrow_back_ios, color: Color(0xFFFFFFFF)),
          // ),
          // title: Text(
          //   "OTP Verification",
          //   style: TextStyle(
          //     color: Color(0xFFFFFFFF),
          //     fontSize: 22.sp,
          //     fontFamily: 'Figtree',
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
        ),
        body: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width * double.maxFinite,
          padding: EdgeInsets.all(15.w),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  //color: Colors.pinkAccent,
                    height: 65.h,
                    width: 260.w,
                    margin: EdgeInsets.only(right: 98.w),
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Enter the OTP code sent to your\n',
                            style: TextStyle(color: Color(0xFFFFFFFF),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,),
                          ),
                          TextSpan(text: 'registered mobile number.',
                            style: TextStyle(color: Color(0xFFFFFFFF),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                height: 1.36.h),
                          )
                        ]

                    ),

                    )
                  // Text(
                  //   "Enter the OTP code sent to \nyour registered mobile number.",
                  //   maxLines: 2,
                  //   overflow: TextOverflow.ellipsis,
                  //   style: TextStyle(
                  //     fontFamily: 'Figtree',
                  //     fontWeight: FontWeight.w400,
                  //     fontSize: 16.sp,
                  //     color: Color(0xFFFFFFFF),
                  //     height: 1.38,
                  //   ),
                  // ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Container(
                      height: 90.h,
                      //color: Colors.pinkAccent,
                      child: Pinput(
                        controller: _pinPutController,
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          debugPrint('onCompleted: $pin');
                        },
                        onChanged: (value) {
                          debugPrint('onChanged: $value');
                          otpProvider.setOtp(value);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Didn't receive OTP? ",
                                style: TextStyle(color: Color(0xFFFFFFFF),
                                  fontFamily: 'Figtree',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                ),
                              ),
                              TextSpan(
                                text: "Resend",
                                style: TextStyle(
                                  fontFamily: 'Figtree',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                  color: Color(0xFFF7B52C),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 75.h),
                  Container(
                    height: 40.h,
                    width: 328.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(243, 128, 43, 1),
                          Color(0xFFFAE42C),
                        ],
                      ),
                    ),
                    child:_isLoading
                    ? Center(child: CircularProgressIndicator())
                    :GradientButton(
                      child: Text(
                        'Verify',
                        style: TextStyle(
                          fontFamily: 'Figtree',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: Color(0xFF1E1E1E),
                        ),
                      ),

                     // color: Color(0xFFF7B52C),
                      onPressed: () {
                        if (_pinPutController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please enter OTP.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                       verifyOtp(_pinPutController.text, widget.phoneNumber);

                        focusNode.unfocus();
                        formKey.currentState!.validate();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:famlaika1/constants/appbarConst.dart';
import 'package:famlaika1/pages/otp/otp_view.dart';
import 'package:famlaika1/widgets/GradientButton.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeNumberPage extends StatelessWidget {
  final TextEditingController _oldPhoneNumberController = TextEditingController();
  final TextEditingController _newPhoneNumberController = TextEditingController();
  final FocusNode oldPhoneFocusNode = FocusNode();
  final FocusNode newPhoneFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: CustomAppBar(
        title: "Change Phone Number",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            // Enter your old number text
            Text(
              "Enter your old number",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontFamily: 'Figtree',
              ),
            ),
            SizedBox(height: 10.h),

            // IntlPhoneField for old number
            IntlPhoneField(
              controller: _oldPhoneNumberController,
              focusNode: oldPhoneFocusNode,
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
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 14.5.r),
              ),
              languageCode: "en",
              initialCountryCode: "IN",
              onChanged: (phone) {
                print(phone.completeNumber);
              },
              onCountryChanged: (country) {
                print('Country changed to: ' + country.name);
              },
            ),
            SizedBox(height: 20.h),

            // Enter your new number text
            Text(
              "Enter your new number",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontFamily: 'Figtree',
              ),
            ),
            SizedBox(height: 10.h),

            // IntlPhoneField for new number
            IntlPhoneField(
              controller: _newPhoneNumberController,
              focusNode: newPhoneFocusNode,
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
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 14.5.r),
              ),
              languageCode: "en",
              initialCountryCode: "IN",
              onChanged: (phone) {
                print(phone.completeNumber);
              },
              onCountryChanged: (country) {
                print('Country changed to: ' + country.name);
              },
            ),

            // Spacer to push the button to the bottom
            Spacer(),

            // Gradient button
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: SizedBox(
                width: double.infinity,
                height: 40.h,
                child: GradientButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Otp(phoneNumber: _newPhoneNumberController.text,
                                )));

                    // Add your onPressed logic here
                  },

                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFF3802B),
                          Color(0xFFFAE42C),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Figtree',
                          color: Colors.black,
                        ),
                      ),
                    ),
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

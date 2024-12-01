import 'package:famlaika1/constants/appbarConst.dart';
import 'package:famlaika1/constants/bottom.dart';
import 'package:famlaika1/pages/myprofile/myprofile.dart';
import 'package:famlaika1/pages/post_view_bottom/post_view.dart';
import 'package:famlaika1/widgets/GradientButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {



  bool isFormFilled = false;
  final TextEditingController textController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  bool _isRestricted = false; // State variable to track the switch position

  bool _isAddToStory = false;
  @override
  void initState() {
    super.initState();
    // Add listeners to your controllers to update the state when data is entered
    textController.addListener(_updateButtonState);
    imageController.addListener(_updateButtonState);
  }
  void _updateButtonState() {
    // Check if all required fields are filled
    if (textController.text.isNotEmpty && imageController.text.isNotEmpty) {
      setState(() {
        isFormFilled = true;
      });
    } else {
      setState(() {
        isFormFilled = false;
      });
    }
  }
   TextEditingController _textController = TextEditingController();
  File? _selectedImage;
  void _toggleAddToStory(bool value) {
    setState(() {
      _isAddToStory = value;
    });
    // Perform any additional action when this switch is toggled
  }

  void _toggleSwitch(bool value) {
    setState(() {
      _isRestricted = value; // Update the state based on user input
    });
  }
  List<String> selectedOptions = [];
  Widget _visibilityOption(String label) {
    return GestureDetector(
        onTap: () {
          setState(() {
            if (!selectedOptions.contains(label)) {
              selectedOptions.add(label);
            }
          });
        },
      child: SizedBox(
       //height: 60.h,
        //width: 70.w,

        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color:Color(0xFF383838),width: 1 )
          ),
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ),
      ),
    );
  }


  final ImagePicker _picker = ImagePicker();
  String selectedVisibility = "Anyone"; // Default visibility option

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }
  void _post() {
    if (_selectedImage != null || _textController.text.isNotEmpty) {
      // Navigate to PostViewPage first, and then to ProfilePage
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => postfeed(
              postedImage: _selectedImage,
              postedText: _textController.text,
            ),
          ),
      ).then((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(
              postedImage: _selectedImage,
              postedText: _textController.text,
            ),
          ),
        ).then((_) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   // SnackBar(
          //   //   content: Text("Image posted successfully!"),
          //   // ),
          // );
        });
      });
    }
  }
  @override
  void dispose() {
    _textController.dispose();
    imageController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: CustomAppBar(
        title: "Create Post",
        actionWidget: SizedBox(
          width: 70.w, // Adjust the width as needed
          height: 20.h, // Adjust the height as needed
          child: Container(
            height: 37.h,
            width: 80.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF3802B), Color(0xFFFAE42C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => postfeed(postedText: '',),
                  ),
                );
                // Handle post action
              },
              style: ElevatedButton.styleFrom(

                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                backgroundColor: Colors.transparent, // Make the button background transparent
                shadowColor: Colors.transparent, // Remove shadow
              ),
              child: Text(
                "Post",textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF1E1E1E),
                  fontSize: 12.sp,
                  fontFamily: "Figtree",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Color(0xFF2B2B2B), // Background color of the entire container
                ),
                child: Row(
                  children: [
                    // Left Section
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image
                        Container(
                          height: 140.h,
                          width: 160.w,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: _selectedImage == null
                                ? Image(
                              image: AssetImage("assets/images/img_gallery_frame.png"),
                              height: 50.h,
                            )
                                : Image.file(_selectedImage!,
                                width: 50.w, height: 50.h, fit: BoxFit.cover),
                          ),
                        ),
                        // Spacing between image and button
                        SizedBox(height: 1.h),
                        // Button
                        Container(
                          width: 160.w,
                          height: 52.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.0),
                            color: Color(0xFF383838), // Color of the button background
                          ),
                          child: TextButton(

                            onPressed: _pickImage,
                            child: Text(
                              'Choose Image',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF), // Text color
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Figtree",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 1.w), // Space between the left and right sections
                    // Right Section
                    Expanded(
                      child: Container(
                        height: 194.h,
                        padding: EdgeInsets.all(8.0), // Add padding around the text field
                        decoration: BoxDecoration(
                          color: Color(0xFF262626), // Background color of the right section
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Label
                            // Padding(
                            //   padding: EdgeInsets.only(bottom: 4.h),
                            //   child: Text(
                            //     'Write something...',
                            //     style: TextStyle(
                            //       color: Colors.grey.shade400, // Label color
                            //       fontSize: 14.sp,
                            //     ),
                            //   ),
                            // ),
                            // Text Field
                            Expanded(
                              child: TextField(
                                controller: _textController,
                                maxLines: 15,
                                decoration: InputDecoration(
                                    hintText: 'Write something....',
                                    hintStyle:
                                    TextStyle(color: Colors.grey.shade400),
                                    border: InputBorder.none
                                ),

                                style: TextStyle(
                                  color: Colors.white, // Label color
                                  fontSize: 14.sp,
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

              SizedBox(height: 25.h),
              Text(
                "Whose family can see your post?",
                style: TextStyle(color: Colors.white, fontSize: 16,fontFamily: "Figtree"),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 8),
        Container(
          width: double.infinity, // Makes the container full width
          height: 80.h, // Set the desired height
          decoration: BoxDecoration(
            color: Color(0xFF262626), // Background color of the container
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Color(0xFF383838),width: 1.0
            ,)
            // Optional rounded corners
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: selectedOptions.map((option) {
                    return Container(
                      margin: EdgeInsets.only(right: 8.0),
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color:Color(0xFF383838) )
                      ),
                      child: Text(
                        option,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),

              //SizedBox(height: 16.h,),

              // Container(
              //   padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
              //   decoration: BoxDecoration(
              //     color: Colors.grey.shade800,
              //     borderRadius: BorderRadius.circular(8.0),
              //     border: Border.all(color: Color(0xFF383838),width: 1)
              //   ),
              //   child: Text(
              //     selectedVisibility,
              //     style: TextStyle(color: Colors.white, fontSize: 16),
              //   ),
              // ),
              SizedBox(height: 16.h),
              Wrap(
                spacing: 8.0,
                runSpacing: 5.0,
                children: [
                  _visibilityOption('My Family'),
                  _visibilityOption('Father\'s'),
                  _visibilityOption('Mother\'s'),
                  _visibilityOption('Spouse\'s'),
                  _visibilityOption('Spouse\'s Father'),
                  _visibilityOption('Spouse\'s Mother'),
                  _visibilityOption('Siblings'),
                  _visibilityOption('Anyone'),
                ],
              ),

              // GridView.builder(
              //   shrinkWrap: true,
              //   physics: NeverScrollableScrollPhysics(),
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 3,
              //     childAspectRatio: 3, // Adjust the aspect ratio as needed
              //     mainAxisSpacing: 10.0,
              //     crossAxisSpacing: 5.0,
              //   ),
              //   itemCount: 8, // Number of visibility options
              //   itemBuilder: (context, index) {
              //     List<String> visibilityOptions = [
              //       'My Family',
              //       'Father\'s',
              //       'Mother\'s',
              //       'Spouse\'s',
              //       'Spouse\'s Father',
              //       'Spouse\'s Mother',
              //       'Siblings',
              //       'Anyone',
              //     ];
              //     return _visibilityOption(visibilityOptions[index]);
              //   },
              // ),
              Divider(color: Colors.grey.shade700, height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(
                    "Add to story",
                    style: TextStyle(color: Colors.white, fontSize: 14,
                        fontFamily:"Figtree" ),
                  ),
                  Transform.scale(
                    scale: .7, // You can adjust the scale value if you need to resize the switch
                    child: Switch(
                      value:_isAddToStory, // Switch value bound to the state
                      onChanged:_toggleAddToStory, // Update the state on change
                      activeColor: Colors.amber, // Color when the switch is on
                      inactiveThumbColor: Colors.amber, // Color of the thumb when the switch is off
                      inactiveTrackColor: Colors.grey.shade800, // Color of the track when the switch is off
                      activeTrackColor: Colors.grey.shade800, // Color of the track when the switch is on
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Restrict others can share this\npost to their family groups",
                    style: TextStyle(color: Colors.white, fontSize: 14,
                        fontFamily:"Figtree" ),
                  ),
                  Transform.scale(
                    scale:.7,
                   child : Switch(
                      value: _isRestricted, // Switch value bound to the state
                      onChanged: _toggleSwitch, // Update the state on change
                      activeColor: Colors.amber, // Color when the switch is on
                      inactiveThumbColor: Colors.amber, // Color of the thumb when the switch is off
                      inactiveTrackColor: Colors.grey.shade800, // Color of the track when the switch is off
                      activeTrackColor: Colors.grey.shade800,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      // Color of the track when the switch is on
                    ),
                  ),

                ],
              ),
              SizedBox(height: 80.h,),
              
            ],
          ),
        ),

      ),

    );
  }


}



import 'package:famlaika1/constants/appbarConst.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/GradientButton.dart';
import 'about.dart';
import 'blockedperson.dart';
import 'change_phone.dart';
import 'helpsupport.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Settings"),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Delete Account Container
            _buildSettingsContainer(
              context,
              icon:CupertinoIcons.delete_simple,
              text: 'Delete Account',
              onTap: () => _showDeleteBottomSheet(context),
              trailing: null,
            ),
            SizedBox(height: 16),
            // Change Number Container
            _buildSettingsContainer(
              context,
               image: AssetImage("assets/images/changephnicon.png"),
            //  icon: Icons.local_activity,
              text: 'Change Your Number',
              onTap: () {
                _navigateToPage(context, ChangeNumberPage());
              },

              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            ),
            SizedBox(height: 16),
            // Blocked Person Container
            _buildSettingsContainer(
              context,
             image: AssetImage("assets/images/blocperson.png"),
             // icon: Icons.block,
              text: 'Blocked Person',
              onTap: () => _navigateToPage(context, BlockedPersonPage()),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            ),
            SizedBox(height: 16),
            // Mute Notification Container
            _buildSettingsContainer(
              context,
              image: AssetImage("assets/images/mute.png"),
             // icon: Icons.notifications_off,
              text: 'Mute Notification',
              onTap: () {},

              trailing: Transform.scale(
                scale: 0.8,
                child: Switch(
                  value:  isSwitched,
                  onChanged: (bool value) {
                    setState(() {
                      isSwitched = value; // Toggle the switch state
                    });
                  },
                  activeColor: Colors.yellow,
                  activeTrackColor: Colors.grey.shade700,
                ),
              ),
            ),
            SizedBox(height: 16),
            // Help & Support Container
            _buildSettingsContainer(
              context,
              icon: Icons.headphones_outlined,
              text: 'Help & Support',
              onTap: () => _navigateToPage(context, HelpSupportPage()),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            ),
            SizedBox(height: 16),
            // About Container
            _buildSettingsContainer(
              context,
              image: AssetImage("assets/images/about.png"),
             // icon: Icons.info,
              text: 'About',
              onTap: () => _navigateToPage(context, AboutPage()),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade900,
    );
  }

  Widget _buildSettingsContainer(
      BuildContext context, {
        IconData? icon,
        ImageProvider? image,
        required String text,
        required VoidCallback onTap,
        Widget? trailing,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Color(0xFF262626),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (image != null) // Display image if provided
                  Image(image: image,
                  height: 32,
                      width: 32,
                  fit: BoxFit.cover,)
                else if (icon != null) // Display icon if provided and no image
                  Icon(icon, color: Colors.white),
                SizedBox(width: 16),
                Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  void _showDeleteBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.delete_simple, color: Colors.white, size: 40),
              SizedBox(height: 10),
              Text(
                'Delete Account',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Figtree"

                ),
              ),
              SizedBox(height: 10),
              Text(
                'Are you sure you want to delete\n your Famlaika Account?'
                    ,style:
              TextStyle(fontFamily: "Figtree", fontSize: 16,height: 1.5),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h,),
              Text("(When you delete your Famlaika account,"
                  " you won’t be able to\n retrieve the content or information"
                  " you’ve shared on Famlaika.)"
                ,style:TextStyle(fontSize: 10,fontFamily: 'Figtree',
                    fontStyle:FontStyle.italic,color: Color(0xFF949292) ) ,),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 36.h,
                    width: 110.w,
                    alignment: Alignment.center,
                    child: GradientButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                      isSolidColor: true,
                      solidColor: Colors.grey,



                    ),
                  ),
                  Container(
                    height: 36.h,
                    width: 110.w,
                    alignment: Alignment.center,
                    child: GradientButton(
                      onPressed: () {

                        // Confirm delete logic here
                        Navigator.pop(context);
                      },
                      child: Text('Confirm'),








                    ),
                  )


                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
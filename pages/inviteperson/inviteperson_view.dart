import 'package:dotted_border/dotted_border.dart';
import 'package:famlaika1/constants/appbarConst.dart';
import 'package:flutter/material.dart';
class Contact {
  final String name;
  final ImageProvider image;

  Contact({required this.name, required this.image});
}
class InvitePersonPage extends StatelessWidget {
  final List<Contact> contacts = [
    Contact(
      name: 'Alice Johnson',
      image: AssetImage('assets/images/img_listsibling2.png'), // Replace with actual image assets
    ),
    Contact(
      name: 'Bob Smith',
      image: AssetImage('assets/images/img_listsibling3.png'), // Replace with actual image assets
    ),
    // Add more contacts here
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: CustomAppBar(
        title: 'Invite Person',

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Column - Heading
            Text(
              'Share link',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Figtree",
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),

            // Second Column - Share Description
            Text(
              'Share your invitation link with your friends or',
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Figtree",
                color: Colors.white,
              ),
            ),
            Text(
              'family members to join Famlaika.',
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Figtree",
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),

            // Third Column - Link with Dotted Border and Share Icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(5),
                    padding: EdgeInsets.all(4),
                    color: Color(0xFF383838),
                    strokeWidth: 1,
                    child: Container(
                      color: Colors.grey.shade900,
                      padding: EdgeInsets.all(16),

                      child: Text(
                        'FaMLaiKa/api/1/invites/@JPotgV EQ%hkvHGIbkj...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(onPressed: (){}, icon: Icon(Icons.share_outlined,
                  color: Colors.white,)),
              ],
            ),
            SizedBox(height: 16),

            // Line Divider
            Divider(color: Color(0xFF383838)),

            // Fourth Column - From Contact Heading
            SizedBox(height: 16),
            Text(
              'From Contact',
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Figtree",
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),

            // List of Contacts (Example ListTile)
            Expanded(
              child: ListView.separated(
                itemCount: contacts.length,
                separatorBuilder: (context, index) => SizedBox(height: 12), // Number of contacts
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: contact.image,
                      radius: 24,
                    ),
                    title: Text(
                      contact.name,
                      style: TextStyle(color: Colors.white,
                          fontFamily: "Figtree",
                      fontSize: 16),
                    ),
                    onTap: () {
                      // Handle tap on contact
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



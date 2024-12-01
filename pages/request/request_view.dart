import 'package:famlaika1/constants/appbarConst.dart';
import 'package:famlaika1/pages/request/requestgradient.dart';
import 'package:famlaika1/pages/request/requstlisttile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../apiservice/api_services.dart';
import '../../widgets/GradientButton.dart';
import '../galleryaccesspages/gradientgalleryAccess.dart';

class Requestview extends StatefulWidget {
  const Requestview({super.key, required String accessToken});

  @override
  State<Requestview> createState() => _RequestviewState();
}

class _RequestviewState extends State<Requestview> {


  bool isReceivedSelected = true;
  late Future<List<dynamic>> sentRequests;
  late Future<List<dynamic>> receivedRequest;
  bool _isRequestVisible = true;
  void _cancelRequest() {
    setState(() {
      _isRequestVisible = false;
    });
  }





  @override
  void initState() {
    super.initState();
    sentRequests = ApiService().fetchSentRequests();
    receivedRequest=ApiService().fetchRequests();
  }
  String getRelation(int relation) {
    switch (relation) {
      case 1:
        return 'father';
      case 2:
        return 'Mother';
      case 3:
        return 'Spouse';
      case 4:
        return 'Brother';
      case 5:
        return 'Sister';
      case 6:
        return 'Daughter';
      case 7:
        return 'Son';
      default:
        return 'Unknown';
    }
  }



  // bool isAccepted = false;
  // bool isSent = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: CustomAppBar(title: "Request",
        actionWidget: TextButton(onPressed: (){

        },
             child: TextButton( onPressed: () {  Navigator.pushNamed(context,
                 '/bottom'); }, child: Text("Skip",style: TextStyle(
                 fontFamily: "Figtree",
                 color: Colors.white)),),),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GradientRe(
            isReceivedSelected: isReceivedSelected,
            onTabChange: (bool receivedSelected) {
              setState(() {
                isReceivedSelected = receivedSelected;
              });
            },


          ),
    Expanded(
    child: ListView(
    children: isReceivedSelected
    ? [
      SizedBox(height: 16.0),
        Text(
          'New',
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontFamily: "Figtree"
          ),
        ),

      SizedBox(height: 16.0),
      FutureBuilder<List<dynamic>>(
        future: receivedRequest,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return Center(
                child: Text('No received requests found.'));
          } else {
            final requests = snapshot.data!;
            return Column(
              children: requests
                  .where((request) => request['status'] == 0)
                  .map((request) => REqLi(
                image: request['person']
                ['profile_pic'] ??
                    'assets/images/img_16.png',
                title:
                '${request['person']['name']} added you as ${getRelation(request['relation'])}',
                requestId: request['id'].toString(), relationId: '',
              ))
                  .toList(),
            );
          }
        },
      ),

    ]
        : [
    // Display "Sent" items here
        SizedBox(height: 16.0),
        Text(
          'New',
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontFamily: "Figtree"
          ),
        ),


      SizedBox(height: 16.0),
      FutureBuilder<List<dynamic>>(
        future: sentRequests,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No sent requests found.'));
          } else {
            final requests = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index];
                final person = request['person'];
                final name = person['name'];
                final relation = request['relation'] == 1
                    ? 'father'
                    : request['relation'] == 2
                    ? 'Mother'
                    : request['relation'] == 3
                    ? 'Spouse'
                    : request['relation'] == 4
                    ? 'Brother'
                    : request['relation'] == 5
                    ? 'Sister'
                    : request['relation'] == 6
                    ? 'Daughter'
                    : request['relation'] == 7
                    ? 'Son'
                    : 'Unknown'; // Example relation
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: person['profile_pic'] != null
                        ? NetworkImage(person['profile_pic'])
                        : AssetImage('assets/images/default_profile.png') as ImageProvider,
                  ),
                  title: Text(
                    'Request has been sent to $name as your $relation.',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontFamily: "Figtree",
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFF7B52C),
                        fontSize: 12.sp,
                        fontFamily: "Figtree",
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),

    ],




      ),
      ),
],
    ),
      )


    );
  }

  bool isToday(String date) {
    DateTime requestDate = DateTime.parse(date);
    DateTime today = DateTime.now();
    return requestDate.year == today.year &&
        requestDate.month == today.month &&
        requestDate.day == today.day;
  }

  bool isYesterday(String date) {
    DateTime requestDate = DateTime.parse(date);
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
    return requestDate.year == yesterday.year &&
        requestDate.month == yesterday.month &&
        requestDate.day == yesterday.day;
  }
}

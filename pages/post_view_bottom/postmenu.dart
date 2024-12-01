import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostMenuExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Post Menu Example'),
        backgroundColor: Colors.black,
        actions: [
          Spacer(),
          IconButton(
            onPressed: () {
              _showPopupMenu(context);
            },
            icon: Icon(CupertinoIcons.ellipsis_vertical, color: Colors.white),
          ),
        ],
      ),
      body: Center(
        child: Text('Post Content', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void _showPopupMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showSuccessSnackbar(context);
                },
                child: Text('Add to Gallery', style: TextStyle(color: Colors.white)),
              ),
              Divider(color: Colors.white),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Handle Hide action
                },
                child: Text('Hide', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSuccessSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(Icons.check, color: Colors.white),
          ),
          SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Successfully Added', style: TextStyle(color: Colors.white)),
              Text('Successfully added this post to your gallery.', style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12.0),
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}



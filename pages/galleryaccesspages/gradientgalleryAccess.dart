import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientGalleryAccess extends StatefulWidget {
  late final bool isReceivedSelected;
  late final ValueChanged<bool> onTabChange;
  GradientGalleryAccess({
    required this.isReceivedSelected,
    required this.onTabChange,
  });

  @override
  _GradientGalleryAccessState createState() => _GradientGalleryAccessState();
}

class _GradientGalleryAccessState extends State<GradientGalleryAccess> {
  bool isReceivedSelected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width:320.w ,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (!widget.isReceivedSelected) {
                  widget.onTabChange(true);
                }
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => GalleryAccessMain(), // Navigate to GalleryAccessMain
    //   ),
    // );
    },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  gradient: widget.isReceivedSelected
                      ? LinearGradient(colors: [Colors.yellow, Colors.orange])
                      : null,
                  color: !widget.isReceivedSelected ? Color(0xFF262626) : null,
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
                ),
                child: Text(
                  'Received',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: widget.isReceivedSelected ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
    if (widget.isReceivedSelected) {
      widget.onTabChange(false);
    }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  gradient: !widget.isReceivedSelected
                      ? LinearGradient(colors: [Colors.yellow, Colors.orange])
                      : null,
                  color: !widget.isReceivedSelected ? Color(0xFF262626) : null,
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(5)),
                ),
                child: Text(
                  'Sent',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: !widget.isReceivedSelected? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

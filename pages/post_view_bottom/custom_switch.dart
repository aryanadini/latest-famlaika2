import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool _isToggled = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isToggled = !_isToggled;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 60,
            height: 30,
            decoration: BoxDecoration(
              color: _isToggled ? Colors.grey : Colors.grey.shade900,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.amber, // Border color for the track
                width: 2.0,
              ),
            ),
          ),
          AnimatedAlign(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: _isToggled ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: Colors.amber, // Thumb color (yellow)
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey.shade900, // Border around the thumb
                  width: 2.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

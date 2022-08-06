import 'package:flutter/material.dart';

class ReasonIcon extends StatelessWidget {
  final String reason;
  final IconData icon;
  const ReasonIcon(
      {Key? key,
      required this.themeData,
      required this.reason,
      required this.icon})
      : super(key: key);

  final bool themeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: themeData ? Colors.black87 : Colors.white70,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          reason,
          style: TextStyle(
            color: themeData ? Colors.black54 : Colors.white54,
          ),
        )
      ],
    );
  }
}

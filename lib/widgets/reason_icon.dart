import 'package:flutter/material.dart';

class ReasonIcon extends StatelessWidget {
  final String reason;
  final IconData icon;
  const ReasonIcon({Key? key, required this.reason, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.black87,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          reason,
          style: TextStyle(
            color: Colors.black54,
          ),
        )
      ],
    );
  }
}

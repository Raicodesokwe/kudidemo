import 'package:flutter/material.dart';

class NextBtn extends StatelessWidget {
  const NextBtn({
    Key? key,
    required this.size,
    required this.label,
  }) : super(key: key);

  final Size size;

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: size.width * 0.4,
      child: Center(
        child: Text(
          label,
          style: TextStyle(color: Colors.black54),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 4, color: Colors.black54)),
    );
  }
}

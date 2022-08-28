import 'package:flutter/material.dart';

class NextneonBtn extends StatelessWidget {
  const NextneonBtn({Key? key, required this.size, required this.label})
      : super(key: key);

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
          style: TextStyle(color: Colors.black),
        ),
      ),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.green.withAlpha(225),
                blurRadius: 45,
                spreadRadius: 15,
                offset: Offset(0, 0))
          ],
          gradient: LinearGradient(
              colors: [Colors.green, Colors.greenAccent],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 4, color: Colors.black54)),
    );
  }
}

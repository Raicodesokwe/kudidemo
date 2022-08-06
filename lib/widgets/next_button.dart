import 'package:flutter/material.dart';

class NextBtn extends StatelessWidget {
  const NextBtn({
    Key? key,
    required this.size,
    required this.themeData,
  }) : super(key: key);

  final Size size;
  final bool themeData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: size.width * 0.4,
      child: Center(
        child: Text(
          'Next',
          style: TextStyle(color: themeData ? Colors.black : Colors.white),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 4, color: themeData ? Colors.black54 : Colors.white54)),
    );
  }
}

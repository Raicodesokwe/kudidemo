import 'package:flutter/material.dart';

class KeypadCircle extends StatelessWidget {
  final int number;
  final TextEditingController controller;
  const KeypadCircle({Key? key, required this.number, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final decorator = BoxDecoration(boxShadow: [
      BoxShadow(
          color: Theme.of(context).cardColor,
          offset: Offset(5, 5),
          blurRadius: 15,
          spreadRadius: 5),
      BoxShadow(
        spreadRadius: 1,
        color: Theme.of(context).canvasColor,
        offset: Offset(-5, -5),
        blurRadius: 15,
      )
    ]);
    return GestureDetector(
      onTap: () {
        controller.text += number.toString();
      },
      child: Container(
        height: 70,
        width: 70,
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(fontSize: 23),
          ),
        ),
        decoration: decorator.copyWith(
            shape: BoxShape.circle, color: Theme.of(context).backgroundColor),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({
    Key? key,
    required this.decorator,
    required this.themeData,
  }) : super(key: key);

  final BoxDecoration decorator;
  final bool themeData;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: decorator.copyWith(
                  color: themeData ? Colors.grey[300] : Colors.grey[900],
                  borderRadius: BorderRadius.circular(10.0)),
              height: 50,
              width: 50,
              child: Center(child: Icon(Icons.arrow_back_ios)),
            ),
          )),
    );
  }
}

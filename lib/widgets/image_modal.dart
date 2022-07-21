import 'package:flutter/material.dart';

class ImageModal extends StatelessWidget {
  const ImageModal(
      {Key? key,
      required this.themeData,
      required this.image,
      required this.task})
      : super(key: key);

  final bool themeData;
  final String image;
  final String task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: themeData ? Colors.white : Colors.black),
      child: Row(children: [
        SizedBox(
          width: 50,
          child: Image.asset(image),
        ),
        SizedBox(
          width: 20,
        ),
        Text(task)
      ]),
    );
  }
}

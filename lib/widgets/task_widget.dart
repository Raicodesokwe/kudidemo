import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget(
      {Key? key,
      required this.size,
      required this.decorator,
      required this.image,
      required this.task,
      required this.color})
      : super(key: key);

  final Size size;
  final BoxDecoration decorator;
  final String image;
  final String task;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              width: 100,
              child: Image.asset(
                image,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(task,
                style: GoogleFonts.prompt(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700))
          ],
        ),
        decoration: decorator.copyWith(
            color: color, borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
}
// "assets/images/tasks.png"
// 'Tasks'
// Colors.pink
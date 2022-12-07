import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    Key? key,
    required this.size,
    required this.decorator,
    required this.image,
    required this.task,
    this.count,
  }) : super(key: key);

  final Size size;
  final BoxDecoration decorator;
  final String image;
  final String task;
  final String? count;

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
              height: size.height * 0.015,
            ),
            Text(
              count ?? '',
              style: GoogleFonts.prompt(),
            ),
            Text(task,
                style: GoogleFonts.prompt(
                    fontSize: 20, fontWeight: FontWeight.w700))
          ],
        ),
        decoration: decorator.copyWith(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
}
// "assets/images/tasks.png"
// 'Tasks'
// Colors.pink
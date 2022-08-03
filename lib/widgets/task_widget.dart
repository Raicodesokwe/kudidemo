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
  }) : super(key: key);

  final Size size;
  final BoxDecoration decorator;
  final String image;
  final String task;

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeProvider>(context).darkTheme;
    final BoxDecoration decorator = BoxDecoration(
      boxShadow: themeData
          ? [
              BoxShadow(
                  color: Colors.grey.shade500,
                  offset: Offset(4, 4),
                  blurRadius: 15,
                  spreadRadius: 1),
              BoxShadow(
                spreadRadius: 1,
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 15,
              )
            ]
          : [
              BoxShadow(
                  color: Colors.black,
                  offset: Offset(5, 5),
                  blurRadius: 15,
                  spreadRadius: 5),
              BoxShadow(
                spreadRadius: 1,
                color: Colors.grey.shade800,
                offset: Offset(-4, -4),
                blurRadius: 15,
              )
            ],
    );
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
                    fontSize: 20, fontWeight: FontWeight.w700))
          ],
        ),
        decoration: decorator.copyWith(
            color: themeData ? Colors.grey[300] : Colors.grey[900],
            borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
}
// "assets/images/tasks.png"
// 'Tasks'
// Colors.pink
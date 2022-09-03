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
          ?
          //  [
          //     BoxShadow(
          //         color: const Color(0xFF120fb8),
          //         offset: Offset(5, 5),
          //         blurRadius: 15,
          //         spreadRadius: 5),
          //     BoxShadow(
          //       spreadRadius: 1,
          //       color: const Color(0xFF1815fa),
          //       offset: Offset(-5, -5),
          //       blurRadius: 15,
          //     )
          //   ]
          // [
          //     BoxShadow(
          //         color: const Color(0xFFb6b80f),
          //         offset: Offset(5, 5),
          //         blurRadius: 15,
          //         spreadRadius: 5),
          //     BoxShadow(
          //       spreadRadius: 1,
          //       color: const Color(0xFFf6fa15),
          //       offset: Offset(-5, -5),
          //       blurRadius: 15,
          //     )
          //   ]
          // [
          //     BoxShadow(
          //         color: const Color(0xFFb80f99),
          //         offset: Offset(5, 5),
          //         blurRadius: 15,
          //         spreadRadius: 5),
          //     BoxShadow(
          //       spreadRadius: 1,
          //       color: const Color(0xFFfa15cf),
          //       offset: Offset(-5, -5),
          //       blurRadius: 15,
          //     )
          //   ]
          // [
          //     BoxShadow(
          //         color: Colors.grey.shade500,
          //         offset: Offset(4, 4),
          //         blurRadius: 15,
          //         spreadRadius: 1),
          //     BoxShadow(
          //       spreadRadius: 1,
          //       color: Colors.white,
          //       offset: Offset(-4, -4),
          //       blurRadius: 15,
          //     )
          //   ]
          [
              BoxShadow(
                  color: const Color(0xFFb55525),
                  offset: Offset(11, 11),
                  blurRadius: 25,
                  spreadRadius: -1),
              BoxShadow(
                spreadRadius: -1,
                color: const Color(0xFFf57333),
                offset: Offset(-11, -11),
                blurRadius: 25,
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
            color: themeData ? const Color(0xFFd5642c) : Colors.grey[900],
            borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
}
// "assets/images/tasks.png"
// 'Tasks'
// Colors.pink
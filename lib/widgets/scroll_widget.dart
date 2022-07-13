import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScrollWidget extends StatelessWidget {
  const ScrollWidget({
    Key? key,
    required this.size,
    required this.decorator,
  }) : super(key: key);

  final Size size;
  final BoxDecoration decorator;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    width: 100,
                    child: Image.asset(
                      "assets/images/tasks.png",
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Text('Tasks',
                      style: GoogleFonts.prompt(
                          fontSize: 20, fontWeight: FontWeight.w700))
                ],
              ),
              decoration: decorator.copyWith(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
          SizedBox(
            width: size.width * 0.04,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  width: 100,
                  child: Image.asset(
                    "assets/images/habits.png",
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text('Habits',
                    style: GoogleFonts.prompt(
                        fontSize: 20, fontWeight: FontWeight.w700))
              ],
            ),
            decoration: decorator.copyWith(
                color: Colors.blue, borderRadius: BorderRadius.circular(10.0)),
          ),
          SizedBox(
            width: size.width * 0.06,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  width: 100,
                  child: Image.asset(
                    "assets/images/finances.png",
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text('Finances',
                    style: GoogleFonts.prompt(
                        fontSize: 20, fontWeight: FontWeight.w700))
              ],
            ),
            decoration: decorator.copyWith(
                color: Colors.green, borderRadius: BorderRadius.circular(10.0)),
          ),
          SizedBox(
            width: size.width * 0.06,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  width: 100,
                  child: Image.asset(
                    "assets/images/journal.png",
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text('Journal',
                    style: GoogleFonts.prompt(
                        fontSize: 20, fontWeight: FontWeight.w700))
              ],
            ),
            decoration: decorator.copyWith(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(10.0)),
          ),
          SizedBox(
            width: size.width * 0.06,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  width: 100,
                  child: Image.asset(
                    "assets/images/group.png",
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text('Group tasks',
                    style: GoogleFonts.prompt(
                        fontSize: 17, fontWeight: FontWeight.w700))
              ],
            ),
            decoration: decorator.copyWith(
                color: Colors.purpleAccent,
                borderRadius: BorderRadius.circular(10.0)),
          ),
          SizedBox(width: size.width * 0.06),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  width: 100,
                  child: Image.asset(
                    "assets/images/chat.png",
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text('Chat',
                    style: GoogleFonts.prompt(
                        fontSize: 20, fontWeight: FontWeight.w700))
              ],
            ),
            decoration: decorator.copyWith(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(10.0)),
          ),
          SizedBox(width: size.width * 0.06),
        ],
      ),
    );
  }
}

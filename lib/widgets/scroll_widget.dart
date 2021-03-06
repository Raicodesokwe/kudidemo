import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/widgets/task_widget.dart';

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
          TaskWidget(
            size: size,
            decorator: decorator,
            color: Colors.pink,
            task: 'Task',
            image: "assets/images/tasks.png",
          ),
          SizedBox(
            width: size.width * 0.04,
          ),
          TaskWidget(
            size: size,
            decorator: decorator,
            color: Colors.blue,
            task: 'Habits',
            image: "assets/images/habits.png",
          ),
          SizedBox(
            width: size.width * 0.06,
          ),
          TaskWidget(
            size: size,
            decorator: decorator,
            color: Colors.green,
            task: 'Finances',
            image: "assets/images/finances.png",
          ),
          SizedBox(
            width: size.width * 0.06,
          ),
          TaskWidget(
            size: size,
            decorator: decorator,
            color: Colors.orangeAccent,
            task: 'Journal',
            image: "assets/images/journal.png",
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
          TaskWidget(
            size: size,
            decorator: decorator,
            color: Colors.redAccent,
            task: 'Chat',
            image: "assets/images/chat.png",
          ),
          SizedBox(width: size.width * 0.06),
        ],
      ),
    );
  }
}

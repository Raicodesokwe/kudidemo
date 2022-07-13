import 'package:flutter/material.dart';
import 'package:kudidemo/widgets/task_view.dart';

class TaskModal extends StatelessWidget {
  const TaskModal({
    Key? key,
    required this.themeData,
  }) : super(key: key);

  final bool themeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => TaskView()));
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: themeData ? Colors.white : Colors.black),
              child: Row(children: [
                SizedBox(
                  width: 50,
                  child: Image.asset(
                    "assets/images/tasks.png",
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text('Tasks')
              ]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: themeData ? Colors.white : Colors.black),
            child: Row(children: [
              SizedBox(
                width: 50,
                child: Image.asset(
                  "assets/images/habits.png",
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text('Habits')
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: themeData ? Colors.white : Colors.black),
            child: Row(children: [
              SizedBox(
                width: 50,
                child: Image.asset(
                  "assets/images/finances.png",
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text('Finances')
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: themeData ? Colors.white : Colors.black),
            child: Row(children: [
              SizedBox(
                width: 50,
                child: Image.asset(
                  "assets/images/journal.png",
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text('Journal')
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: themeData ? Colors.white : Colors.black),
            child: Row(children: [
              SizedBox(
                width: 50,
                child: Image.asset(
                  "assets/images/group.png",
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text('Group tasks')
            ]),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: themeData ? Colors.white : Colors.black),
            child: Row(children: [
              SizedBox(
                width: 50,
                child: Image.asset(
                  "assets/images/chat.png",
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text('Chat')
            ]),
          ),
        ),
      ],
    );
  }
}

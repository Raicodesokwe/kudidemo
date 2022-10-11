import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/models/task_model.dart';
import 'package:kudidemo/providers/color_provider.dart';
import 'package:kudidemo/providers/task_provider.dart';
import 'package:kudidemo/widgets/circle_button.dart';
import 'package:kudidemo/widgets/neon_button.dart';
import 'package:kudidemo/widgets/notes_overlay.dart';
import 'package:kudidemo/widgets/subtask_overlay.dart';
import 'package:kudidemo/widgets/text_field.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../widgets/back_arrow.dart';
import '../widgets/color_overlay.dart';
import '../widgets/date_overlay.dart';

class TaskView extends StatefulWidget {
  TaskView({Key? key, this.task}) : super(key: key);

  TaskModel? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView>
    with SingleTickerProviderStateMixin {
  late String notes = '';
  final DateTime now = DateTime.now();
  late DateTime fromDate;
  late Color color;
  late DateTime toDate;
  int? reminder;
  late String repeat;

  TextEditingController taskNameController = TextEditingController();

  final _taskForm = GlobalKey<FormState>();

  checkFields() {
    final form = _taskForm.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  late AnimationController controller;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.task == null) {
      // fromDate = now;
      // toDate = now.add(Duration(hours: 1));
    }

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 950));
    fadeAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

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
    Size size = MediaQuery.of(context).size;
    Future createAlertDialog(BuildContext context) {
      return Platform.isIOS
          ? showCupertinoDialog(
              context: context,
              builder: (_) => DateOverlay(
                fromDate: fromDate,
                toDateString: toDate,
                reminder: reminder,
                repeat: repeat,
              ),
            )
          : showDialog(
              context: context,
              builder: (_) => DateOverlay(
                fromDate: fromDate,
                toDateString: toDate,
                reminder: reminder,
                repeat: repeat,
              ),
            );
    }

    Future createNotesDialog(BuildContext context) {
      return Platform.isIOS
          ? showCupertinoDialog(
              context: context,
              builder: (_) => NotesOverlay(),
            )
          : showDialog(
              context: context,
              builder: (_) => NotesOverlay(),
            );
    }

    Future selectColorDialog(BuildContext context) {
      return Platform.isIOS
          ? showCupertinoDialog(
              context: context,
              builder: (_) => ColorOverlay(
                color: color,
              ),
            )
          : showDialog(
              context: context,
              builder: (_) => ColorOverlay(
                color: color,
              ),
            );
    }

    fromDate = Provider.of<TaskProvider>(context).from!;
    toDate = Provider.of<TaskProvider>(context).to!;
    reminder = Provider.of<TaskProvider>(context).reminder!;
    repeat = Provider.of<TaskProvider>(context).repeat!;
    color = Provider.of<ColorProvider>(context).selectedColor!;

    Future saveForm() async {
      final isValid = _taskForm.currentState!.validate();
      if (isValid) {
        final task = TaskModel(
            name: taskNameController.text,
            from: fromDate,
            to: toDate,
            notes: notes,
            color: color.value,
            reminder: reminder,
            repeat: repeat);
        final taskProvider = Provider.of<TaskProvider>(context, listen: false);
        taskProvider.addTask(task);

        Navigator.of(context).pop();
      }
    }

    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: Form(
        key: _taskForm,
        child: FadeTransition(
          opacity: fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isKeyboard)
                BackArrow(
                  decorator: decorator,
                ),
              if (!isKeyboard)
                Center(
                  child: SizedBox(
                      width: size.width * 0.4,
                      child: Lottie.asset('assets/images/task.json')),
                ),
              SizedBox(
                height: size.height * 0.03,
              ),
              if (!isKeyboard)
                Text('Task',
                    style: TextStyle(
                        color: Theme.of(context).backgroundColor,
                        fontSize: 50,
                        shadows: const [
                          Shadow(
                              color: Color.fromARGB(255, 92, 202, 96),
                              blurRadius: 8),
                          Shadow(
                              color: Color.fromARGB(255, 92, 202, 96),
                              blurRadius: 10),
                          Shadow(
                              color: Color.fromARGB(255, 92, 202, 96),
                              blurRadius: 12),
                        ])),
              SizedBox(
                height: size.height * 0.03,
              ),
              CustomTextField(
                  controller: taskNameController,
                  emptytext: 'task name is required',
                  hintText: 'Task name'),
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        selectColorDialog(context);
                      },
                      child: Container(
                          padding: const EdgeInsets.all(7),
                          child: Center(
                              child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: color, shape: BoxShape.circle),
                          )),
                          decoration: decorator.copyWith(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        createAlertDialog(context);
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        child: Center(
                            child: Icon(Icons.calendar_month,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .color)),
                        decoration: decorator.copyWith(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return SubtaskOverlay();
                            });
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: decorator.copyWith(
                            color: Theme.of(context).backgroundColor,
                            shape: BoxShape.circle),
                        child: Icon(
                          FontAwesomeIcons.codeBranch,
                          color: Theme.of(context).textTheme.bodyText2!.color,
                          size: 15,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return NotesOverlay();
                            });
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        child: Center(
                            child: Icon(Icons.note_alt,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .color)),
                        decoration: decorator.copyWith(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.2,
              ),
              GestureDetector(
                  onTap: () => saveForm(),
                  child: taskNameController.text.isNotEmpty
                      ? NeonButton()
                      : CircleButton())
            ],
          ),
        ),
      ),
    );
  }
}

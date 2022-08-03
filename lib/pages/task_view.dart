import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/models/task_model.dart';
import 'package:kudidemo/providers/task_provider.dart';
import 'package:kudidemo/widgets/circle_button.dart';
import 'package:kudidemo/widgets/neon_button.dart';
import 'package:kudidemo/widgets/notes_overlay.dart';
import 'package:kudidemo/widgets/text_field.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../utils/utils.dart';
import '../widgets/back_arrow.dart';
import '../widgets/color_overlay.dart';
import '../widgets/funky_overlay.dart';

class TaskView extends StatefulWidget {
  TaskView({Key? key, this.task}) : super(key: key);

  TaskModel? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late String notes = '';
  final DateTime now = DateTime.now();
  late DateTime fromDate;
  late Color color = Colors.green.shade200;
  late DateTime toDate;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.task == null) {
      fromDate = now;
      toDate = now.add(Duration(hours: 1));
    }
  }

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
    Size size = MediaQuery.of(context).size;
    Future createAlertDialog(BuildContext context) {
      return showDialog(
        context: context,
        builder: (_) => FunkyOverlay(
          fromDate: fromDate,
          toDateString: toDate,
        ),
      );
    }

    Future createNotesDialog(BuildContext context) {
      return showDialog(
        context: context,
        builder: (_) => NotesOverlay(),
      );
    }

    Future selectColorDialog(BuildContext context) {
      return showDialog(
        context: context,
        builder: (_) => ColorOverlay(
          color: color,
        ),
      );
    }

    Future saveForm() async {
      final isValid = _taskForm.currentState!.validate();
      if (isValid) {
        final task = TaskModel(
            name: taskNameController.text,
            from: fromDate,
            to: toDate,
            notes: notes,
            color: color);
        final taskProvider = Provider.of<TaskProvider>(context, listen: false);
        taskProvider.addTask(task);
        Navigator.of(context).pop();
      }
    }

    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: Form(
        key: _taskForm,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isKeyboard)
              BackArrow(decorator: decorator, themeData: themeData),
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
                      color: themeData ? Colors.grey[300] : Colors.grey[900],
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
                      selectColorDialog(context).then((value) {
                        color = value;
                        setState(() {});
                      });
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
                            color:
                                themeData ? Colors.grey[300] : Colors.grey[900],
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      createAlertDialog(context).then((value) {
                        fromDate = value['from'];
                        toDate = value['to'];
                        setState(() {});
                      });
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      child: Center(
                          child: Icon(
                        Icons.calendar_month,
                        color: themeData ? Colors.black54 : Colors.white54,
                      )),
                      decoration: decorator.copyWith(
                          color:
                              themeData ? Colors.grey[300] : Colors.grey[900],
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 35,
                    decoration: decorator.copyWith(
                        color: themeData ? Colors.grey[300] : Colors.grey[900],
                        shape: BoxShape.circle),
                    child: Icon(
                      FontAwesomeIcons.codeBranch,
                      color: themeData ? Colors.black54 : Colors.white60,
                      size: 15,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      createNotesDialog(context).then((value) {
                        notes = value;
                        setState(() {});
                      });
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      child: Center(
                          child: Icon(
                        Icons.note_alt,
                        color: themeData ? Colors.black54 : Colors.white54,
                      )),
                      decoration: decorator.copyWith(
                          color:
                              themeData ? Colors.grey[300] : Colors.grey[900],
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class TaskView extends StatelessWidget {
  TaskView({Key? key}) : super(key: key);

  late String taskName;

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

    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: Form(
        key: _taskForm,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                decoration: decorator.copyWith(
                    color: themeData ? Colors.grey[300] : Colors.grey[900],
                    borderRadius: BorderRadius.circular(10.0)),
                child: TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'task name is required' : null,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                  cursorColor: Colors.black45,
                  decoration: InputDecoration(
                      hintText: 'Task name',
                      hintStyle: GoogleFonts.prompt(),
                      border: InputBorder.none),
                )),
            SizedBox(
              height: size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Text(
                          'No category',
                          style: TextStyle(
                              color:
                                  themeData ? Colors.black45 : Colors.white54,
                              fontSize: 10,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      decoration: decorator.copyWith(
                          color:
                              themeData ? Colors.grey[300] : Colors.grey[900],
                          borderRadius: BorderRadius.circular(30))),
                  Container(
                    height: 35,
                    width: 35,
                    child: Center(
                        child: Icon(
                      Icons.calendar_month,
                      color: themeData ? Colors.black54 : Colors.white54,
                    )),
                    decoration: decorator.copyWith(
                        color: themeData ? Colors.grey[300] : Colors.grey[900],
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  Container(
                    height: 35,
                    width: 35,
                    decoration: decorator.copyWith(
                        color: themeData ? Colors.grey[300] : Colors.grey[900],
                        shape: BoxShape.circle),
                    child: Image.asset(
                      "assets/images/arrow.png",
                      color: themeData ? Colors.black54 : Colors.white54,
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 35,
                    child: Center(
                        child: Icon(
                      Icons.note_alt,
                      color: themeData ? Colors.black54 : Colors.white54,
                    )),
                    decoration: decorator.copyWith(
                        color: themeData ? Colors.grey[300] : Colors.grey[900],
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.2,
            ),
            Container(
              child: Center(
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Center(
                    child: Icon(
                      Icons.send,
                      color: themeData ? Colors.black54 : Colors.white54,
                      size: 50,
                    ),
                  ),
                ),
              ),
              height: 100,
              width: 100,
              decoration: decorator.copyWith(
                  color: themeData ? Colors.grey[300] : Colors.grey[900],
                  border: Border.all(
                      width: 10,
                      color: themeData ? Colors.black54 : Colors.white54),
                  shape: BoxShape.circle),
            )
          ],
        ),
      ),
    );
  }
}

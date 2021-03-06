import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class HabitsPage extends StatelessWidget {
  HabitsPage({Key? key}) : super(key: key);

  late String habitsName;

  TextEditingController habitsNameController = TextEditingController();
  final _habitsForm = GlobalKey<FormState>();
  checkFields() {
    final form = _habitsForm.currentState;
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
        key: _habitsForm,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isKeyboard)
              Center(
                child: SizedBox(
                    width: size.width * 0.4,
                    child: Lottie.asset('assets/images/habit.json')),
              ),
            SizedBox(
              height: size.height * 0.03,
            ),
            if (!isKeyboard)
              Text('Habits',
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
                      value!.isEmpty ? 'habit name is required' : null,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                  cursorColor: Colors.black45,
                  decoration: InputDecoration(
                      hintText: 'Habit name',
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
                      padding: const EdgeInsets.all(7),
                      child: Center(
                          child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 92, 202, 96),
                            shape: BoxShape.circle),
                      )),
                      decoration: decorator.copyWith(
                          color:
                              themeData ? Colors.grey[300] : Colors.grey[900],
                          borderRadius: BorderRadius.circular(30))),
                  Container(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Text(
                          'Daily goal',
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
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Row(
                          children: [
                            Icon(
                              Icons.repeat_on_sharp,
                              color:
                                  themeData ? Colors.black54 : Colors.white54,
                              size: 12,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Repeat',
                              style: TextStyle(
                                  color: themeData
                                      ? Colors.black45
                                      : Colors.white54,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                      decoration: decorator.copyWith(
                          color:
                              themeData ? Colors.grey[300] : Colors.grey[900],
                          borderRadius: BorderRadius.circular(30))),
                  Container(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Text(
                          'Routine',
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

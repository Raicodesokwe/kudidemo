import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class FinancesPage extends StatelessWidget {
  FinancesPage({Key? key}) : super(key: key);

  late String habitsName;

  TextEditingController habitsNameController = TextEditingController();
  final _financesForm = GlobalKey<FormState>();
  checkFields() {
    final form = _financesForm.currentState;
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
        key: _financesForm,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isKeyboard)
              Center(
                child: SizedBox(
                    width: size.width * 0.4,
                    child: Lottie.asset('assets/images/finances.json')),
              ),
            SizedBox(
              height: size.height * 0.03,
            ),
            if (!isKeyboard)
              Text('Finances',
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
                      value!.isEmpty ? 'currency is required' : null,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                  cursorColor: Colors.black45,
                  decoration: InputDecoration(
                      hintText: 'Currency name',
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
                        child: Row(
                          children: [
                            Icon(
                              Icons.money_outlined,
                              color:
                                  themeData ? Colors.black54 : Colors.white54,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Expenses',
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
                        child: Row(
                          children: [
                            Icon(
                              Icons.currency_exchange_sharp,
                              color:
                                  themeData ? Colors.black54 : Colors.white54,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Income',
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
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.chartLine,
                              color:
                                  themeData ? Colors.black54 : Colors.white54,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Trend',
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
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.piggyBank,
                            color: themeData ? Colors.black54 : Colors.white54,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Savings',
                            style: TextStyle(
                                color:
                                    themeData ? Colors.black45 : Colors.white54,
                                fontSize: 10,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                    decoration: decorator.copyWith(
                        color: themeData ? Colors.grey[300] : Colors.grey[900],
                        borderRadius: BorderRadius.circular(30))),
                Container(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/budget.png',
                            scale: 6,
                            color: themeData ? Colors.black54 : Colors.white54,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Budget',
                            style: TextStyle(
                                color:
                                    themeData ? Colors.black45 : Colors.white54,
                                fontSize: 10,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                    decoration: decorator.copyWith(
                        color: themeData ? Colors.grey[300] : Colors.grey[900],
                        borderRadius: BorderRadius.circular(30))),
              ],
            ),
            SizedBox(
              height: size.height * 0.15,
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

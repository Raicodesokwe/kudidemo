import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/widgets/circle_button.dart';
import 'package:kudidemo/widgets/oval_icon_container.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../widgets/back_arrow.dart';
import '../widgets/text_field.dart';

class FinancesPage extends StatefulWidget {
  FinancesPage({Key? key}) : super(key: key);

  @override
  State<FinancesPage> createState() => _FinancesPageState();
}

class _FinancesPageState extends State<FinancesPage>
    with SingleTickerProviderStateMixin {
  TextEditingController currencyNameController = TextEditingController();

  final _financesForm = GlobalKey<FormState>();

  checkFields() {
    final form = _financesForm.currentState;
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
    super.initState();

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
        child: FadeTransition(
          opacity: fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isKeyboard)
                BackArrow(decorator: decorator, themeData: themeData),
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
              CustomTextField(
                  controller: currencyNameController,
                  emptytext: 'currency is required',
                  hintText: 'Currency name'),
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OvalIconContainer(
                      text: 'Expenses',
                      icon: Icons.money_outlined,
                      size: 15,
                    ),
                    OvalIconContainer(
                      text: 'Income',
                      icon: Icons.currency_exchange_sharp,
                      size: 15,
                    ),
                    OvalIconContainer(
                      text: 'Trend',
                      icon: FontAwesomeIcons.chartLine,
                      size: 15,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OvalIconContainer(
                    text: 'Savings',
                    icon: FontAwesomeIcons.piggyBank,
                    size: 15,
                  ),
                  Container(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/budget.png',
                              scale: 6,
                              color:
                                  themeData ? Colors.black54 : Colors.white54,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Budget',
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
              SizedBox(
                height: size.height * 0.12,
              ),
              CircleButton()
            ],
          ),
        ),
      ),
    );
  }
}

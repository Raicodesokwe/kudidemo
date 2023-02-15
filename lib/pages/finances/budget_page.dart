import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../providers/expense_provider.dart';
import '../../widgets/back_arrow.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({Key? key}) : super(key: key);

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
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Column(
      children: [
        if (!isKeyboard)
          BackArrow(
            decorator: decorator,
          ),
        if (!isKeyboard) Lottie.asset('assets/images/budget.json'),
        SizedBox(
          height: size.height * 0.03,
        ),
        if (!isKeyboard)
          Text('Budget',
              style: TextStyle(
                  color: Theme.of(context).backgroundColor,
                  fontSize: 50,
                  shadows: const [
                    Shadow(
                        color: Color.fromARGB(255, 92, 202, 96), blurRadius: 8),
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
        Padding(
          padding: const EdgeInsets.only(right: 40),
          child: SizedBox(
            height: size.height * 0.15,
            child: Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(
                'assets/images/arrow.svg',
                color: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .color!
                    .withOpacity(0.5),
                height: size.height * 0.25,
              ),
            ),
          ),
        )
      ],
    );
  }
}

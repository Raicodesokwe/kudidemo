import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/pages/finances/budget_view.dart';
import 'package:kudidemo/providers/budget_provider.dart';
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
    return Consumer<BudgetProvider>(
        child: Column(
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
        ),
        builder: (context, notifier, child) {
          if (notifier.budgetItems.isEmpty) {
            return child!;
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FutureBuilder(
                  future: Provider.of<BudgetProvider>(context).getBudgetItems(),
                  builder: (context, snapshot) {
                    return Consumer<BudgetProvider>(
                        builder: (context, notifier, child) {
                      if (notifier.budgetItems.isEmpty) {
                        return child!;
                      }
                      return Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(width: 3),
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Budget items',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: notifier.budgetItems.length,
                              itemBuilder: (context, index) {
                                final budgetItem = notifier.budgetItems[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => BudgetView(
                                                    amount: budgetItem.amount!,
                                                  )));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: decorator.copyWith(
                                          color:
                                              Theme.of(context).backgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Text(budgetItem.name!),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      '${expenseProvider.currency} ${budgetItem.amount}')
                                                ],
                                              ),
                                              Spacer(),
                                              budgetItem.budgetType == 'Closed'
                                                  ? Icon(FontAwesomeIcons
                                                      .doorClosed)
                                                  : Icon(
                                                      FontAwesomeIcons.doorOpen)
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Add expenses to\nthis budget item',
                                                style: GoogleFonts.prompt(),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.greenAccent,
                                                      border: Border.all()),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.black,
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            decoration: decorator.copyWith(
                                              color: Theme.of(context)
                                                  .backgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            child: LinearProgressIndicator(
                                              minHeight: 10,
                                              backgroundColor: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .color,
                                              valueColor:
                                                  new AlwaysStoppedAnimation<
                                                          Color>(
                                                      Colors.greenAccent),
                                              value: 0.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ],
                      );
                    });
                  }),
            ),
          );
        });
  }
}

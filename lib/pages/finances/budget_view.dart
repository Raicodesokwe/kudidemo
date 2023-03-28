import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../providers/expense_provider.dart';

class BudgetView extends StatelessWidget {
  final double amount;
  const BudgetView({Key? key, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat.decimalPattern();
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
    return SafeArea(
        child: Scaffold(
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                extendedSizeConstraints: BoxConstraints.tightFor(
          height: size.height * 0.07,
          width: size.width * 0.45,
        ))),
        child: FloatingActionButton.extended(
            backgroundColor: Colors.greenAccent,
            elevation: 7,
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {},
            label: Text(
              'Add expense',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.black),
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
                child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            FontAwesomeIcons.moneyBill,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Balance',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Text(
                          expenseProvider.currency,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        numberFormat.format(amount),
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      'Here is your balance',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            FontAwesomeIcons.moneyBillTransfer,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: 7,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expense',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                  constraints: BoxConstraints(maxWidth: 50),
                                  child: Text(
                                    expenseProvider.currency,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                numberFormat.format(0.0),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                      Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            FontAwesomeIcons.moneyBillTrendUp,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: 7,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Income',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                  constraints: BoxConstraints(maxWidth: 50),
                                  child: Text(
                                    expenseProvider.currency,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                numberFormat.format(0.0),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              width: double.infinity,
              decoration: decorator.copyWith(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.greenAccent),
            )),
            SizedBox(
              height: size.height * 0.03,
            ),
            Center(
              child: Text(
                'Expenses',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                'Start by recording your expenses for this budget',
                style: GoogleFonts.prompt(),
              ),
            ),
            SizedBox(
                height: size.height * 0.2,
                child: Lottie.asset('assets/images/budget.json')),
            SizedBox(
              height: size.height * 0.03,
            ),
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
      ),
    ));
  }
}

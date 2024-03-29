import 'package:flutter/material.dart';
import 'package:currency_picker/currency_picker.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kudidemo/navbar/navbar.dart';
import 'package:kudidemo/pages/finances/view_details.dart';

import 'package:kudidemo/providers/expense_provider.dart';
import 'package:kudidemo/providers/habits_provider.dart';
import 'package:kudidemo/utils/utils.dart';

import 'package:kudidemo/widgets/oval_icon_container.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/theme_provider.dart';
import '../../widgets/back_arrow.dart';
import '../../widgets/finances/expense_box.dart';
import '../../widgets/finances/expense_income_list.dart';
import '../../widgets/finances/income_box.dart';
import '../../widgets/text_field.dart';

class ExpenseIncome extends StatefulWidget {
  const ExpenseIncome({Key? key}) : super(key: key);

  @override
  State<ExpenseIncome> createState() => _ExpenseIncomeState();
}

class _ExpenseIncomeState extends State<ExpenseIncome> {
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

  String currency = 'Select currency';
  int selectedTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      late String _searchText = _controller.text;
    });
  }

  final _controller = TextEditingController();
  final _kCurrency = "currency_preference";
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
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => BottomNavBar()));
        expenseProvider.filtered = false;
        return Future.value(false);
      },
      child: FutureBuilder(
          future: Provider.of<ExpenseProvider>(context, listen: false)
              .getExpenses(),
          builder: (context, snapshot) {
            return Consumer<ExpenseProvider>(
                child: Form(
                  key: _financesForm,
                  child: Column(
                    children: [
                      if (!isKeyboard)
                        BackArrow(
                          decorator: decorator,
                        ),
                      if (!isKeyboard)
                        Center(
                          child: SizedBox(
                              width: size.width * 0.4,
                              child:
                                  Lottie.asset('assets/images/finances.json')),
                        ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      if (!isKeyboard)
                        Text('Finances',
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
                      GestureDetector(
                          onTap: () {
                            showCurrencyPicker(
                              context: context,
                              showFlag: true,
                              showCurrencyName: true,
                              showCurrencyCode: true,
                              onSelect: (Currency curr) {
                                print('Select currency: ${curr.symbol}');
                                expenseProvider.currency = curr.symbol;
                                setState(() {
                                  currency = curr.symbol;
                                });
                              },
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            height: 50,
                            width: size.width * 0.8,
                            decoration: decorator.copyWith(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    currency,
                                    style: GoogleFonts.prompt(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .color!
                                            .withOpacity(0.5)),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .color!
                                        .withOpacity(0.5),
                                  )
                                ],
                              ),
                            ),
                          )
                          //  CustomTextField(
                          //     controller: currencyNameController,
                          //     emptytext: 'currency is required',
                          //     hintText: 'Currency name'),
                          ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (currency == 'Select currency') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .color,
                                          content: Text(
                                            'Add currency',
                                            style: TextStyle(
                                                fontFamily: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .fontFamily!),
                                          )));
                                } else {
                                  var prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString(_kCurrency, currency.trim());
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      backgroundColor:
                                          Theme.of(context).backgroundColor,
                                      context: context,
                                      builder: (context) {
                                        return ExpenseBox(
                                            size: size,
                                            decorator: decorator,
                                            controller: _controller);
                                      });
                                }
                              },
                              child: OvalIconContainer(
                                text: 'Expenses',
                                icon: Icons.money_outlined,
                                size: 15,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (currency == 'Select currency') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .color,
                                          content: Text(
                                            'Add currency',
                                            style: TextStyle(
                                                fontFamily: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .fontFamily!),
                                          )));
                                } else {
                                  var prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString(_kCurrency, currency.trim());
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      backgroundColor:
                                          Theme.of(context).backgroundColor,
                                      context: context,
                                      builder: (context) {
                                        return IncomeBox(
                                            size: size,
                                            decorator: decorator,
                                            controller: _controller);
                                      });
                                }
                              },
                              child: OvalIconContainer(
                                text: 'Income',
                                icon: Icons.currency_exchange_sharp,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                builder: (context, notifier, child) {
                  NumberFormat numberFormat = NumberFormat.decimalPattern();
                  final expenseList = notifier.expenseitems
                      .where((element) => element.status == 'expense');
                  double expenseAmount = expenseList.fold(
                      0,
                      (previousValue, element) =>
                          previousValue + element.amount!);
                  final incomeList = notifier.expenseitems
                      .where((element) => element.status == 'income');
                  double incomeAmount = incomeList.fold(
                      0,
                      (previousValue, element) =>
                          previousValue + element.amount!);
                  final balanceAmount = incomeAmount - expenseAmount;

                  if (notifier.expenseitems.isEmpty &&
                      notifier.filtered == false) {
                    return child!;
                  }

                  return ExpenseIncomeList(
                      decorator: decorator,
                      notifier: notifier,
                      numberFormat: numberFormat,
                      balanceAmount: balanceAmount,
                      expenseAmount: expenseAmount,
                      incomeAmount: incomeAmount);
                });
          }),
    );
  }
}

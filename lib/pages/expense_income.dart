import 'package:flutter/material.dart';
import 'package:currency_picker/currency_picker.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/models/expense_model.dart';
import 'package:kudidemo/pages/expense_page.dart';
import 'package:kudidemo/providers/expense_provider.dart';
import 'package:kudidemo/providers/habits_provider.dart';
import 'package:kudidemo/widgets/add_expense_overlay.dart';

import 'package:kudidemo/widgets/circle_button.dart';
import 'package:kudidemo/widgets/oval_icon_container.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../widgets/back_arrow.dart';
import '../widgets/text_field.dart';

class ExpenseIncome extends StatefulWidget {
  const ExpenseIncome({Key? key}) : super(key: key);

  @override
  State<ExpenseIncome> createState() => _ExpenseIncomeState();
}

class _ExpenseIncomeState extends State<ExpenseIncome>
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
  String currency = 'Select currency';
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 950));
    fadeAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.addListener(() {
      setState(() {});
    });
    _controller.addListener(
      () {
        setState(() {
          _searchText = _controller.text;
        });
      },
    );
    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    _controller.dispose();
  }

  final _controller = TextEditingController();

  late String _searchText = _controller.text;
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
    return Consumer<ExpenseProvider>(
        child: Form(
          key: _financesForm,
          child: FadeTransition(
            opacity: fadeAnimation,
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
                        child: Lottie.asset('assets/images/finances.json')),
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
                            currency = curr.name;
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              backgroundColor:
                                  Theme.of(context).backgroundColor,
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: size.height * 0.7,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 5),
                                            width: size.width * 0.8,
                                            decoration: decorator.copyWith(
                                                color: Theme.of(context)
                                                    .backgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: TextFormField(
                                              controller: _controller,
                                              onChanged: ((value) {
                                                Provider.of<ExpenseProvider>(
                                                        context,
                                                        listen: false)
                                                    .changeSearchString(value);
                                              }),
                                              validator: (value) =>
                                                  value!.isEmpty
                                                      ? 'no text'
                                                      : null,
                                              keyboardType: TextInputType.text,
                                              cursorColor: Colors.black45,
                                              style: GoogleFonts.prompt(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .color),
                                              decoration: InputDecoration(
                                                  hintText: 'Search',
                                                  hintStyle:
                                                      GoogleFonts.prompt(),
                                                  border: InputBorder.none),
                                            )),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (ctx) {
                                                    return AddExpenseOverlay();
                                                  });
                                            },
                                            child: Container(
                                              child: Center(
                                                child: Text('Add custom'),
                                              ),
                                              height: 50,
                                              width: size.width * 0.4,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .color!),
                                                  color: Colors.greenAccent),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Consumer<ExpenseProvider>(builder:
                                            (context, expenseList, child) {
                                          return ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                expenseList.expenses.length,
                                            itemBuilder: (context, index) {
                                              final expenseItem =
                                                  expenseList.expenses[index];
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ListTile(
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      ExpensePage(
                                                                        expenseImage:
                                                                            expenseItem.image,
                                                                        expenseName:
                                                                            expenseItem.name,
                                                                        tileColor:
                                                                            expenseItem.color,
                                                                      )));
                                                    },
                                                    leading: Container(
                                                      height: 50,
                                                      width: 50,
                                                      child: Image.asset(
                                                        expenseItem.image,
                                                        scale: 2,
                                                      ),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 2,
                                                              color: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .color!),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: expenseItem
                                                              .color),
                                                    ),
                                                    title: Text(
                                                      expenseItem.name,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .fontFamily,
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .color),
                                                    ),
                                                    trailing: Icon(Icons
                                                        .arrow_forward_ios),
                                                  ),
                                                  Divider()
                                                ],
                                              );
                                            },
                                          );
                                        })
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: OvalIconContainer(
                          text: 'Expenses',
                          icon: Icons.money_outlined,
                          size: 15,
                        ),
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
                                color: Colors.black54,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Budget',
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                        decoration: decorator.copyWith(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(30))),
                  ],
                ),
              ],
            ),
          ),
        ),
        builder: (context, notifier, child) {
          if (notifier.expenseitems.isEmpty) {
            return child!;
          }
          return Center(
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: notifier.expenseitems.length,
                itemBuilder: ((context, index) {
                  return Text(
                    'bana',
                    style: TextStyle(color: Colors.red),
                  );
                })),
          );
        });
  }
}

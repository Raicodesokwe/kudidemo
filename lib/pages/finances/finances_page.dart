import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:kudidemo/pages/finances/budget_page.dart';
import 'package:kudidemo/pages/finances/expense_income.dart';

import 'package:kudidemo/pages/finances/savings_page.dart';
import 'package:kudidemo/pages/finances/trends_page.dart';
import 'package:kudidemo/widgets/finances/new_expense_income.dart';
import 'package:provider/provider.dart';

import '../../providers/expense_provider.dart';
import '../../widgets/add_icon.dart';

class FinancesPage extends StatefulWidget {
  FinancesPage({Key? key}) : super(key: key);

  @override
  State<FinancesPage> createState() => _FinancesPageState();
}

class _FinancesPageState extends State<FinancesPage> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      ExpenseIncome(),
      BudgetPage(),
      SavingsPage(),
      TrendsPage()
    ];
    int pageIndex = 0;
    List<Widget> items = [
      // AddIcon(
      //   selectedTab: selectedTab,
      //   selected: selectedTab == 0,
      // ),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              height: 36,
              width: 36,
              child: Icon(
                FontAwesomeIcons.wallet,
                color: selectedTab == 0 ? Colors.green : Colors.black,
              )),
          Text(
            'Add',
            style: TextStyle(
                color: selectedTab == 0 ? Colors.green : Colors.black),
          )
        ],
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              height: 36,
              width: 36,
              child: Icon(
                FontAwesomeIcons.moneyCheck,
                color: selectedTab == 1 ? Colors.green : Colors.black,
              )),
          Text(
            'Budget',
            style: TextStyle(
                color: selectedTab == 1 ? Colors.green : Colors.black),
          )
        ],
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              height: 36,
              width: 36,
              child: Icon(
                FontAwesomeIcons.piggyBank,
                color: selectedTab == 2 ? Colors.green : Colors.black,
              )),
          Text(
            'Savings',
            style: TextStyle(
                color: selectedTab == 2 ? Colors.green : Colors.black),
          )
        ],
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              height: 36,
              width: 36,
              child: Icon(
                FontAwesomeIcons.chartLine,
                color: selectedTab == 3 ? Colors.green : Colors.black,
              )),
          Text(
            'Trend',
            style: TextStyle(
                color: selectedTab == 3 ? Colors.green : Colors.black),
          )
        ],
      ),
    ];
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
    final expenseProvider = Provider.of<ExpenseProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
          floatingActionButton: expenseProvider.expenseitems.isEmpty &&
                  !expenseProvider.filtered
              ? Container()
              : Theme(
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
                        color: Theme.of(context).textTheme.bodyText2!.color,
                      ),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        expenseProvider.inputWidget = true;

                        showDialog(
                                context: context,
                                builder: (context) {
                                  return NewExpenseIncomeOverlay();
                                })
                            .then((value) => expenseProvider.filtered = false);
                      },
                      label: Text(
                        selectedTab == 0 ? 'Add new' : 'brrr',
                        style: Theme.of(context).textTheme.bodyText2,
                      )),
                ),
          extendBody: true,
          bottomNavigationBar: AnimatedSwitcher(
            key: ValueKey<int>(selectedTab),
            duration: Duration(milliseconds: 450),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    items.length,
                    (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = index;
                          });
                        },
                        child: items[index])),
              ),
              padding: const EdgeInsets.all(12),
              margin: EdgeInsets.only(left: 24, right: 24, bottom: 24),
              decoration: decorator.copyWith(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(24)),
            ),
          ),
          body: PageTransitionSwitcher(
            duration: Duration(seconds: 1),
            transitionBuilder: (child, animation, secondaryAnimation) {
              return FadeThroughTransition(
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            child: IndexedStack(
              index: selectedTab,
              key: ValueKey<int>(selectedTab),
              children: List.generate(pages.length, (index) {
                return pages[index];
              }),
            ),
          )),
    );
  }
}

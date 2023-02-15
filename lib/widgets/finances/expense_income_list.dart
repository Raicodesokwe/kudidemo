import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kudidemo/widgets/finances/filter_date.dart';
import 'package:lottie/lottie.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../navbar/navbar.dart';
import '../../pages/finances/view_details.dart';
import '../../providers/expense_provider.dart';
import '../../utils/utils.dart';

class ExpenseIncomeList extends StatefulWidget {
  const ExpenseIncomeList({
    Key? key,
    required this.decorator,
    required this.notifier,
    required this.numberFormat,
    required this.balanceAmount,
    required this.expenseAmount,
    required this.incomeAmount,
  }) : super(key: key);

  final BoxDecoration decorator;
  final ExpenseProvider notifier;
  final NumberFormat numberFormat;
  final double balanceAmount;
  final double expenseAmount;
  final double incomeAmount;

  @override
  State<ExpenseIncomeList> createState() => _ExpenseIncomeListState();
}

class _ExpenseIncomeListState extends State<ExpenseIncomeList> {
  bool filterSelected = false;
  String currency = 'Select currency';
  final _kCurrency = "currency_preference";

  @override
  Widget build(BuildContext context) {
    void setCurr() async {
      var prefs = await SharedPreferences.getInstance();
      prefs.setString(_kCurrency, currency.trim());
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    widget.notifier.filtered = false;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BottomNavBar()));
                  },
                  child: Container(
                    decoration: widget.decorator.copyWith(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    height: 50,
                    width: 50,
                    child: Center(
                        child: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).textTheme.bodyText2!.color,
                    )),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return FilterDate(
                            notifier: widget.notifier,
                          );
                        });
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    child: Center(
                      child: Icon(FontAwesomeIcons.calendarCheck),
                    ),
                    decoration: widget.decorator.copyWith(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      showCurrencyPicker(
                        context: context,
                        showFlag: true,
                        showCurrencyName: true,
                        showCurrencyCode: true,
                        onSelect: (Currency curr) {
                          print('Select currency: ${curr.symbol}');
                          widget.notifier.currency = curr.symbol;
                          setState(() {
                            currency = curr.symbol;
                            setCurr();
                          });
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.notifier.currency,
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.change_circle_outlined,
                            size: 15,
                          )
                        ],
                      ),
                      decoration: widget.decorator.copyWith(
                          borderRadius: BorderRadius.circular(7),
                          color: Theme.of(context).backgroundColor),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
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
                          widget.notifier.currency,
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
                        widget.numberFormat.format(widget.balanceAmount),
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
                                    widget.notifier.currency,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.numberFormat
                                    .format(widget.expenseAmount),
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
                                    widget.notifier.currency,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.numberFormat.format(widget.incomeAmount),
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
              decoration: widget.decorator.copyWith(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.greenAccent),
            )),
            SizedBox(
              height: 35,
            ),
            Text(
              'Recent expenses and income',
            ),
            SizedBox(
              height: 10,
            ),
            widget.notifier.expenseitems.isEmpty && widget.notifier.filtered
                ? Center(
                    child: Column(
                      children: [
                        Lottie.asset('assets/images/empty.json'),
                        Text('Oops,it\'s empty',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 9, 131, 13)))
                      ],
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.notifier.expenseitems.length,
                    itemBuilder: ((context, index) {
                      final listItem = widget.notifier.expenseitems[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ViewDetails(
                                      expenseItem: listItem,
                                    )));
                          },
                          child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: widget.decorator.copyWith(
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Container(
                                    height: 45,
                                    width: 45,
                                    child: Icon(
                                      listItem.status == 'income'
                                          ? FontAwesomeIcons.moneyBillTrendUp
                                          : FontAwesomeIcons.moneyBillTransfer,
                                      color: Colors.black,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        border: Border.all(width: 2),
                                        shape: BoxShape.circle),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        listItem.category!,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        Utils.toDate(listItem.date!),
                                        style: GoogleFonts.prompt(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color:
                                                  listItem.status == 'expense'
                                                      ? Colors.redAccent
                                                          .withOpacity(0.3)
                                                      : Colors.lightGreenAccent
                                                          .withOpacity(0.3)),
                                          child: Text(listItem.status!))
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      listItem.status == 'expense'
                                          ? Text(
                                              '-${widget.numberFormat.format(listItem.amount)}')
                                          : Text(
                                              '${widget.numberFormat.format(listItem.amount)}'),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(widget.notifier.currency)
                                    ],
                                  )
                                ],
                              )),
                        ),
                      );
                    })),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }
}

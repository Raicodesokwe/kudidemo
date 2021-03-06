import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:kudidemo/theme/changethemebtn.dart';
import 'package:kudidemo/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/date_container.dart';
import '../widgets/scroll_widget.dart';
import '../widgets/task_modal.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? time;
  DateTime now = DateTime.now();
  _bottomSheet() {
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
    return TaskModal(themeData: themeData);
  }

  String? month;
  String? previousMonth;
  String? nextMonth;
  @override
  Widget build(BuildContext context) {
    if (now.month == 1) {
      previousMonth = 'December';
    } else if (now.month == 2) {
      previousMonth = 'January';
    } else if (now.month == 3) {
      previousMonth = 'February';
    } else if (now.month == 4) {
      previousMonth = 'March';
    } else if (now.month == 5) {
      previousMonth = 'April';
    } else if (now.month == 6) {
      previousMonth = 'May';
    } else if (now.month == 7) {
      previousMonth = 'June';
    } else if (now.month == 8) {
      previousMonth = 'July';
    } else if (now.month == 9) {
      previousMonth = 'August';
    } else if (now.month == 10) {
      previousMonth = 'September';
    } else if (now.month == 11) {
      previousMonth = 'October';
    } else {
      previousMonth = 'November';
    }
    if (now.month == 1) {
      nextMonth = 'February';
    } else if (now.month == 2) {
      nextMonth = 'March';
    } else if (now.month == 3) {
      nextMonth = 'April';
    } else if (now.month == 4) {
      nextMonth = 'May';
    } else if (now.month == 5) {
      nextMonth = 'June';
    } else if (now.month == 6) {
      nextMonth = 'July';
    } else if (now.month == 7) {
      nextMonth = 'August';
    } else if (now.month == 8) {
      nextMonth = 'September';
    } else if (now.month == 9) {
      nextMonth = 'October';
    } else if (now.month == 10) {
      nextMonth = 'November';
    } else if (now.month == 11) {
      nextMonth = 'December';
    } else {
      nextMonth = 'January';
    }
    if (now.month == 1) {
      month = 'January';
    } else if (now.month == 2) {
      month = 'February';
    } else if (now.month == 3) {
      month = 'March';
    } else if (now.month == 4) {
      month = 'April';
    } else if (now.month == 5) {
      month = 'May';
    } else if (now.month == 6) {
      month = 'June';
    } else if (now.month == 7) {
      month = 'July';
    } else if (now.month == 8) {
      month = 'August';
    } else if (now.month == 9) {
      month = 'September';
    } else if (now.month == 10) {
      month = 'October';
    } else if (now.month == 11) {
      month = 'November';
    } else {
      month = 'December';
    }

    if (now.hour >= 4 && now.hour < 12) {
      time = 'Good morning,';
    } else if (now.hour >= 12 && now.hour < 15) {
      time = 'Good afternoon,';
    } else if (now.hour >= 15 && now.hour < 19) {
      time = 'Good evening,';
    } else {
      time = 'Good night,';
    }
    void _selectTask() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return _bottomSheet();
          });
    }

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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          primary: false,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 150,
              width: 150,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.asset(
                    "assets/images/pic.jpg",
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          actions: [ChangeThemeButtonWidget()],
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                '${time} Toluwanimi',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              GestureDetector(
                onTap: () => _selectTask(),
                child: Container(
                  height: size.height * 0.07,
                  width: size.width * 0.4,
                  decoration: decorator.copyWith(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.greenAccent),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Create task',
                        style: GoogleFonts.prompt(color: Colors.black),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      const Icon(
                        Icons.add,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back),
                    Text(
                      '${previousMonth}',
                      style: GoogleFonts.prompt(),
                    ),
                    Spacer(),
                    Text(
                      '${month}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Icon(Icons.keyboard_arrow_down),
                    Spacer(),
                    Text(
                      '${nextMonth}',
                      style: GoogleFonts.prompt(),
                    ),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    DateContainer(
                      decorator: decorator,
                      themeData: themeData,
                      date:
                          '${DateFormat("EEEE").format(now.subtract(Duration(days: 2))).substring(0, 3)}',
                      day:
                          '${DateFormat("dd").format(now.subtract(Duration(days: 2)))}',
                    ),
                    Spacer(),
                    DateContainer(
                      decorator: decorator,
                      themeData: themeData,
                      date:
                          '${DateFormat("EEEE").format(now.subtract(Duration(days: 1))).substring(0, 3)}',
                      day:
                          '${DateFormat("dd").format(now.subtract(Duration(days: 1)))}',
                    ),
                    Spacer(),
                    Container(
                      decoration: decorator.copyWith(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(10.0)),
                      height: 60,
                      width: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${DateFormat("EEEE").format(now).substring(0, 3)}',
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            (now.day).toString(),
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    DateContainer(
                      decorator: decorator,
                      themeData: themeData,
                      date:
                          '${DateFormat("EEEE").format(now.add(Duration(days: 1))).substring(0, 3)}',
                      day:
                          '${DateFormat("dd").format(now.add(Duration(days: 1)))}',
                    ),
                    Spacer(),
                    DateContainer(
                      decorator: decorator,
                      themeData: themeData,
                      date:
                          '${DateFormat("EEEE").format(now.add(Duration(days: 2))).substring(0, 3)}',
                      day:
                          '${DateFormat("dd").format(now.add(Duration(days: 2)))}',
                    ),
                  ],
                ),
              ),
              ScrollWidget(size: size, decorator: decorator),
              Container(
                width: size.width * 0.9,
                padding: const EdgeInsets.all(20),
                decoration: decorator.copyWith(
                    color: themeData ? Colors.grey[300] : Colors.grey[900],
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Today',
                          style: GoogleFonts.prompt(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Recent tasks',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w300,
                                color: themeData
                                    ? Colors.black38
                                    : Colors.white38))
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      children: [
                        RotatedBox(
                          quarterTurns: 3,
                          child: Text(
                            '${DateFormat('Hm').format(now)}',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: themeData
                                    ? Colors.black38
                                    : Colors.white38),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.07,
                        ),
                        Container(
                          padding: const EdgeInsets.all(25),
                          width: size.width * 0.65,
                          child: Text('None at the moment'),
                          decoration: decorator.copyWith(
                              color: themeData
                                  ? Colors.grey[300]
                                  : Colors.grey[900],
                              borderRadius: BorderRadius.circular(10.0)),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.24,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.greenAccent,
              boxShadow: [
                BoxShadow(
                    blurRadius: 8,
                    spreadRadius: 6,
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(0.2))
              ],
              shape: BoxShape.rectangle,
            ),
            width: 60,
            height: 60,
            child: Image.asset(
              "assets/images/helpline.png",
              scale: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

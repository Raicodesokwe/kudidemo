import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:kudidemo/pages/calendar_widget.dart';
import 'package:kudidemo/pages/edit_task.dart';

import 'package:kudidemo/pages/timer_widget.dart';

import 'package:kudidemo/services/notification_service.dart';

import 'package:kudidemo/utils/utils.dart';
import 'package:kudidemo/widgets/icon_circle.dart';

import 'package:kudidemo/widgets/theme_overlay.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/task_provider.dart';
import '../widgets/date_container.dart';
import '../widgets/image_modal.dart';
import '../widgets/scroll_widget.dart';
import '../widgets/task_modal.dart';
import 'finances_page.dart';
import 'habits_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? time;
  DateTime now = DateTime.now();
  final keyone = GlobalKey();
  final keytwo = GlobalKey();
  _bottomSheet() {
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
    return TaskModal();
  }

  String? month;
  String? previousMonth;
  String? nextMonth;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotifyService.init(initScheduled: true);
    if (Platform.isIOS) {
      NotifyService().requestIOSPermissions();
    }
    listenNotifications();
  }

  void listenNotifications() {
    NotifyService.onNotifications.stream.listen(onClickedNotification);
  }

  void onClickedNotification(String? payload) {}
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Hive.box('task-box').close();
  }

  bool checkDate = false;
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
      Platform.isIOS
          ? showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return _bottomSheet();
              })
          : showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return _bottomSheet();
              });
    }

    final tasks = Provider.of<TaskProvider>(context).tasks;
    final deleteTask = Provider.of<TaskProvider>(context);

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

    openWhatsapp() async {
      var whatsapp = '+254745347246';
      var whatsappURL_android = Uri.parse("whatsapp://send?phone=" +
          whatsapp +
          "&text=Hello, I need some assistance");
      var whatsappURL_ios = Uri.parse(
          "https://wa.me/$whatsapp?text=Hello, I need some assistance");
      if (Platform.isAndroid) {
        launchUrl(whatsappURL_android);
      } else {
        launchUrl(whatsappURL_ios);
      }
    }

    openEmail() async {
      String? encodeQueryParameters(Map<String, String> params) {
        return params.entries
            .map((MapEntry<String, String> e) =>
                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
            .join('&');
      }

// ···
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'muraierick254@gmail.com',
        query: encodeQueryParameters(<String, String>{
          'subject': 'Inquiry',
          'body': 'Hello, I need some assistance'
        }),
      );

      launchUrl(emailLaunchUri);
    }

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
          actions: [
            GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return ThemeOverlay();
                      });
                },
                child: Image.asset(
                  'assets/images/sun.png',
                  color: Theme.of(context).textTheme.bodyText2!.color,
                )),
            SizedBox(
              width: 10,
            )
          ],
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
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CalendarWidget()));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back),
                      Text(
                        '${previousMonth!.substring(0, 3)}',
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
                        '${nextMonth!.substring(0, 3)}',
                        style: GoogleFonts.prompt(),
                      ),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CalendarWidget()));
                  },
                  child: Row(
                    children: [
                      DateContainer(
                        decorator: decorator,
                        date:
                            '${DateFormat("EEEE").format(now.subtract(Duration(days: 2))).substring(0, 3)}',
                        day:
                            '${DateFormat("dd").format(now.subtract(Duration(days: 2)))}',
                      ),
                      Spacer(),
                      DateContainer(
                        decorator: decorator,
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
                        date:
                            '${DateFormat("EEEE").format(now.add(Duration(days: 1))).substring(0, 3)}',
                        day:
                            '${DateFormat("dd").format(now.add(Duration(days: 1)))}',
                      ),
                      Spacer(),
                      DateContainer(
                        decorator: decorator,
                        date:
                            '${DateFormat("EEEE").format(now.add(Duration(days: 2))).substring(0, 3)}',
                        day:
                            '${DateFormat("dd").format(now.add(Duration(days: 2)))}',
                      ),
                    ],
                  ),
                ),
              ),
              ScrollWidget(size: size, decorator: decorator),
              Container(
                width: size.width * 0.9,
                padding: const EdgeInsets.all(20),
                decoration: decorator.copyWith(
                    color: Theme.of(context).backgroundColor,
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
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .color!
                                    .withOpacity(0.5)))
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    FutureBuilder(
                        future:
                            Provider.of<TaskProvider>(context, listen: false)
                                .getTasks(),
                        builder: (context, snapshot) {
                          return Consumer<TaskProvider>(
                              child: Row(
                                children: [
                                  RotatedBox(
                                    quarterTurns: 3,
                                    child: Text(
                                      '${DateFormat('Hm').format(now)}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black54),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.07,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(25),
                                    width: size.width * 0.65,
                                    child: Text(
                                      'None at the moment',
                                    ),
                                    decoration: decorator.copyWith(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  )
                                ],
                              ),
                              builder: (context, notifier, ch) {
                                final taskItem = notifier.tasks;
                                if (notifier.tasks.length <= 0) {
                                  return ch!;
                                }
                                return Column(
                                  children: [
                                    ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: taskItem.length,
                                        itemBuilder: (ctx, index) {
                                          checkDate = Utils.toDay(
                                                  taskItem[index].from!) ==
                                              Utils.toDay(now);
                                          return checkDate
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 15),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                          backgroundColor: Theme
                                                                  .of(context)
                                                              .backgroundColor,
                                                          isScrollControlled:
                                                              true,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          context: context,
                                                          builder: (context) {
                                                            return Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                ListTile(
                                                                  leading:
                                                                      IconCircle(
                                                                    icon: Icons
                                                                        .check,
                                                                  ),
                                                                  title: Text(
                                                                    'Mark as done',
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2!
                                                                            .color,
                                                                        fontFamily: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2!
                                                                            .fontFamily),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          20),
                                                                  child:
                                                                      Divider(),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                ListTile(
                                                                  leading:
                                                                      IconCircle(
                                                                    icon: Icons
                                                                        .timer,
                                                                  ),
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(MaterialPageRoute(
                                                                            builder: (context) => TimerWidget(
                                                                                  task: taskItem[index].name,
                                                                                )));
                                                                  },
                                                                  title: Text(
                                                                    'Start timer',
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2!
                                                                            .color,
                                                                        fontFamily: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2!
                                                                            .fontFamily),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          20),
                                                                  child:
                                                                      Divider(),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                ListTile(
                                                                  leading:
                                                                      IconCircle(
                                                                    icon: Icons
                                                                        .edit,
                                                                  ),
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(MaterialPageRoute(
                                                                            builder: (context) => EditTask(
                                                                                  task: tasks[index],
                                                                                )));
                                                                  },
                                                                  title: Text(
                                                                    'Edit task',
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2!
                                                                            .color,
                                                                        fontFamily: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2!
                                                                            .fontFamily),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          20),
                                                                  child:
                                                                      Divider(),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                ListTile(
                                                                  leading:
                                                                      IconCircle(
                                                                    icon: Icons
                                                                        .delete,
                                                                  ),
                                                                  onTap: () {
                                                                    deleteTask
                                                                        .removeTask(
                                                                            tasks[index]);
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  title: Text(
                                                                    'Delete',
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2!
                                                                            .color,
                                                                        fontFamily: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2!
                                                                            .fontFamily),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          20),
                                                                  child:
                                                                      Divider(),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15,
                                                          vertical: 10),
                                                      width: double.infinity,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.watch,
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                              Text(
                                                                Utils.toTime(
                                                                    taskItem[
                                                                            index]
                                                                        .from!),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .black54),
                                                              ),
                                                              Text(
                                                                '-',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54),
                                                              ),
                                                              Text(
                                                                Utils.toTime(
                                                                    taskItem[
                                                                            index]
                                                                        .to!),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .black54),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            taskItem[index]
                                                                .name!,
                                                            style: TextStyle(
                                                                fontSize: 19,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          taskItem[index]
                                                                      .subtask !=
                                                                  ''
                                                              ? Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          10,
                                                                      width: 10,
                                                                      decoration: BoxDecoration(
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          color: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyText2!
                                                                              .color),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                      taskItem[
                                                                              index]
                                                                          .subtask!,
                                                                      style: GoogleFonts.prompt(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyText2!
                                                                              .color!
                                                                              .withOpacity(0.5)),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Container(),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Text(
                                                            taskItem[index]
                                                                .notes!,
                                                            style: GoogleFonts.prompt(
                                                                fontSize: 12,
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText2!
                                                                    .color!
                                                                    .withOpacity(
                                                                        0.5)),
                                                          ),
                                                        ],
                                                      ),
                                                      decoration:
                                                          decorator.copyWith(
                                                              color: Color(
                                                                  taskItem[
                                                                          index]
                                                                      .color!),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0)),
                                                    ),
                                                  ),
                                                )
                                              : Container();
                                        }),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    !checkDate
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Pending tasks'),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: taskItem.length,
                                                  itemBuilder: (ctx, index) {
                                                    return Utils.toDay(
                                                                taskItem[index]
                                                                    .from!) !=
                                                            Utils.toDay(now)
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 15),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                showModalBottomSheet(
                                                                    backgroundColor:
                                                                        Theme.of(context)
                                                                            .backgroundColor,
                                                                    isScrollControlled:
                                                                        true,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                15)),
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                20,
                                                                          ),
                                                                          ListTile(
                                                                            leading:
                                                                                IconCircle(
                                                                              icon: Icons.check,
                                                                            ),
                                                                            title:
                                                                                Text(
                                                                              'Mark as done',
                                                                              style: TextStyle(color: Theme.of(context).textTheme.bodyText2!.color, fontFamily: Theme.of(context).textTheme.bodyText2!.fontFamily),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 20),
                                                                            child:
                                                                                Divider(),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          ListTile(
                                                                            leading:
                                                                                IconCircle(
                                                                              icon: Icons.timer,
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              Navigator.of(context).push(MaterialPageRoute(
                                                                                  builder: (context) => TimerWidget(
                                                                                        task: taskItem[index].name,
                                                                                      )));
                                                                            },
                                                                            title:
                                                                                Text(
                                                                              'Start timer',
                                                                              style: TextStyle(color: Theme.of(context).textTheme.bodyText2!.color, fontFamily: Theme.of(context).textTheme.bodyText2!.fontFamily),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 20),
                                                                            child:
                                                                                Divider(),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          ListTile(
                                                                            leading:
                                                                                IconCircle(
                                                                              icon: Icons.edit,
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              Navigator.of(context).push(MaterialPageRoute(
                                                                                  builder: (context) => EditTask(
                                                                                        task: tasks[index],
                                                                                      )));
                                                                            },
                                                                            title:
                                                                                Text(
                                                                              'Edit task',
                                                                              style: TextStyle(color: Theme.of(context).textTheme.bodyText2!.color, fontFamily: Theme.of(context).textTheme.bodyText2!.fontFamily),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 20),
                                                                            child:
                                                                                Divider(),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          ListTile(
                                                                            leading:
                                                                                IconCircle(
                                                                              icon: Icons.delete,
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              deleteTask.removeTask(tasks[index]);
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            title:
                                                                                Text(
                                                                              'Delete',
                                                                              style: TextStyle(color: Theme.of(context).textTheme.bodyText2!.color, fontFamily: Theme.of(context).textTheme.bodyText2!.fontFamily),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 20),
                                                                            child:
                                                                                Divider(),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                        ],
                                                                      );
                                                                    });
                                                              },
                                                              child: Container(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        15,
                                                                    vertical:
                                                                        10),
                                                                width: double
                                                                    .infinity,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .watch,
                                                                          color:
                                                                              Colors.black54,
                                                                        ),
                                                                        Text(
                                                                          Utils.toDay(
                                                                              taskItem[index].from!),
                                                                          style: TextStyle(
                                                                              fontSize: 10,
                                                                              color: Theme.of(context).textTheme.bodyText2!.color!.withOpacity(0.5)),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          Utils.toTime(
                                                                              taskItem[index].from!),
                                                                          style: TextStyle(
                                                                              fontSize: 10,
                                                                              color: Theme.of(context).textTheme.bodyText2!.color!.withOpacity(0.5)),
                                                                        ),
                                                                        Text(
                                                                          '-',
                                                                          style:
                                                                              TextStyle(color: Theme.of(context).textTheme.bodyText2!.color!.withOpacity(0.5)),
                                                                        ),
                                                                        Text(
                                                                          Utils.toTime(
                                                                              taskItem[index].to!),
                                                                          style: TextStyle(
                                                                              fontSize: 10,
                                                                              color: Theme.of(context).textTheme.bodyText2!.color!.withOpacity(0.5)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      taskItem[
                                                                              index]
                                                                          .name!,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              19,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    taskItem[index].subtask !=
                                                                            ''
                                                                        ? Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Container(
                                                                                height: 10,
                                                                                width: 10,
                                                                                decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).textTheme.bodyText2!.color),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Text(
                                                                                taskItem[index].subtask!,
                                                                                style: GoogleFonts.prompt(fontSize: 15, fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.bodyText2!.color!.withOpacity(0.5)),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        : Container(),
                                                                    SizedBox(
                                                                      height: 3,
                                                                    ),
                                                                    Text(
                                                                      taskItem[
                                                                              index]
                                                                          .notes!,
                                                                      style: GoogleFonts.prompt(
                                                                          fontSize:
                                                                              12,
                                                                          color: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyText2!
                                                                              .color!
                                                                              .withOpacity(0.5)),
                                                                    ),
                                                                  ],
                                                                ),
                                                                decoration: decorator.copyWith(
                                                                    color: Color(
                                                                        taskItem[index]
                                                                            .color!),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                              ),
                                                            ),
                                                          )
                                                        : Container();
                                                  })
                                            ],
                                          )
                                        : Container()
                                  ],
                                );
                              });
                        })
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.24,
              ),
            ],
          ),
        ),
        floatingActionButton: SpeedDial(
          children: [
            SpeedDialChild(
                onTap: () => openWhatsapp(),
                child: Icon(Icons.phone_android),
                label: 'Whatsapp',
                backgroundColor: Colors.red),
            SpeedDialChild(
                onTap: () => openEmail(),
                child: Icon(Icons.mail),
                label: 'Mail',
                backgroundColor: Colors.pink),
          ],
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

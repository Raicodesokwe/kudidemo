import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/utils/utils.dart';
import 'package:kudidemo/widgets/tasks/date_task_modal.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../providers/task_provider.dart';
import '../widgets/back_arrow.dart';
import '../widgets/tasks/task_data_source.dart';

class CalendarWidget extends StatelessWidget {
  CalendarWidget({Key? key}) : super(key: key);
  final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<TaskProvider>(context, listen: false).getTasks();

    Size size = MediaQuery.of(context).size;
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
    return SafeArea(
      child: Scaffold(
        body: Consumer<TaskProvider>(builder: (context, notifier, ch) {
          final taskItem = notifier.tasks;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                BackArrow(
                  decorator: decorator,
                ),
                Container(
                  decoration: decorator.copyWith(
                      color: Theme.of(context).backgroundColor,
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(7)),
                  height: size.height * 0.82,
                  width: double.infinity,
                  child: Theme(
                    data: ThemeData(
                      fontFamily: 'grifterBold',
                      colorScheme: Theme.of(context)
                          .colorScheme
                          .copyWith(primary: Colors.green),
                    ),
                    child: SfCalendar(
                      appointmentBuilder: (context, details) {
                        final tasks = details.appointments.first;
                        return Container(
                          width: details.bounds.width,
                          height: details.bounds.height,
                          decoration: BoxDecoration(
                              color: Color(tasks.color),
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  tasks.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .fontFamily),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      Utils.toTime(tasks.from),
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                    Text('-',
                                        style:
                                            TextStyle(color: Colors.black54)),
                                    Text(Utils.toTime(tasks.to),
                                        style:
                                            TextStyle(color: Colors.black54)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      view: CalendarView.month,
                      dataSource: TaskDataSource(taskItem),
                      initialSelectedDate: now,
                      cellBorderColor: Colors.transparent,

                      todayTextStyle: TextStyle(
                          fontFamily: 'grifterBold',
                          fontSize: 22,
                          fontStyle: FontStyle.normal,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                      headerStyle: CalendarHeaderStyle(
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                              fontFamily: 'grifterBold',
                              fontSize: 22,
                              fontStyle: FontStyle.normal,
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color,
                              fontWeight: FontWeight.w900)),
                      monthViewSettings: MonthViewSettings(
                          appointmentDisplayMode:
                              MonthAppointmentDisplayMode.indicator,
                          showAgenda: true),
                      // onLongPress: (details) {
                      //   notifier.setDate(details.date!);
                      //   showModalBottomSheet(
                      //       context: context,
                      //       builder: (context) => DateTaskModal());
                      // },
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.06,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

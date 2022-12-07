import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kudidemo/models/chart_model.dart';
import 'package:kudidemo/pages/task_view.dart';
import 'package:kudidemo/providers/task_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../utils/utils.dart';

class TaskStats extends StatelessWidget {
  TaskStats({Key? key}) : super(key: key);
  int mondaySelected = 0;
  int tuesdaySelected = 0;
  int wednesdaySelected = 0;
  int thursdaySelected = 0;
  int fridaySelected = 0;
  int saturdaySelected = 0;
  int sundaySelected = 0;
  int mondayIncomplete = 0;
  int tuesdayIncomplete = 0;
  int wednesdayIncomplete = 0;
  int thursdayIncomplete = 0;
  int fridayIncomplete = 0;
  int saturdayIncomplete = 0;
  int sundayIncomplete = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(builder: (context, notifier, ch) {
      final taskItem = notifier.tasks;
      mondaySelected = taskItem
          .where(
            (element) =>
                Utils.toDay(element.from!) == 'Monday' &&
                element.isComplete == true,
          )
          .length;
      mondayIncomplete = taskItem
          .where(
            (element) =>
                Utils.toDay(element.from!) == 'Monday' &&
                element.isComplete == false,
          )
          .length;
      tuesdaySelected = taskItem
          .where(
            (element) =>
                Utils.toDay(element.from!) == 'Tuesday' &&
                element.isComplete == true,
          )
          .length;
      tuesdayIncomplete = taskItem
          .where(
            (element) =>
                Utils.toDay(element.from!) == 'Tuesday' &&
                element.isComplete == false,
          )
          .length;
      wednesdaySelected = taskItem
          .where(
            (element) =>
                Utils.toDay(element.from!) == 'Wednesday' &&
                element.isComplete == true,
          )
          .length;
      wednesdayIncomplete = taskItem
          .where(
            (element) =>
                Utils.toDay(element.from!) == 'Wednesday' &&
                element.isComplete == false,
          )
          .length;
      thursdaySelected = taskItem
          .where(
            (element) =>
                Utils.toDay(element.from!) == 'Thursday' &&
                element.isComplete == true,
          )
          .length;
      thursdayIncomplete = taskItem
          .where(
            (element) =>
                Utils.toDay(element.from!) == 'Thursday' &&
                element.isComplete == false,
          )
          .length;
      fridaySelected = taskItem
          .where(
            (element) =>
                Utils.toDay(element.from!) == 'Friday' &&
                element.isComplete == true,
          )
          .length;
      fridayIncomplete = taskItem
          .where(
            (element) =>
                Utils.toDay(element.from!) == 'Friday' &&
                element.isComplete == false,
          )
          .length;
      saturdaySelected = taskItem
          .where(
            (element) =>
                Utils.toDay(element.from!) == 'Saturday' &&
                element.isComplete == true,
          )
          .length;
      saturdayIncomplete = taskItem
          .where(
            (element) =>
                Utils.toDay(element.from!) == 'Saturday' &&
                element.isComplete == false,
          )
          .length;
      sundaySelected = taskItem
          .where(
            (element) =>
                Utils.toDay(element.from!) == 'Sunday' &&
                element.isComplete == true,
          )
          .length;
      sundayIncomplete = taskItem
          .where(
            (element) =>
                Utils.toDay(element.from!) == 'Sunday' &&
                element.isComplete == false,
          )
          .length;
      List<ChartModel> statsList = [
        ChartModel(
            day: 'Mon',
            tasksComplete: mondaySelected,
            tasksIncomplete: mondayIncomplete),
        ChartModel(
            day: 'Tue',
            tasksComplete: tuesdaySelected,
            tasksIncomplete: tuesdayIncomplete),
        ChartModel(
            day: 'Wed',
            tasksComplete: wednesdaySelected,
            tasksIncomplete: wednesdayIncomplete),
        ChartModel(
            day: 'Thur',
            tasksComplete: thursdaySelected,
            tasksIncomplete: thursdayIncomplete),
        ChartModel(
            day: 'Fri',
            tasksComplete: fridaySelected,
            tasksIncomplete: fridayIncomplete),
        ChartModel(
            day: 'Sat',
            tasksComplete: saturdaySelected,
            tasksIncomplete: saturdayIncomplete),
        ChartModel(
            day: 'Sun',
            tasksComplete: sundaySelected,
            tasksIncomplete: sundayIncomplete),
      ];
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
      return Consumer<TaskProvider>(builder: (context, notifier, child) {
        final listLength = notifier.tasks;
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
                    backgroundColor: Colors.green,
                    elevation: 7,
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(context).textTheme.bodyText2!.color,
                    ),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => TaskView()));
                    },
                    label: Text(
                      'Add new task',
                      style: Theme.of(context).textTheme.bodyText2,
                    )),
              ),
              body: listLength.length <= 0
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height * 0.1,
                          ),
                          Lottie.asset('assets/images/addnew.json',
                              height: size.height * 0.4),
                          Text('Uh oh, it\'s quite empty here.'),
                          Text('Add new task'),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 40),
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
                          )
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            decoration: decorator.copyWith(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(7)),
                            height: size.height * 0.6,
                            child: SfCartesianChart(
                              margin: EdgeInsets.all(10),
                              borderWidth: 0,
                              borderColor: Colors.transparent,
                              plotAreaBorderWidth: 0,
                              primaryXAxis: CategoryAxis(
                                  labelStyle:
                                      Theme.of(context).textTheme.bodyText2,
                                  isVisible: true,
                                  borderWidth: 0,
                                  borderColor: Colors.transparent),
                              primaryYAxis: NumericAxis(
                                labelStyle:
                                    Theme.of(context).textTheme.bodyText2,
                                minimum: 0,
                                interval: 1,
                                isVisible: true,
                                borderWidth: 0,
                                borderColor: Colors.transparent,
                              ),
                              series: <CartesianSeries>[
                                ColumnSeries<ChartModel, String>(
                                    gradient: LinearGradient(
                                        colors: [Colors.green, Colors.blue],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter),
                                    dataSource: statsList,
                                    xValueMapper: (ChartModel stats, _) =>
                                        stats.day,
                                    yValueMapper: (ChartModel stats, _) =>
                                        stats.tasksComplete),
                                ColumnSeries<ChartModel, String>(
                                    gradient: LinearGradient(
                                        colors: [Colors.red, Colors.blue],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter),
                                    dataSource: statsList,
                                    xValueMapper: (ChartModel stats, _) =>
                                        stats.day,
                                    yValueMapper: (ChartModel stats, _) =>
                                        stats.tasksIncomplete),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 60,
                                width: 60,
                                decoration: decorator.copyWith(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Theme.of(context).backgroundColor),
                                child: Center(
                                    child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      gradient: LinearGradient(
                                          colors: [Colors.green, Colors.blue])),
                                ))),
                            SizedBox(
                              width: 15,
                            ),
                            Text('Complete tasks')
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 60,
                                width: 60,
                                decoration: decorator.copyWith(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Theme.of(context).backgroundColor),
                                child: Center(
                                    child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      gradient: LinearGradient(
                                          colors: [Colors.red, Colors.blue])),
                                ))),
                            SizedBox(
                              width: 15,
                            ),
                            Text('Incomplete tasks')
                          ],
                        ),
                      ],
                    )),
        );
      });
    });
  }
}

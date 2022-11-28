import 'package:flutter/material.dart';
import 'package:kudidemo/models/chart_model.dart';
import 'package:kudidemo/providers/task_provider.dart';
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
            day: 'Monday',
            tasksComplete: mondaySelected,
            tasksIncomplete: mondayIncomplete),
        ChartModel(
            day: 'Tuesday',
            tasksComplete: tuesdaySelected,
            tasksIncomplete: tuesdayIncomplete),
        ChartModel(
            day: 'Wednesday',
            tasksComplete: wednesdaySelected,
            tasksIncomplete: wednesdayIncomplete),
        ChartModel(
            day: 'Thursday',
            tasksComplete: thursdaySelected,
            tasksIncomplete: thursdayIncomplete),
        ChartModel(
            day: 'Friday',
            tasksComplete: fridaySelected,
            tasksIncomplete: fridayIncomplete),
        ChartModel(
            day: 'Saturday',
            tasksComplete: saturdaySelected,
            tasksIncomplete: saturdayIncomplete),
        ChartModel(
            day: 'Sunday',
            tasksComplete: sundaySelected,
            tasksIncomplete: sundayIncomplete),
      ];
      return Scaffold(
        body: SfCartesianChart(
          margin: EdgeInsets.all(0),
          borderWidth: 0,
          borderColor: Colors.transparent,
          plotAreaBorderWidth: 0,
          primaryXAxis: CategoryAxis(
              isVisible: true, borderWidth: 0, borderColor: Colors.transparent),
          primaryYAxis: NumericAxis(
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
                xValueMapper: (ChartModel stats, _) => stats.day,
                yValueMapper: (ChartModel stats, _) => stats.tasksComplete),
            ColumnSeries<ChartModel, String>(
                gradient: LinearGradient(
                    colors: [Colors.red, Colors.blue],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                dataSource: statsList,
                xValueMapper: (ChartModel stats, _) => stats.day,
                yValueMapper: (ChartModel stats, _) => stats.tasksIncomplete),
          ],
        ),
      );
    });
  }
}

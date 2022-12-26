import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/models/task_model.dart';
import 'package:kudidemo/pages/edit_task.dart';
import 'package:kudidemo/providers/bilable_provider.dart';
import 'package:kudidemo/providers/task_provider.dart';
import 'package:kudidemo/utils/utils.dart';
import 'package:kudidemo/widgets/billing_overlay.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../models/billable_model.dart';
import '../pages/task_view.dart';

class BillableWidget extends StatefulWidget {
  final TaskModel? taskItem;
  final String? task;
  final Color? color;
  final double? hourlyRate;
  BillableWidget(
      {Key? key, this.task, this.color, this.taskItem, this.hourlyRate})
      : super(key: key);

  @override
  State<BillableWidget> createState() => _BillableWidgetState();
}

class _BillableWidgetState extends State<BillableWidget> {
  Duration duration = Duration();

  bool isStarted = false;

  late Timer _timer;

  void addTime() {
    final addSeconds = 1;
    setState(() {
      isStarted = true;
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void reset() {
    setState(() {
      duration = Duration();
    });
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() {
      _timer.cancel();
    });
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  DateTime startDate = DateTime.now();
  bool isTapped = false;
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
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return SingleChildScrollView(
      child: Consumer<TaskProvider>(builder: (context, notifier, child) {
        // if (widget.taskItem != null) {
        //   notifier.bills = widget.taskItem!.billList ?? [];
        // }
        widget.taskItem != null
            ? notifier.bills = widget.taskItem!.billList!
            : [];
        final endDate = startDate.add(duration);
        final billItem = BillableModel(
            id: Random().nextInt(10000),
            amount: widget.hourlyRate ?? 0.0,
            start: startDate,
            end: endDate);

        return Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        child: Center(
                            child: Icon(
                          FontAwesomeIcons.dollarSign,
                          color: Colors.black,
                        )),
                        decoration: BoxDecoration(
                            color: Colors.greenAccent.shade100,
                            shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Billable',
                            style: TextStyle(color: Colors.green, fontSize: 17),
                          ),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.clock,
                                size: 15,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .color!
                                    .withOpacity(0.5),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  width: size.width * 0.6,
                  decoration: decorator.copyWith(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  child: Center(
                    child: Text(
                      hours,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  decoration: decorator.copyWith(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(7)),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 50,
                  width: 50,
                  child: Center(
                    child: Text(
                      minutes,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  decoration: decorator.copyWith(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(7)),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 50,
                  width: 50,
                  child: Center(
                    child: Text(
                      seconds,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  decoration: decorator.copyWith(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(7)),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            widget.task != ''
                ? Container(
                    width: size.width * 0.5,
                    height: 50,
                    decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.task ?? '',
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.hourlyRate == null
                              ? ''
                              : '${widget.hourlyRate}/hr',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    )))
                : Container(),
            // SizedBox(
            //   height: size.height * 0.02,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     showDialog(
            //       context: context,
            //       builder: (_) => BillingOverlay(),
            //     );
            //   },
            //   child: Container(
            //     height: 50,
            //     child: Center(
            //       child: Text('Hourly rate'),
            //     ),
            //     width: size.width * 0.5,
            //     decoration: decorator.copyWith(
            //         borderRadius: BorderRadius.circular(12),
            //         color: Theme.of(context).backgroundColor),
            //   ),
            // ),
            SizedBox(
              height: size.height * 0.02,
            ),
            GestureDetector(
              onTap: isTapped
                  ? () {}
                  : () {
                      if (widget.taskItem == null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TaskView()));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor:
                                Theme.of(context).textTheme.bodyText2!.color,
                            content: Text(
                              'Add task name and hourly rate',
                              style: TextStyle(
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .fontFamily!),
                            )));
                      } else if (widget.taskItem != null &&
                          widget.hourlyRate == 0.0) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditTask(
                                  task: widget.taskItem,
                                )));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor:
                                Theme.of(context).textTheme.bodyText2!.color,
                            content: Text(
                              'Add task name and hourly rate',
                              style: TextStyle(
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .fontFamily!),
                            )));
                      } else {
                        setState(() {
                          if (!isStarted) {
                            isStarted = true;
                            isTapped = true;
                            startTimer();
                            startDate = DateTime.now();
                            print('the start is ${startDate}');
                          } else {
                            _timer.cancel();

                            isStarted = false;
                          }
                        });
                      }
                    },
              child: Container(
                height: 70,
                width: 70,
                child: Center(
                  child: Icon(
                    !isStarted ? FontAwesomeIcons.play : FontAwesomeIcons.pause,
                    color: Colors.white,
                  ),
                ),
                decoration: decorator.copyWith(
                    color: Colors.green, shape: BoxShape.circle),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            GestureDetector(
                onTap: widget.taskItem == null ||
                        widget.task == '' ||
                        widget.hourlyRate == 0.0
                    ? () {}
                    : () {
                        setState(() {
                          stopTimer();
                          isStarted = false;
                          isTapped = false;
                        });

                        notifier.addBillableList(billItem);
                        final taskIssue = TaskModel(
                            id: widget.taskItem!.id,
                            name: widget.taskItem!.name,
                            from: widget.taskItem!.from,
                            to: widget.taskItem!.to,
                            subtask: widget.taskItem!.subtask,
                            notes: widget.taskItem!.notes,
                            color: widget.taskItem!.color,
                            reminder: widget.taskItem!.reminder,
                            repeat: widget.taskItem!.repeat,
                            hourlyRate: widget.taskItem!.hourlyRate,
                            isComplete: widget.taskItem!.isComplete!,
                            billList: notifier.bills);
                        final taskProvider =
                            Provider.of<TaskProvider>(context, listen: false);
                        taskProvider
                            .changeTask(taskIssue)
                            .then((value) => taskProvider.reset());
                      },
                child: Container(
                  decoration: decorator.copyWith(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.green),
                  width: size.width * 0.5,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Done',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                )),
            SizedBox(
              height: 24,
            ),
            widget.taskItem == null || notifier.bills.isEmpty
                ? Container()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Amount'),
                            SizedBox(
                              width: size.width * 0.3,
                            ),
                            Text('From'),
                            SizedBox(
                              width: size.width * 0.15,
                            ),
                            Text('To')
                          ],
                        ),
                        Divider(),
                        ListView.builder(
                            itemCount: widget.taskItem!.billList!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final billIssue =
                                  widget.taskItem!.billList![index];
                              final styleIssue = GoogleFonts.prompt(
                                  fontWeight: FontWeight.w300, fontSize: 10);
                              final dur =
                                  billIssue.end!.difference(billIssue.start!);
                              final money =
                                  (dur.inSeconds / 3600) * billIssue.amount!;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  children: [
                                    Text('\$${money.toStringAsFixed(2)}'),
                                    Spacer(),
                                    Text(
                                      '${Utils.toDate(
                                        billIssue.start!,
                                      )}\n${Utils.toTime(billIssue.start!)}',
                                      style: styleIssue,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      '${Utils.toDate(
                                        billIssue.end!,
                                      )}\n${Utils.toTime(billIssue.end!)}',
                                      style: styleIssue,
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  )
          ],
        );
      }),
    );
  }
}

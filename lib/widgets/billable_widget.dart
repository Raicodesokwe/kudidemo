import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kudidemo/providers/bilable_provider.dart';
import 'package:kudidemo/widgets/billing_overlay.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../pages/task_view.dart';
import '../providers/timer_provider.dart';
import '../services/notification_service.dart';
import 'back_arrow.dart';
import 'minutes_overlay.dart';

class BillableWidget extends StatefulWidget {
  final String? task;
  final Color? color;
  final double? hourlyRate;
  BillableWidget({Key? key, this.task, this.color, this.hourlyRate})
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
      child: Column(
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
                      child: Center(child: Icon(FontAwesomeIcons.dollarSign)),
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
                              color: Colors.black54,
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
          SizedBox(
            height: size.height * 0.02,
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => BillingOverlay(),
              );
            },
            child: Container(
              height: 50,
              child: Center(
                child: Text('Hourly rate'),
              ),
              width: size.width * 0.5,
              decoration: decorator.copyWith(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).backgroundColor),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          GestureDetector(
            onTap: () {
              if (widget.hourlyRate == null || widget.task == '') {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => TaskView()));
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
                    startTimer();
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
              onTap: () {
                setState(() {
                  stopTimer();
                  isStarted = false;
                });
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
        ],
      ),
    );
  }
}

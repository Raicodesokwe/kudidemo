import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kudidemo/providers/timer_provider.dart';
import 'package:kudidemo/services/notification_service.dart';
import 'package:kudidemo/widgets/minutes_overlay.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../widgets/back_arrow.dart';

class TimerWidget extends StatefulWidget {
  final String? task;
  final Color? color;
  TimerWidget({Key? key, this.task, this.color}) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget>
    with TickerProviderStateMixin {
  DateTime now = DateTime.now();
  double percent = 0;

  bool isStarted = false;
  bool isRunning = false;
  // bool _active = false;
  bool isFinished = false;
  int focusedMins = 0;
  // DateTime finishTime = DateTime.now().add(Duration(minutes: 25));
  late AnimationController controller;
  late AnimationController colorController;
  Animation? iconColorAnimation;
  late Timer _timer;
  // Timer? _timer2;
  var counter = 0;
  List<Color> get getColorsList => [
        const Color(0xFF006E7F),
        const Color(0xFFF8CB2E),
        const Color(0xFFEE5007),
        const Color(0xFFB22727),
      ]..shuffle();

  /// Generate list of alignment which will be used to
  /// set gradient start and end for random color animation.
  List<Alignment> get getAlignments => [
        Alignment.bottomLeft,
        Alignment.bottomRight,
        Alignment.topRight,
        Alignment.topLeft,
      ];

  @override
  void initState() {
    // TODO: implement initState
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 50),
        value: 1.0,
        lowerBound: 1.0,
        upperBound: 1.75);
    colorController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 50),
    );
    iconColorAnimation =
        ColorTween(begin: Colors.redAccent, end: Colors.redAccent)
            .animate(colorController)
          ..addListener(() {
            setState(() {});
          });

    super.initState();
  }

  // void _startBgColorAnimationTimer() {
  //   ///Animating for the first time.
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     counter++;
  //     setState(() {});
  //   });

  //   const interval = Duration(seconds: 5);
  //   _timer2 = Timer.periodic(
  //     interval,
  //     (Timer timer) {
  //       counter++;
  //       setState(() {});
  //     },
  //   );
  // }
  int? value;
  int? defaultValue;
  void startTimer() {
    focusedMins = value!;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (value! <= 1) {
          setState(() {
            timer.cancel();
            value = defaultValue;
            isStarted = false;
          });
        } else {
          setState(() {
            // if (value != null) value = value! - 1;
            // value--;
            Provider.of<TimerProvider>(context, listen: false).decreaseOneSec();
          });
        }
      },
    );
  }

  void stopTimer() {
    _timer.cancel();
    // _timer2!.cancel();
  }

  @override
  void dispose() {
    _timer.cancel();
    // _timer2!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // isRunning = _timer == null ? false : _timer!.isActive;
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

    return SafeArea(
      child: Scaffold(
        body: Consumer<TimerProvider>(builder: (context, timerValue, child) {
          value = timerValue.time;

          defaultValue = timerValue.time;
          if (value == 1) {
            NotifyService.showNotification(
                id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
                title: 'Task finished',
                body: widget.task ?? '');
          }

          return Column(
            children: [
              BackArrow(
                decorator: decorator,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    print('malcolm in the $value');
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          child: Center(
                              child: Image.asset(
                            'assets/images/tomato.png',
                            scale: 3,
                          )),
                          decoration: BoxDecoration(
                              color: Colors.redAccent.shade100,
                              shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pomodoro',
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 17),
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
                                // Text(
                                //   'Finishing ${DateFormat('Hm').format(now.add(Duration(seconds: timerValue.time)))}',
                                //   style: TextStyle(
                                //     color: Colors.black54,
                                //   ),
                                // )
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
                height: size.height * 0.05,
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 2),
                padding: const EdgeInsets.all(10),
                decoration: decorator.copyWith(
                    gradient: LinearGradient(
                      begin: getAlignments[counter % getAlignments.length],
                      end: getAlignments[(counter + 2) % getAlignments.length],
                      colors: getColorsList,
                      tileMode: TileMode.clamp,
                    ),
                    shape: BoxShape.circle),
                child: CircularPercentIndicator(
                  arcType: ArcType.FULL,
                  radius: 250,
                  lineWidth: 20,
                  progressColor: Colors.redAccent,
                  center: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).backgroundColor),
                    child: Text(
                        "${(value! ~/ 60).toInt().toString().padLeft(2, '0')}:${(value! % 60).toInt().toString().padLeft(2, '0')}"),
                  ),
                  percent: percent,
                  animation: true,
                  animateFromLastPercent: true,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              widget.task != ''
                  ? Container(
                      width: size.width * 0.5,
                      height: 50,
                      decoration: BoxDecoration(
                          color: widget.color,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(child: Text(widget.task ?? '')))
                  : Container(),
              SizedBox(
                height: size.height * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => MinutesOverlay(),
                  );
                },
                child: Container(
                  height: 50,
                  child: Center(
                    child: Text('Change time'),
                  ),
                  width: size.width * 0.5,
                  decoration: decorator.copyWith(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).backgroundColor),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              // isRunning
              //     ? GestureDetector(
              //         onTap: () {
              //           stopTimer();
              //           isStarted = false;
              //           setState(() {
              //             isRunning = !isRunning;
              //           });
              //         },
              //         child: Container(
              //           height: 70,
              //           width: 70,
              //           child: Center(
              //             child: Icon(
              //               FontAwesomeIcons.pause,
              //               color: Colors.redAccent,
              //             ),
              //           ),
              //           decoration: decorator.copyWith(
              //               color: Theme.of(context).backgroundColor,
              //               shape: BoxShape.circle),
              //         ),
              //       )
              //     :
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (!isStarted) {
                      isStarted = true;
                      startTimer();
                    } else {
                      _timer.cancel();
                      value = defaultValue;
                      isStarted = false;
                    }
                  });

                  // isStarted = true;
                  // startTimer();
                  // controller.forward().then((value) {
                  //   _active
                  //       ? colorController.forward()
                  //       : colorController.reverse();
                  //   controller.reverse();
                  // });
                  // _active = !_active;
                  // _startBgColorAnimationTimer();
                  // final notifyTime =
                  //     now.add(Duration(seconds: timerValue.time));
                },
                child: Container(
                  height: 70,
                  width: 70,
                  child: Center(
                    child: ScaleTransition(
                      scale: controller,
                      child: Icon(
                        !isStarted
                            ? FontAwesomeIcons.play
                            : FontAwesomeIcons.pause,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  decoration: decorator.copyWith(
                      color: iconColorAnimation!.value, shape: BoxShape.circle),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

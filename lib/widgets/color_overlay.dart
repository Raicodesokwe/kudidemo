import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/utils/utils.dart';
import 'package:kudidemo/widgets/text_field.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class ColorOverlay extends StatefulWidget {
  Color? color;
  ColorOverlay({Key? key, required this.color});
  @override
  State<StatefulWidget> createState() => ColorOverlayState();
}

class ColorOverlayState extends State<ColorOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
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

    return Platform.isIOS
        ? ScaleTransition(
            scale: scaleAnimation,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: CupertinoAlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.color = Colors.pink.shade200;
                            setState(() {});
                          },
                          child: Container(
                              padding: const EdgeInsets.all(7),
                              child: Center(
                                  child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.pink.shade200,
                                    shape: BoxShape.circle),
                              )),
                              decoration: decorator.copyWith(
                                  color: widget.color == Colors.pink.shade200
                                      ? Colors.pink.shade200
                                      : Theme.of(context).backgroundColor,
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.color = Colors.purple.shade200;
                            setState(() {});
                          },
                          child: Container(
                              padding: const EdgeInsets.all(7),
                              child: Center(
                                  child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.purple.shade200,
                                    shape: BoxShape.circle),
                              )),
                              decoration: decorator.copyWith(
                                  color: widget.color == Colors.purple.shade200
                                      ? Colors.purple.shade200
                                      : Theme.of(context).backgroundColor,
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.color = Colors.blue.shade200;
                            setState(() {});
                          },
                          child: Container(
                              padding: const EdgeInsets.all(7),
                              child: Center(
                                  child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade200,
                                    shape: BoxShape.circle),
                              )),
                              decoration: decorator.copyWith(
                                  color: widget.color == Colors.blue.shade200
                                      ? Colors.blue.shade200
                                      : Theme.of(context).backgroundColor,
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.color = Colors.orange.shade200;
                            setState(() {});
                          },
                          child: Container(
                              padding: const EdgeInsets.all(7),
                              child: Center(
                                  child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.orange.shade200,
                                    shape: BoxShape.circle),
                              )),
                              decoration: decorator.copyWith(
                                  color: widget.color == Colors.orange.shade200
                                      ? Colors.orange.shade200
                                      : Theme.of(context).backgroundColor,
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.color = Colors.green.shade200;
                            setState(() {});
                          },
                          child: Container(
                              padding: const EdgeInsets.all(7),
                              child: Center(
                                  child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.green.shade200,
                                    shape: BoxShape.circle),
                              )),
                              decoration: decorator.copyWith(
                                  color: widget.color == Colors.green.shade200
                                      ? Colors.green.shade200
                                      : Theme.of(context).backgroundColor,
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ],
                    )
                  ],
                ),
                actions: [
                  CupertinoDialogAction(
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.prompt(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  CupertinoDialogAction(
                    child: Text(
                      'Confirm',
                      style: GoogleFonts.prompt(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(widget.color);
                    },
                  )
                ],
              ),
            ),
          )
        : Center(
            child: Material(
              color: Colors.transparent,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                  child: Container(
                    decoration: ShapeDecoration(
                        color: Theme.of(context).backgroundColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  widget.color = Colors.pink.shade200;
                                  setState(() {});
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(7),
                                    child: Center(
                                        child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.pink.shade200,
                                          shape: BoxShape.circle),
                                    )),
                                    decoration: decorator.copyWith(
                                        color: widget.color ==
                                                Colors.pink.shade200
                                            ? Colors.pink.shade200
                                            : Theme.of(context).backgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(30))),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.color = Colors.purple.shade200;
                                  setState(() {});
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(7),
                                    child: Center(
                                        child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.purple.shade200,
                                          shape: BoxShape.circle),
                                    )),
                                    decoration: decorator.copyWith(
                                        color: widget.color ==
                                                Colors.purple.shade200
                                            ? Colors.purple.shade200
                                            : Theme.of(context).backgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(30))),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.color = Colors.blue.shade200;
                                  setState(() {});
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(7),
                                    child: Center(
                                        child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.blue.shade200,
                                          shape: BoxShape.circle),
                                    )),
                                    decoration: decorator.copyWith(
                                        color: widget.color ==
                                                Colors.blue.shade200
                                            ? Colors.blue.shade200
                                            : Theme.of(context).backgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(30))),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.color = Colors.orange.shade200;
                                  setState(() {});
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(7),
                                    child: Center(
                                        child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.orange.shade200,
                                          shape: BoxShape.circle),
                                    )),
                                    decoration: decorator.copyWith(
                                        color: widget.color ==
                                                Colors.orange.shade200
                                            ? Colors.orange.shade200
                                            : Theme.of(context).backgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(30))),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.color = Colors.green.shade200;
                                  setState(() {});
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(7),
                                    child: Center(
                                        child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.green.shade200,
                                          shape: BoxShape.circle),
                                    )),
                                    decoration: decorator.copyWith(
                                        color: widget.color ==
                                                Colors.green.shade200
                                            ? Colors.green.shade200
                                            : Theme.of(context).backgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(30))),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel')),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop(widget.color);
                                },
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      'Confirm',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  height: 50,
                                  width: 120,
                                  decoration: decorator.copyWith(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Color.fromARGB(255, 12, 99, 212)),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/models/color_model.dart';
import 'package:kudidemo/providers/color_provider.dart';
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
    final colorData = Provider.of<ColorProvider>(context);
    return Platform.isIOS
        ? ScaleTransition(
            scale: scaleAnimation,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: CupertinoAlertDialog(
                title: Text(
                  'Change color',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 18),
                ),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<ThemeProvider>(
                      builder: (context, notifier, child) => Wrap(
                            spacing: 15,
                            runSpacing: 15,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            direction: Axis.horizontal,
                            runAlignment: WrapAlignment.start,
                            verticalDirection: VerticalDirection.down,
                            clipBehavior: Clip.none,
                            children: List.generate(colorList.length, (index) {
                              final colorElement = colorList[index];
                              return GestureDetector(
                                onTap: () {
                                  colorData.selectColor(index);
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                    height: 60,
                                    width: 60,
                                    // padding: const EdgeInsets.all(8),
                                    decoration: decorator.copyWith(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Center(
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            color: colorElement.color,
                                            shape: BoxShape.circle),
                                      ),
                                    )),
                              );
                            }),
                          )),
                ),
              ),
            ),
          )
        : ScaleTransition(
            scale: scaleAnimation,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text(
                'Change color',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 18),
              ),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<ThemeProvider>(
                    builder: (context, notifier, child) => Wrap(
                          spacing: 25,
                          runSpacing: 15,
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          direction: Axis.horizontal,
                          runAlignment: WrapAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          clipBehavior: Clip.none,
                          children: List.generate(colorList.length, (index) {
                            final colorElement = colorList[index];
                            return GestureDetector(
                              onTap: () {
                                colorData.selectColor(index);
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                  height: 60,
                                  width: 60,
                                  // padding: const EdgeInsets.all(8),
                                  decoration: decorator.copyWith(
                                      color: Theme.of(context).backgroundColor,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: colorElement.color,
                                          shape: BoxShape.circle),
                                    ),
                                  )),
                            );
                          }),
                        )),
              ),
            ),
          );
  }
}

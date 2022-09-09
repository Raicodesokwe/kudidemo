import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../theme/theme_enum.dart';

class ThemeOverlay extends StatefulWidget {
  const ThemeOverlay({Key? key}) : super(key: key);

  @override
  State<ThemeOverlay> createState() => _ThemeOverlayState();
}

class _ThemeOverlayState extends State<ThemeOverlay>
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
    final themeData = Provider.of<ThemeProvider>(context);
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
    return ScaleTransition(
      scale: scaleAnimation,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Change theme',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18),
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
                    children: List.generate(AppTheme.values.length, (index) {
                      final theme = AppTheme.values[index];
                      return GestureDetector(
                        onTap: () {
                          themeData.setTheme(theme);
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
                                    color: appThemeData[theme]!.backgroundColor,
                                    shape: BoxShape.circle),
                              ),
                            )
                            // ListTile(
                            //   onTap: () {
                            //     themeData.setTheme(theme);
                            //   },
                            //   title: Text(
                            //     enumName(theme),
                            //     style: TextStyle(color: Colors.black),
                            //   ),
                            // ),
                            ),
                      );
                    }),
                  )),
        ),
      ),
    );
  }
}

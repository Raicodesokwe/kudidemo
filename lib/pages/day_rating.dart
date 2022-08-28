import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kudidemo/pages/journal_page.dart';
import 'package:kudidemo/pages/reasonpage.dart';

import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../widgets/back_arrow.dart';
import '../widgets/nextneon_button.dart';
import '../widgets/next_button.dart';

class DayRating extends StatefulWidget {
  const DayRating({Key? key}) : super(key: key);

  @override
  State<DayRating> createState() => _DayRatingState();
}

class _DayRatingState extends State<DayRating>
    with SingleTickerProviderStateMixin {
  double _currentValue = 5;
  bool selected = false;
  late AnimationController controller;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 850));
    fadeAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeData = Provider.of<ThemeProvider>(context).darkTheme;
    final BoxDecoration decorator = BoxDecoration(
      boxShadow: themeData
          ? [
              BoxShadow(
                  color: Colors.grey.shade500,
                  offset: Offset(4, 4),
                  blurRadius: 15,
                  spreadRadius: 1),
              BoxShadow(
                spreadRadius: 1,
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 15,
              )
            ]
          : [
              BoxShadow(
                  color: Colors.black,
                  offset: Offset(5, 5),
                  blurRadius: 15,
                  spreadRadius: 5),
              BoxShadow(
                spreadRadius: 1,
                color: Colors.grey.shade800,
                offset: Offset(-4, -4),
                blurRadius: 15,
              )
            ],
    );
    return SafeArea(
      child: Scaffold(
        body: FadeTransition(
          opacity: fadeAnimation,
          child: Column(
            children: [
              BackArrow(decorator: decorator, themeData: themeData),
              SizedBox(
                height: size.height * 0.05,
              ),
              Text(
                'Wassup Toluwanimi, how are you',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'feeling right now?',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              _currentValue >= 0 && _currentValue < 2
                  ? Image.asset(
                      'assets/images/sadaf.png',
                      color: themeData ? Colors.black : Colors.white,
                    )
                  : _currentValue >= 2 && _currentValue < 4
                      ? Image.asset(
                          'assets/images/sademoji.png',
                          color: themeData ? Colors.black : Colors.white,
                        )
                      : _currentValue >= 4 && _currentValue < 6
                          ? Image.asset(
                              'assets/images/second.png',
                              color: themeData ? Colors.black : Colors.white,
                            )
                          : _currentValue >= 6 && _currentValue < 8
                              ? Image.asset(
                                  'assets/images/happyemoji.png',
                                  color:
                                      themeData ? Colors.black : Colors.white,
                                )
                              : Image.asset(
                                  'assets/images/happyaf.png',
                                  color:
                                      themeData ? Colors.black : Colors.white,
                                ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Platform.isIOS
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: decorator.copyWith(
                          borderRadius: BorderRadius.circular(40),
                          color:
                              themeData ? Colors.grey[300] : Colors.grey[900],
                        ),
                        child: CupertinoSlider(
                            thumbColor: themeData ? Colors.black : Colors.white,
                            activeColor:
                                themeData ? Colors.black45 : Colors.white54,
                            max: 10,
                            min: 0,
                            value: _currentValue,
                            onChangeStart: (value) {
                              setState(() {
                                selected = true;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                _currentValue = value;
                              });
                            }),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: decorator.copyWith(
                          borderRadius: BorderRadius.circular(30),
                          color:
                              themeData ? Colors.grey[300] : Colors.grey[900],
                        ),
                        child: Center(
                          child: Slider(
                              inactiveColor: Colors.grey,
                              thumbColor:
                                  themeData ? Colors.black : Colors.white,
                              activeColor:
                                  themeData ? Colors.black45 : Colors.white54,
                              max: 10,
                              min: 0,
                              value: _currentValue,
                              onChangeStart: (value) {
                                setState(() {
                                  selected = true;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  _currentValue = value;
                                });
                              }),
                        ),
                      ),
                    ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('How was your day?'),
                    _currentValue >= 0 && _currentValue < 2
                        ? Text('super sad')
                        : _currentValue >= 2 && _currentValue < 4
                            ? Text('sad')
                            : _currentValue >= 4 && _currentValue < 6
                                ? Text('meh')
                                : _currentValue >= 6 && _currentValue < 8
                                    ? Text('happy')
                                    : Text('super happy')
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.15,
              ),
              GestureDetector(
                  onTap: () {
                    if (selected)
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ReasonPage()));
                  },
                  child: selected
                      ? NextneonBtn(
                          size: size,
                          label: 'Next',
                        )
                      : NextBtn(
                          size: size,
                          themeData: themeData,
                          label: 'Next',
                        ))
            ],
          ),
        ),
      ),
    );
  }
}

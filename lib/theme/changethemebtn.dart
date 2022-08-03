import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kudidemo/providers/theme_provider.dart';

import 'package:provider/provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeProvider>(context).darkTheme;
    return Consumer<ThemeProvider>(
      builder: (context, notifier, child) => Platform.isIOS
          ? CupertinoSwitch(
              activeColor: Colors.black45,
              thumbColor: Colors.black,
              trackColor: Colors.grey,
              value: notifier.darkTheme,
              onChanged: (val) {
                notifier.toggleTheme();
                //bool value of switch which is true or false
              },
            )
          : Switch.adaptive(
              value: notifier.darkTheme,
              onChanged: (val) {
                notifier.toggleTheme();
                //bool value of switch which is true or false
              },
              activeTrackColor: Colors.black45,
              activeColor: Colors.black,
              inactiveTrackColor: Colors.grey,
            ),
    );
  }
}

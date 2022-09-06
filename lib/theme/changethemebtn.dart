import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kudidemo/theme/theme_enum.dart';

import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Consumer<ThemeProvider>(
                builder: (context, notifier, child) => Expanded(
                      child: ListView.builder(
                          itemCount: AppTheme.values.length,
                          itemBuilder: (_, index) {
                            final theme = AppTheme.values[index];
                            return Card(
                              color: appThemeData[theme]!.backgroundColor,
                              child: ListTile(
                                onTap: () {
                                  themeData.setTheme(theme);
                                },
                                title: Text(
                                  enumName(theme),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          }),
                    )),
            Container(
              height: 150,
              width: 150,
              decoration:
                  decorator.copyWith(color: Theme.of(context).backgroundColor),
            )
          ],
        ),
      ),
    );
  }
}

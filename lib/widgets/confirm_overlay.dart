import 'package:flutter/material.dart';

class ConfirmOverlay extends StatelessWidget {
  const ConfirmOverlay(
      {Key? key,
      required this.decorator,
      required this.selectedDate,
      required this.title,
      required this.onTap})
      : super(key: key);
  final void Function()? onTap;
  final BoxDecoration decorator;
  final String title;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Theme.of(context).backgroundColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text('Are you sure you want to save this $title?',
                style: TextStyle(
                    fontSize: 20,
                    // fontWeight: FontWeight.w300,
                    color: Theme.of(context).textTheme.bodyText2!.color,
                    fontFamily:
                        Theme.of(context).textTheme.bodyText2!.fontFamily)),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 70,
                      width: 70,
                      child: Center(
                        child: Icon(Icons.close),
                      ),
                      decoration: decorator.copyWith(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.red.withAlpha(225),
                                blurRadius: 45,
                                spreadRadius: 15,
                                offset: Offset(0, 0))
                          ],
                          gradient: LinearGradient(
                              colors: [Colors.red, Colors.redAccent],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft),
                          shape: BoxShape.circle,
                          color: Theme.of(context).backgroundColor),
                    )),
                GestureDetector(
                    onTap: onTap,
                    child: Container(
                      height: 70,
                      width: 70,
                      child: Center(
                        child: Icon(Icons.check),
                      ),
                      decoration: decorator.copyWith(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.green.withAlpha(225),
                                blurRadius: 45,
                                spreadRadius: 15,
                                offset: Offset(0, 0))
                          ],
                          gradient: LinearGradient(
                              colors: [Colors.green, Colors.greenAccent],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft),
                          shape: BoxShape.circle,
                          color: Theme.of(context).backgroundColor),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

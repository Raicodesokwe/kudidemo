import 'package:flutter/material.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({
    Key? key,
    required this.decorator,
  }) : super(key: key);

  final BoxDecoration decorator;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: decorator.copyWith(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(10.0)),
              height: 50,
              width: 50,
              child: Center(
                  child: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).textTheme.bodyText2!.color,
              )),
            ),
          )),
    );
  }
}

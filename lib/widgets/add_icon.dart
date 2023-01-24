import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddIcon extends StatefulWidget {
  const AddIcon({
    Key? key,
    required this.selectedTab,
    required this.selected,
  }) : super(key: key);

  final int selectedTab;
  final bool selected;

  @override
  State<AddIcon> createState() => _AddIconState();
}

class _AddIconState extends State<AddIcon> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    if (widget.selected) {
      controller.addListener(() {
        setState(() {});
      });

      controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              height: 36,
              width: 36,
              child: Icon(
                FontAwesomeIcons.wallet,
                color: widget.selectedTab == 0 ? Colors.green : Colors.black,
              )),
          Text(
            'Add',
            style: TextStyle(
                color: widget.selectedTab == 0 ? Colors.green : Colors.black),
          )
        ],
      ),
    );
  }
}

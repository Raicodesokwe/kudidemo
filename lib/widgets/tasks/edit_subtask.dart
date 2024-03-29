import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/utils/utils.dart';
import 'package:kudidemo/widgets/edit_text_field.dart';
import 'package:kudidemo/widgets/text_field.dart';
import 'package:provider/provider.dart';

import '../../models/task_model.dart';
import '../../providers/task_provider.dart';
import '../../providers/theme_provider.dart';

class EditSubtaskOverlay extends StatefulWidget {
  final String subTask;
  EditSubtaskOverlay({
    Key? key,
    required this.subTask,
  });
  @override
  State<StatefulWidget> createState() => EditSubtaskOverlayState();
}

class EditSubtaskOverlayState extends State<EditSubtaskOverlay>
    with SingleTickerProviderStateMixin {
  String? subtaskText = '';
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
    final task = TaskModel(subtask: subtaskText);
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
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
                    Text(
                      'Add subtask',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    EditTextField(
                        initialValue: widget.subTask,
                        emptytext: 'subtask is empty',
                        onChanged: (value) {
                          subtaskText = value;
                        }),
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
                            child: Text('Cancel',
                                style: GoogleFonts.prompt(
                                    color: Color.fromARGB(255, 12, 99, 212),
                                    fontWeight: FontWeight.w600))),
                        GestureDetector(
                          onTap: subtaskText != ''
                              ? () {
                                  Provider.of<TaskProvider>(context,
                                          listen: false)
                                      .addSubtask(task);
                                  Navigator.of(context).pop();
                                }
                              : () {
                                  Navigator.of(context).pop();
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

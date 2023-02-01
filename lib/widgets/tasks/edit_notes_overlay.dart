import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/utils/utils.dart';
import 'package:kudidemo/widgets/edit_text_field.dart';
import 'package:kudidemo/widgets/text_field.dart';
import 'package:provider/provider.dart';

import '../../models/task_model.dart';
import '../../providers/task_provider.dart';
import '../../providers/theme_provider.dart';

class EditNotesOverlay extends StatefulWidget {
  final String notes;
  EditNotesOverlay({Key? key, required this.notes});
  @override
  State<StatefulWidget> createState() => EditNotesOverlayState();
}

class EditNotesOverlayState extends State<EditNotesOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  TextEditingController notesController = TextEditingController();
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

  String noteText = '';
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
    final task = TaskModel(notes: noteText);
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
                      'Additional notes',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2!.color,
                          fontSize: 15),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    EditTextField(
                        initialValue: widget.notes,
                        emptytext: 'Add additional notes',
                        onChanged: (value) {
                          noteText = value;
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
                          onTap: noteText != ''
                              ? () {
                                  Provider.of<TaskProvider>(context,
                                          listen: false)
                                      .addNotes(task);
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

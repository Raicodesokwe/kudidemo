import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/models/billable_model.dart';
import 'package:kudidemo/providers/bilable_provider.dart';
import 'package:kudidemo/utils/utils.dart';
import 'package:kudidemo/widgets/edit_text_field.dart';
import 'package:kudidemo/widgets/text_field.dart';
import 'package:provider/provider.dart';

import '../../models/task_model.dart';
import '../../providers/task_provider.dart';

class EditBillingOverlay extends StatefulWidget {
  final double hourlyRate;
  EditBillingOverlay({Key? key, required this.hourlyRate});
  @override
  State<StatefulWidget> createState() => EditBillingOverlayState();
}

class EditBillingOverlayState extends State<EditBillingOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  TextEditingController nameController = TextEditingController();
  TextEditingController dollarController = TextEditingController();
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

  double hourlyRate = 0;

  @override
  Widget build(BuildContext context) {
    final task = TaskModel(hourlyRate: hourlyRate);
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
    // final bill = BillableModel(
    //     name: nameController.text, amount: double.parse(dollarController.text));
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
                child:
                    Consumer<TaskProvider>(builder: (context, notifier, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Hourly rate \$'),
                      EditTextField(
                        initialValue: widget.hourlyRate.toString(),
                        prefixIcon: Icon(FontAwesomeIcons.dollarSign),
                        onChanged: (value) {
                          hourlyRate = double.parse(value);
                        },
                        keyboardType: TextInputType.number,
                        emptytext: 'Enter Hourly rate',
                      ),
                      SizedBox(
                        height: size.height * 0.02,
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
                            onTap: () {
                              // notifier.addBills(bill);
                              notifier.addHourlyRate(task);
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
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

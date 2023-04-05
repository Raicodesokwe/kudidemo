import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/models/budget_model.dart';
import 'package:kudidemo/models/schedule_model.dart';
import 'package:kudidemo/models/type_model.dart';
import 'package:kudidemo/providers/budget_provider.dart';
import 'package:kudidemo/widgets/next_button.dart';
import 'package:kudidemo/widgets/nextneon_button.dart';
import 'package:provider/provider.dart';
import '../text_field.dart';

class AddBudget extends StatefulWidget {
  const AddBudget({Key? key}) : super(key: key);

  @override
  State<AddBudget> createState() => _AddBudgetState();
}

class _AddBudgetState extends State<AddBudget> {
  int _selectedIndex = 0;
  int _typeIndex = 0;
  final _newBudgetForm = GlobalKey<FormState>();
  checkFields() {
    final form = _newBudgetForm.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  String? budgetName;
  String? selectedSchedule;
  double? amountName;
  Future saveForm() async {
    final isValid = _newBudgetForm.currentState!.validate();
    if (isValid) {
      final budgetItem = BudgetModel(
          name: budgetName,
          amount: amountName,
          budgetType: typeList[_typeIndex].name,
          budgetSchedule: scheduleList[_selectedIndex].name);
      final budgetProvider =
          Provider.of<BudgetProvider>(context, listen: false);
      budgetProvider.addBudgetItems(budgetItem);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: _newBudgetForm,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Icon(FontAwesomeIcons.windowMinimize)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Add budget item',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: CustomTextField(
                    emptytext: 'Add a valid budget name',
                    hintText: 'Budget name',
                    onChanged: (value) {
                      budgetName = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: CustomTextField(
                    keyboardType: TextInputType.number,
                    emptytext: 'Add a valid amount',
                    hintText: 'Amount',
                    onChanged: (value) {
                      amountName = double.parse(value);
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text('Budget Type'),
                Row(
                  children: List.generate(
                    typeList.length,
                    (index) => Expanded(
                        child: RadioListTile(
                            value: index,
                            groupValue: _typeIndex,
                            contentPadding: const EdgeInsets.all(0.0),
                            activeColor: Colors.green,
                            dense: true,
                            tileColor: Theme.of(context).backgroundColor,
                            title: Text(
                              typeList[index].name,
                              style: GoogleFonts.prompt(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .color),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onChanged: (int? val) {
                              setState(() {
                                _typeIndex = val!;
                              });
                            })),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text('Budget Schedule'),
                Row(
                  children: List.generate(
                    scheduleList.length,
                    (index) => Expanded(
                        child: RadioListTile(
                            value: index,
                            groupValue: _selectedIndex,
                            contentPadding: const EdgeInsets.all(0.0),
                            activeColor: Colors.green,
                            dense: true,
                            tileColor: Theme.of(context).backgroundColor,
                            title: Text(
                              scheduleList[index].name,
                              style: GoogleFonts.prompt(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .color),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onChanged: (int? val) {
                              setState(() {
                                _selectedIndex = val!;
                              });
                            })),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Center(
                    child: amountName != null && budgetName != null
                        ? GestureDetector(
                            onTap: () {
                              if (checkFields()) {
                                saveForm();
                              }
                            },
                            child: NextneonBtn(size: size, label: 'Done'))
                        : NextBtn(size: size, label: 'Done')),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

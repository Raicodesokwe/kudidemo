import 'package:flutter/material.dart';
import 'package:kudidemo/providers/task_provider.dart';
import 'package:kudidemo/widgets/task_data_source.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DateTaskModal extends StatefulWidget {
  const DateTaskModal({Key? key}) : super(key: key);

  @override
  State<DateTaskModal> createState() => _DateTaskModalState();
}

class _DateTaskModalState extends State<DateTaskModal> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(builder: (context, notifier, ch) {
      final selectedTasks = notifier.eventsOfSelectedDate;
      if (selectedTasks.isEmpty) {
        return Center(
          child: Text('No Tasks found'),
        );
      }
      return SfCalendar(
        view: CalendarView.timelineDay,
        dataSource: TaskDataSource(notifier.tasks),
        initialDisplayDate: notifier.selectedDate,
        appointmentBuilder: appointmentBuilder,
      );
    });
  }

  Widget appointmentBuilder(
      BuildContext context, CalendarAppointmentDetails details) {
    final tasks = details.appointments.first;
    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
          color: Color(tasks.color), borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Text(
          tasks.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: Theme.of(context).textTheme.bodyText2!.fontFamily),
        ),
      ),
    );
  }
}

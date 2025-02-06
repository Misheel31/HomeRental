import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateChange;

  const DatePickerWidget({
    super.key,
    required this.selectedDate,
    required this.onDateChange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: selectedDate ?? DateTime.now(),
        selectionColor: Colors.amber,
        selectedTextColor: Colors.white,
        onDateChange: onDateChange,
      ),
    );
  }
}

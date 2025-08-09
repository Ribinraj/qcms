import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qcms/core/colors.dart';
// import 'package:qcms/core/colors.dart'; // Uncomment and use your colors

class CustomDateTimePicker extends StatefulWidget {
  final DateTime? selectedDateTime;
  final String hintText;
  final void Function(DateTime?)? onChanged;
  final String? Function(DateTime?)? validator;
  final FocusNode? focusNode;

  const CustomDateTimePicker({
    Key? key,
    this.selectedDateTime,
    this.hintText = "Select Date & Time",
    this.onChanged,
    this.validator,
    this.focusNode,
  }) : super(key: key);

  @override
  State<CustomDateTimePicker> createState() => _CustomDateTimePickerState();
}

class _CustomDateTimePickerState extends State<CustomDateTimePicker> {
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.selectedDateTime ?? DateTime.now();
  }

  String _formatDateTime(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('MMM dd, yyyy');
    final DateFormat timeFormat = DateFormat('hh:mm a');
    return '${dateFormat.format(dateTime)} at ${timeFormat.format(dateTime)}';
  }

  Future<void> _selectDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Appcolors.kprimarycolor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
              secondary: Appcolors.ksecondarycolor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Appcolors.kprimarycolor,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ), dialogTheme: DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && mounted) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          _selectedDateTime ?? DateTime.now(),
        ),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Appcolors.kprimarycolor,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black87,
                secondary: Appcolors.ksecondarycolor,
              ),
              timePickerTheme: TimePickerThemeData(
                backgroundColor: Colors.white,
                hourMinuteTextColor: Colors.black87,
                hourMinuteColor: const Color(0xFFE8E4F3),
                dialHandColor: Appcolors.kprimarycolor,
                dialBackgroundColor: const Color(0xFFE8E4F3),
                dialTextColor: Colors.black87,
                entryModeIconColor: Appcolors.kprimarycolor,
                dayPeriodTextColor: Colors.black87,
                dayPeriodColor: const Color(0xFFE8E4F3),
                dayPeriodBorderSide: BorderSide(color: Appcolors.kprimarycolor),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Appcolors.kprimarycolor,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        final DateTime newDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          _selectedDateTime = newDateTime;
        });

        widget.onChanged?.call(newDateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectDateTime,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE8E4F3),
          border: Border(
            bottom: BorderSide(color: Appcolors.kbordercolor, width: 1.5),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  _selectedDateTime != null
                      ? _formatDateTime(_selectedDateTime!)
                      : widget.hintText,
                  style: TextStyle(
                    fontSize: _selectedDateTime != null ? 16 : 15,
                    color: _selectedDateTime != null
                        ? Colors.black87
                        : const Color.fromARGB(255, 108, 106, 106),
                  ),
                ),
              ),
              Icon(Icons.date_range, color: Appcolors.kprimarycolor, size: 23),
            ],
          ),
        ),
      ),
    );
  }
}

// Example usage in another page
class ExampleUsagePage extends StatefulWidget {
  const ExampleUsagePage({Key? key}) : super(key: key);

  @override
  State<ExampleUsagePage> createState() => _ExampleUsagePageState();
}

class _ExampleUsagePageState extends State<ExampleUsagePage> {
  DateTime? _selectedMeetingDateTime;
  DateTime? _selectedDeadlineDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DateTime Picker Example'),
        backgroundColor: const Color(0xFF6366F1),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Meeting Schedule',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            CustomDateTimePicker(
              hintText: "Select meeting date & time",
              selectedDateTime: _selectedMeetingDateTime,
              onChanged: (DateTime? dateTime) {
                setState(() {
                  _selectedMeetingDateTime = dateTime;
                });
                print('Meeting scheduled for: $dateTime');
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Project Deadline',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            CustomDateTimePicker(
              hintText: "Select deadline date & time",
              selectedDateTime: _selectedDeadlineDateTime,
              onChanged: (DateTime? dateTime) {
                setState(() {
                  _selectedDeadlineDateTime = dateTime;
                });
                print('Deadline set for: $dateTime');
              },
            ),
            const SizedBox(height: 32),
            if (_selectedMeetingDateTime != null ||
                _selectedDeadlineDateTime != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8E4F3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF6366F1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Selected Times:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (_selectedMeetingDateTime != null)
                      Text(
                        'Meeting: ${DateFormat('MMM dd, yyyy \'at\' hh:mm a').format(_selectedMeetingDateTime!)}',
                      ),
                    if (_selectedDeadlineDateTime != null)
                      Text(
                        'Deadline: ${DateFormat('MMM dd, yyyy \'at\' hh:mm a').format(_selectedDeadlineDateTime!)}',
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

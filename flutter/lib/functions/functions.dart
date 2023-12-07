import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/model/task_model.dart';
import 'package:reminder_app/services/notification_service.dart';

TextEditingController dropDownController = TextEditingController();
TimeOfDay selectedTime = const TimeOfDay(hour: 0, minute: 0);
DateTime selectedDate = DateTime.now();

updateTime(StateSetter updateState, TimeOfDay data) {
  updateState(() {
    selectedTime = data;
  });
}

updateDate(StateSetter updateState, DateTime data) {
  updateState(() {
    selectedDate = data;
  });
}

_showTimePicker(BuildContext context, state) {
  showTimePicker(
    context: context,
    initialTime:
        TimeOfDay.fromDateTime(DateTime.now().add(const Duration(minutes: 2))),
  ).then((value) {
    if (value != null) {
      updateTime(state, value);
    }
  });
}

_showDatePicker(BuildContext context, state) {
  showDatePicker(
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    context: context,
    firstDate: DateTime.now(),
    initialDate: DateTime.now(),
    lastDate: DateTime(2030),
  ).then((value) {
    if (value != null) {
      updateDate(state, value);
    }
  });
}

StatefulBuilder statefulBottomSheet(BuildContext context) {
  return StatefulBuilder(
    builder: (context, state) => Container(
      height: 370,
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownMenu(
            controller: dropDownController,
            width: MediaQuery.of(context).size.width - 64,
            label: const Text("Select task"),
            dropdownMenuEntries: tasks
                .map((e) => DropdownMenuEntry(value: e, label: e))
                .toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            "Select a time",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedTime.format(context),
                style: const TextStyle(fontSize: 16),
              ),
              GestureDetector(
                onTap: () {
                  _showTimePicker(context, state);
                },
                child: const Icon(Icons.timer_sharp),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            "Select a date",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.yMMMd().format(selectedDate),
                style: const TextStyle(fontSize: 16),
              ),
              GestureDetector(
                onTap: () {
                  _showDatePicker(context, state);
                },
                child: const Icon(Icons.date_range),
              ),
            ],
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              var text = dropDownController.text;
              if (text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Please select a task!"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Close"),
                      )
                    ],
                  ),
                );
                return;
              }

              var selectedDateTime = DateTime(
                selectedDate.year,
                selectedDate.month,
                selectedDate.day,
                selectedTime.hour,
                selectedTime.minute,
              );
              final task = TaskModel(
                  taskID: 0 + Random().nextInt(9999),
                  title: text,
                  datetime: selectedDateTime);
              taskList.add(task);
              taskDB.put('taskList', taskList);
              NotificationService().showNotification(text, selectedDateTime);
              dropDownController.clear();
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Add task",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

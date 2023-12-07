import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(1)
  final int taskID;

  @HiveField(2)
  final String title;
  
  @HiveField(3)
  final DateTime datetime;

  @HiveField(4)
  TaskModel({required this.taskID, required this.title, required this.datetime});
}

var taskList = [];

final taskDB = Hive.box("taskList");

final List<String> tasks = [
  "Wake up",
  "Go to gym",
  "Breakfast",
  "Meetings",
  "Lunch",
  "Quick nap",
  "library",
  "Dinner",
  "Go to sleep",
];

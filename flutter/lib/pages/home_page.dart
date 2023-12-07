import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/functions/functions.dart';
import 'package:reminder_app/main.dart';
import 'package:reminder_app/model/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    print(taskDB.get('taskList')[0].taskID);
    taskList = taskDB.get('taskList') ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    addTask() {
      return showModalBottomSheet(
        context: context,
        builder: (context) => statefulBottomSheet(context),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reminder App"),
      ),
      body: taskList.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.alarm_add,
                  size: 80,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 16),
                Text(
                  "No task added!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[350],
                    fontSize: 18,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                var dt = DateFormat.yMMMd()
                    .add_jm()
                    .format(taskList[index].datetime);
                return ListTile(
                  title: Text(taskList[index].title),
                  subtitle: Text(dt),
                  trailing: GestureDetector(
                    onTap: () {
                      notificationsPlugin.cancel(taskList[index].taskID);
                      taskList.removeAt(index);
                      taskDB.put('taskList', taskList);
                      setState(() {});
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.red[400],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTask().then((value) => {setState(() {})});
        },
        child: const Icon(Icons.add_task_rounded),
      ),
    );
  }
}

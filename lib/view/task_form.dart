import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/TaskController.dart';
import '../helper/NotificationService.dart';
import '../model/task_model.dart';

class TaskForm extends StatefulWidget {
  final Task? task;

  TaskForm({this.task});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final priority = RxString('Low');

  final controller = Get.find<TaskController>();

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      titleCtrl.text = widget.task!.title;
      descCtrl.text = widget.task!.description;
      priority.value = widget.task!.priority;
    }
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(title: Text(widget.task == null ? 'Add Task' : 'Edit Task')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleCtrl,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descCtrl,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 10),
            Obx(() => DropdownButton<String>(
              value: priority.value,
              items: ['Low', 'Medium', 'High']
                  .map(
                    (p) => DropdownMenuItem(
                  value: p,
                  child: Text(p),
                ),
              )
                  .toList(),
              onChanged: (v) {
                if (v != null) priority.value = v;
              },
            )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newTask = Task(
                  id: widget.task?.id,
                  title: titleCtrl.text,
                  description: descCtrl.text,
                  priority: priority.value,
                );

                if (widget.task == null) {
                  controller.addTask(newTask);
                  NotificationService.showNotification(
                    title: 'Task Added',
                    body: 'Task "${newTask.title}" has been added.',
                  );
                } else {
                  controller.updateTask(newTask);
                  NotificationService.showNotification(
                    title: 'Task Updated',
                    body: 'Task "${newTask.title}" has been updated.',
                  );
                }

                Get.back();
              },
              child: Text(widget.task == null ? 'Save' : 'Update'),
            ),

          ],
        ),
      ),
    );
  }
}

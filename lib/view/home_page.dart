import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:todo_task_demo/view/task_form.dart';

import '../controller/TaskController.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Priority Tasks'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Low'),
              Tab(text: 'Medium'),
              Tab(text: 'High'),
            ],
          ),
        ),
        body: Obx(() {
          return TabBarView(
            children: ['Low', 'Medium', 'High'].map((priority) {
              final filtered = controller.getByPriority(priority);
              return ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (_, index) {
                  final task = filtered[index];
                  return Container(
                    margin: EdgeInsetsGeometry.all(10),
                    child: ListTile(
                      title: Text(task.title),
                      subtitle: Text(task.description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(icon: Icon(Icons.edit), onPressed: () {
                            Get.to(() => TaskForm(task: task));
                          }),
                          IconButton(icon: Icon(Icons.delete), onPressed: () {
                            controller.deleteTask(task.id!);
                          }),
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        }),
        floatingActionButton: FloatingActionButton(

          onPressed: () => Get.to(() => TaskForm()),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

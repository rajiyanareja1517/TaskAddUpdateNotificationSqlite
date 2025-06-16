import 'package:get/get.dart';

import '../helper/DBHelper.dart';
import '../model/task_model.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;

  @override
  void onInit() {
    fetchTasks();
    super.onInit();
  }

  void fetchTasks() async {
    tasks.value = await DBHelper.getTasks();
  }

  void addTask(Task task) async {
    await DBHelper.insert(task);
    fetchTasks();
  }

  void updateTask(Task task) async {
    await DBHelper.update(task);
    fetchTasks();
  }

  void deleteTask(int id) async {
    await DBHelper.delete(id);
    fetchTasks();
  }

  List<Task> getByPriority(String priority) {
    return tasks.where((task) => task.priority == priority).toList();
  }
}

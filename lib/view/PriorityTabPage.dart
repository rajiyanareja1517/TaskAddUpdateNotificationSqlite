import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Prioritytabpage extends StatelessWidget {
   Prioritytabpage({super.key});
  final List<Tab> priorityTabs = [
    Tab(text: 'Low Priority'),
    Tab(text: 'Medium Priority'),
    Tab(text: 'High Priority'),
  ];

  final List<Widget> priorityViews = [
    PriorityList(priority: 'Low', color: Colors.green),
    PriorityList(priority: 'Medium', color: Colors.orange),
    PriorityList(priority: 'High', color: Colors.red),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: priorityTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Priority Tabs'),
          bottom: TabBar(tabs: priorityTabs),
        ),
        body: TabBarView(children: priorityViews),
      ),
    );
  }
}
class PriorityList extends StatelessWidget {
  final String priority;
  final Color color;

  const PriorityList({required this.priority, required this.color});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (_, index) => Card(
        color: color.withOpacity(0.2),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          leading: Icon(Icons.flag, color: color),
          title: Text('$priority Task ${index + 1}'),
          subtitle: Text('This is a $priority priority task.'),
        ),
      ),
    );
  }}
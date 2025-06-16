class Task {
  int? id;
  String title;
  String description;
  String priority; // 'Low', 'Medium', 'High'

  Task({this.id, required this.title, required this.description, required this.priority});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      priority: map['priority'],
    );
  }
}

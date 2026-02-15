class TaskModel {
  String? id;
  String? title;
  String? description;
  String? taskDate;
  String? status;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.taskDate,
    this.status,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    title = json['title']?.toString();
    description = json['description']?.toString();
    taskDate = json['task_date']?.toString();
    status = json['status']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['task_date'] = taskDate;
    data['status'] = status;
    return data;
  }
}

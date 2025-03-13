class TodoModel {
  String title;
  String subtitle;
  bool isCompleted;

  TodoModel(this.title, this.subtitle, this.isCompleted);

  TodoModel.fromJson(Map<String, dynamic> json)
    : title = json['title'],
      subtitle = json['subtitle'],
      isCompleted = json['isCompleted'];

  Map<String, dynamic> toJson() => {
    'title': title,
    'subtitle': subtitle,
    'isCompleted': isCompleted,
  };
}

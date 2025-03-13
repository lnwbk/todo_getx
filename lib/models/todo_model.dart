class TodoModel {
  String title;
  String subtitle;
  bool isCompleted;
  String? uid;
  String? docid;

  TodoModel(
    this.title,
    this.subtitle,
    this.isCompleted, {
    this.uid,
    this.docid,
  });

  TodoModel.fromJson(Map<String, dynamic> json)
    : title = json['title'],
      subtitle = json['subtitle'],
      uid = json['uid'],
      docid = json['docid'],
      isCompleted = json['isCompleted'];

  Map<String, dynamic> toJson() => {
    'title': title,
    'subtitle': subtitle,
    'isCompleted': isCompleted,
    'uid': uid,
    'docid': docid,
  };
}

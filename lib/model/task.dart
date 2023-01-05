class Task {
 late  String title;
 late  var studentId;
 late  String updatedAt;
 late  String createdAt;
 late  int id;
 late  bool isDone;


  Task.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    studentId = json['student_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    isDone = json['is_done'];
  }

}
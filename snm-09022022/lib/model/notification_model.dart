class NotificationData {
  int id;
  String title;
  String body;
  String date;

  NotificationData({
    this.id,
    this.title,
    this.body,
    this.date,
  });

  NotificationData.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    body = map['body'];
    date = map['date'];
  }
}

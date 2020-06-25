class Reminder {
  String title;
  String id;
  String date;
  String userId;
  String time;
  String createdAt;
  bool completed;

  Reminder({this.title, this.date, this.time, this.id, this.createdAt, this.userId, this.completed});

  factory Reminder.fromMap(Map<String, dynamic> doc){
    return Reminder(
      title: doc['title'],
      time : doc['time'],
      id: doc['id'],
      date: doc['date'],
      userId: doc['userId'],
      completed: doc['completed'],
      createdAt: doc['createdAt']
    );
  }
}
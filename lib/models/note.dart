class Note {
  String title;
  String content;
  String id;
  String date;
  String userId;
  String createdAt;
  bool important;

  Note({this.title, this.content, this.date, this.id, this.createdAt, this.userId, this.important});

  factory Note.fromMap(Map<String, dynamic> doc){
    return Note(
      title: doc['title'],
      content: doc['content'],
      id: doc['id'],
      date: doc['date'],
      userId: doc['userId'],
      important: doc['important'],
      createdAt: doc['createdAt']
    );
  }
}
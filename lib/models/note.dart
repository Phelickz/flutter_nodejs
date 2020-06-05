class Note {
  String title;
  String content;
  String id;
  String createdAt;

  Note({this.title, this.content, this.createdAt, this.id});

  factory Note.fromMap(Map<String, dynamic> doc){
    return Note(
      title: doc['title'],
      content: doc['content'],
      id: doc['id'],
      createdAt: doc['createdAt']
    );
  }
}
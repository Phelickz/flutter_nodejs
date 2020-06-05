import 'package:flutter/material.dart';
import 'package:flutter_node_js/models/note.dart';
import 'package:flutter_node_js/state/noteState.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NoteProvider _noteProvider = NoteProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.note_add),
        onPressed: (){}),
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: FutureBuilder<List<Note>>(
          future: _noteProvider.getAllNotes(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? snapshot.data.isNotEmpty
                    ? ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          Note note = snapshot.data[index];
                          return Card(
                            child: ListTile(
                              title: Text(note.title),
                              subtitle: Text(note.content),
                              trailing: Text(note.createdAt),
                            ),
                          );
                        })
                    : Center(child: Text('No New Notes'))
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }
}

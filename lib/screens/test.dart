import 'package:flutter/material.dart';
import 'package:flutter_node_js/services/api.dart';
import 'package:flutter_node_js/state/state.dart';
import 'package:provider/provider.dart';


class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

  ApiService _apiService = ApiService();

  @override
  void initState() {
    NoteState noteState = Provider.of<NoteState>(context, listen: false);
    _apiService.getAllNotes(noteState);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    NoteState noteState = Provider.of<NoteState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: noteState.noteList.isNotEmpty ?
      
      ListView.builder(
        itemCount: noteState.noteList.length,
        itemBuilder: (context, index){
          var _data = noteState.noteList[index];
          return Card(
            child: ListTile(
              title: Text(_data.title),
              subtitle: Text(_data.content),
              trailing: Text(_data.createdAt),
            ),
          );
        }) : Center(child: Text('No new notes')),
    );
  }
}
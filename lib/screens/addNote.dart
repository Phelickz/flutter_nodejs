import 'package:flutter/material.dart';
import 'package:flutter_node_js/models/note.dart';
import 'package:flutter_node_js/pageviews/notepage.dart';
import 'package:flutter_node_js/services/snackBarService.dart';
import 'package:flutter_node_js/state/noteState.dart';
import 'package:flutter_node_js/utils/colors.dart';
import 'package:flutter_node_js/utils/strings.dart';
import 'package:flutter_node_js/utils/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  bool important = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  final _scaffold = GlobalKey<ScaffoldState>();

  NoteProvider noteProvider = NoteProvider();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffold,
      floatingActionButton: _floatingAction(),
      appBar: AppBar(
        actions: <Widget>[
          Switch(
              inactiveTrackColor: Colors.red,
              inactiveThumbColor: Colors.white70,
              value: important,
              onChanged: (val) {
                setState(() {
                  important = val;
                  if (important == true) {
                    _scaffold.currentState.showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Note set as important')));
                  }
                });
              })
        ],
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: GlobalColors.redColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'New Note',
          style: TextStyle(color: GlobalColors.redColor),
        ),
      ),
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                width: width,
                color: Color(0xff171719),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    validator: UsernameValidator.validate,
                    controller: _titleController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  width: width,
                  color: Color(0xff171719),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                        validator: UsernameValidator.validate,
                        controller: _contentController,
                        style: TextStyle(color: Colors.white),
                        expands: true,
                        maxLines: null,
                        minLines: null,
                        decoration: InputDecoration(
                          hintText: 'Content',
                          hintStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                          border: InputBorder.none,
                        )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _floatingAction() {
    return Builder(
      builder: (BuildContext _context) {
        SnackBarService.instance.buildContext = _context;
        return FloatingActionButton.extended(
            backgroundColor: GlobalColors.redColor,
            icon: Icon(
              Icons.cloud_upload,
              color: Colors.black,
            ),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              String userID = prefs.getString('userID');
              DateTime now = DateTime.now();
              String day = days[now.weekday];
              int date = now.day;
              String month = months[now.month];
              final String currentDate = '${day} ${date} ${month}';
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                noteProvider
                    .addNote(Note(
                        title: _titleController.text,
                        content: _contentController.text,
                        date: currentDate,
                        userId: userID,
                        important: important))
                    .then((value) {
                  if (value != null) {
                    Future.delayed(Duration(seconds: 3)).then((value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => NotePage()));
                    });
                  }
                });
              }
            },
            label: Text(
              'Save Note',
              style: TextStyle(color: Colors.black),
            ));
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_node_js/models/note.dart';
import 'package:flutter_node_js/responsiveness/dimensions.dart';
import 'package:flutter_node_js/screens/addNote.dart';
import 'package:flutter_node_js/services/api.dart';
import 'package:flutter_node_js/state/noteState.dart';
import 'package:flutter_node_js/state/state.dart';
import 'package:flutter_node_js/utils/colors.dart';
import 'package:flutter_node_js/utils/strings.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  NoteProvider noteProvider = NoteProvider();
  SizeConfig sizeConfig = SizeConfig();
  

  bool important = false;
  int notes = 0;
  int imp = 0;

  @override
  void initState() {
    NoteState notestate = Provider.of<NoteState>(context, listen: false);
    noteProvider.getAllNotes(notestate);
    noteProvider.getImportantNotes(notestate);
    SchedulerBinding.instance.addPostFrameCallback((_) { 
      setState(() {
        notes = notestate.noteList.length;
        imp = notestate.importantNote.length;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<NoteState>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
          elevation: 10,
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
          backgroundColor: GlobalColors.redColor,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddNote()));
          }),
      body: Padding(
        padding: const EdgeInsets.only(left: 40, right: 30),
        child: SingleChildScrollView(
          // primary: true,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                _text(),
                SizedBox(height: 20),
                Container(
                  width: width,
                  height: height * 0.25,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      InkWell(
                          onTap: () {
                            setState(() {
                              important = !important;
                            });
                          },
                          child: _cards(width, height, 'Notes', notes.toString(), true)),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              important = !important;
                            });
                          },
                          child:
                              _cards(width, height, 'Important', imp.toString(), false)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: width,
                    height: height,
                    child: SingleChildScrollView(
                      primary: true,
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            important ? 'Important' : 'General',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white54),
                          ),
                          Container(
                            width: width,
                            height: height,
                            child: ListView.builder(
                                // shrinkWrap: false,
                                physics: BouncingScrollPhysics(),
                                itemCount: important ? state.importantNote.length : state.noteList.length,
                                itemBuilder: (context, index) {
                                  var _data = important ? state.importantNote[index] : state.noteList[index];
                                  return important
                                      ? imp == 0  ? Center(child: Text('No important notes', style: TextStyle(
                                            color: Colors.white
                                          ))) : _importantNotes(height, width, _data)
                                      : _notes(height, width, _data);
                                }),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

   Widget _importantNotes(double height, double width, Note data) {
    return Card(
      color: Color(0xff171719),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNote(
            note: NoteMode.Editing,
            title: data.title,
            content: data.content,
            noteID: data.id,
          )));
        },
              child: Container(
          // width: sizeConfig.xMargin(context, 100),
          height: sizeConfig.yMargin(context, 24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white70),
                ),
                SizedBox(height: 10),
                Expanded(
                    child: Text(
                  data.content,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white24),
                )),
                Text(data.createdAt.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white70))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _notes(double height, double width, Note data) {
    return Card(
      color: Color(0xff171719),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNote(
            note: NoteMode.Editing,
            title: data.title,
            content: data.content,
            noteID: data.id,
          )));
        },
              child: Container(
          // width: sizeConfig.xMargin(context, 100),
          height: sizeConfig.yMargin(context, 24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white70),
                ),
                SizedBox(height: 10),
                Expanded(
                    child: Text(
                  data.content,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white24),
                )),
                Text(data.date,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white70))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cards(
      double width, double height, String title, String number, bool selected) {
    return Card(
      color: title == 'Notes'
          ? important ? Color(0xff171719) : GlobalColors.redColor
          : important ? GlobalColors.redColor : Color(0xff171719),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: width * 0.36,
        height: height * 0.24,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: title == 'Notes'
                      ? important ? Colors.white38 : Colors.black
                      : important ? Colors.black : Colors.white38
                ),
              ),
              Text(number,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: selected ? Colors.black : Colors.white38))
            ],
          ),
        ),
      ),
    );
  }

  Widget _text() {
    return Text(
      'Notes.',
      style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: GlobalColors.redColor),
    );
  }
}

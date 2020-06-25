import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_node_js/models/note.dart';
import 'package:flutter_node_js/models/reminders.dart';
import 'package:flutter_node_js/responsiveness/dimensions.dart';
import 'package:flutter_node_js/screens/addNote.dart';
import 'package:flutter_node_js/state/noteState.dart';
import 'package:flutter_node_js/state/state.dart';
import 'package:flutter_node_js/utils/colors.dart';
import 'package:flutter_node_js/utils/strings.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  final _uid;
  DashBoard(this._uid);
  @override
  _DashBoardState createState() => _DashBoardState(this._uid);
}

class _DashBoardState extends State<DashBoard> {
  bool _darkTheme = true;
  final _uid;

  String username;

  DateTime dateTime = DateTime.now();
  _DashBoardState(this._uid);

  NoteProvider noteProvider = NoteProvider();

  SizeConfig config = SizeConfig();

  int imp = 0;
  int reminders = 0;

  @override
  void initState() {
    getUserDetails();
    NoteState noteState = Provider.of<NoteState>(context, listen: false);
    noteProvider.getImportantNotes(noteState);
    noteProvider.getAllReminders(noteState);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      imp = noteState.importantNote.length;
      reminders = noteState.reminders.length;
    });
    super.initState();
  }

  void getUserDetails() async {
    noteProvider.getUser().then((user) {
      if (user != null) {
        setState(() {
          username = user.name;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<NoteState>(context);
    return Scaffold(
      backgroundColor: Color(0xff171719),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: config.yMargin(context, 4),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: config.xMargin(context, 3)),
                child: Row(
                  children: <Widget>[
                    Container(),
                    Spacer(),
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          '${days[this.dateTime.weekday]} ${this.dateTime.day} ${months[this.dateTime.month]}',
                          style: TextStyle(
                              color: GlobalColors.redColor,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),

              SizedBox(
                height: config.yMargin(context, 3),
              ),
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: config.xMargin(context, 4)),
                  height: config.yMargin(context, 16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Hi ${username ?? ''}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: config.textSize(context, 7),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: config.yMargin(context, 2)),
                        Text(
                          'Here is a list of schedule',
                          style: TextStyle(color: Colors.white70),
                        ),
                        SizedBox(height: config.yMargin(context, 1)),
                        Text(
                          'you need to check...',
                          style: TextStyle(color: Colors.white70),
                        )
                      ],
                    ),
                  )),

              /// CHats
              ///
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: config.xMargin(context, 6)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: _darkTheme ? Colors.black87 : Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin:
                              EdgeInsets.only(top: config.yMargin(context, 5)),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Recent Schedules",
                                style: TextStyle(
                                    color: _darkTheme
                                        ? Colors.white
                                        : Colors.black45,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 15,
                                child: Text(
                                  reminders.toString(),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white60),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: config.yMargin(context, 30),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.reminders.length,
                                itemBuilder: (context, index) {
                                  Reminder data = state.reminders[index];
                                  return index <= 2
                                      ? _reminders(data)
                                      : Container();
                                })),
                        Container(
                          margin:
                              EdgeInsets.only(top: config.yMargin(context, 5)),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Important Notes",
                                style: TextStyle(
                                    color: _darkTheme
                                        ? Colors.white
                                        : Colors.black45,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              CircleAvatar(
                                radius: 15,
                                child: Text(
                                  imp.toString(),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white60),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: config.yMargin(context, 40),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.importantNote.length,
                                itemBuilder: (context, index) {
                                  Note data = state.importantNote[index];
                                  return index <= 2
                                      ? _notes(data)
                                      : Container();
                                })),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _reminders(Reminder reminder) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Color(0xff171719),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
        child: Row(
          children: <Widget>[
            Text(
              reminder.time ?? '9:30',
              style: TextStyle(
                  fontSize: config.textSize(context, 4),
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              width: config.xMargin(context, 6),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  reminder.title,
                  style: TextStyle(
                      fontSize: config.textSize(context, 5),
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  reminder.date,
                  style: TextStyle(
                      fontSize: config.textSize(context, 4.5),
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _notes(Note note) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddNote(
          note: NoteMode.Editing,
          content: note.content,
          title: note.title,
          noteID: note.id,
        )));
      },
          child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(0xff171719),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: config.yMargin(context, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  note.title,
                  style: TextStyle(
                      fontSize: config.textSize(context, 5),
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Expanded(
                  child: Text(
                    note.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: config.textSize(context, 4),
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  ),
                ),
                Text(
                  note.date,
                  style: TextStyle(
                      fontSize: config.textSize(context, 3),
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

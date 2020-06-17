import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_node_js/state/noteState.dart';
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

  @override
  void initState() {
    getUserDetails();
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
    return Scaffold(
      backgroundColor: Color(0xff171719),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
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
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Hi ${username ?? ''}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Here is a list of schedule',
                        style: TextStyle(color: Colors.white70),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'you need to check...',
                        style: TextStyle(color: Colors.white70),
                      )
                    ],
                  )),

              /// CHats
              ///
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
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
                          margin: EdgeInsets.only(top: 30),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Recent",
                                style: TextStyle(
                                    color: _darkTheme
                                        ? Colors.white
                                        : Colors.black45,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              _reminders(),
                              SizedBox(height: 5,),
                              _reminders(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _reminders() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Color(0xff171719),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
        child: Row(
          children: <Widget>[
            Text(
              '9:30',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Expanded(
                child: Column(
              children: <Widget>[
                Text(
                  'Ikeja Lagos',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  'Somewhere',
                  style: TextStyle(
                      fontSize: 20,
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
}

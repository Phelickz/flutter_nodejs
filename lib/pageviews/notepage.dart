import 'package:flutter/material.dart';
import 'package:flutter_node_js/screens/addNote.dart';
import 'package:flutter_node_js/utils/colors.dart';
import 'package:flutter_node_js/utils/strings.dart';

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  bool important = false;
  @override
  Widget build(BuildContext context) {
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
                          child: _cards(width, height, 'Notes', '143', true)),
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
                              _cards(width, height, 'Important', '5', false)),
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
                                shrinkWrap: true,
                                // physics: NeverScrollableScrollPhysics(),
                                itemCount: 7,
                                itemBuilder: (context, index) {
                                  return important
                                      ? _cards(width, height, 'title', 'number',
                                          false)
                                      : _notes(height, width);
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

  Widget _notes(double height, double width) {
    return Card(
      color: Color(0xff171719),
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
                'CVE 212 Notes',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white70),
              ),
              SizedBox(height: 10),
              Expanded(
                  child: Text(
                test,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white24),
              )),
              Text('8 Dec',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white70))
            ],
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

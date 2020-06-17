import 'package:flutter/material.dart';
import 'package:flutter_node_js/screens/addReminder.dart';
import 'package:flutter_node_js/utils/colors.dart';

class Reminders extends StatefulWidget {
  @override
  _RemindersState createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
          backgroundColor: GlobalColors.redColor,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddReminders()));
          }),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              _text(),
              SizedBox(height: 20),
              _reminders(width, height)
            ],
          ),
        ),
      ),
    );
  }

  Widget _reminders(double width, double height) {
    return Builder(builder: (BuildContext _context) {
      return Container(
        width: width,
        height: height,
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return _remindersContainer();
            }),
      );
    });
  }

  Widget _remindersContainer() {
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
            )),
            Checkbox(
              
              checkColor: Colors.black,
              value: checked, onChanged: (value){
                print('value changed');
                setState(() {
                  checked = value;
                });
              })
          ],
        ),
      ),
    );
  }

  Widget _text() {
    return Text(
      'Reminders.',
      style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: GlobalColors.redColor),
    );
  }
}

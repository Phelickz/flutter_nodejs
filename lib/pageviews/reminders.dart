import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_node_js/models/reminders.dart';
import 'package:flutter_node_js/responsiveness/dimensions.dart';
import 'package:flutter_node_js/screens/addReminder.dart';
import 'package:flutter_node_js/state/noteState.dart';
import 'package:flutter_node_js/state/state.dart';
import 'package:flutter_node_js/utils/colors.dart';
import 'package:flutter_node_js/widgets/remindercontainer.dart';
import 'package:provider/provider.dart';

class Reminders extends StatefulWidget {
  @override
  _RemindersState createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  SizeConfig config = SizeConfig();
  bool checked = false;

  NoteProvider noteProvider = NoteProvider();

  @override
  void initState() {
    NoteState noteState = Provider.of<NoteState>(context, listen: false);
    noteProvider.getAllReminders(noteState);
    super.initState();
  }

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
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddReminders()));
          }),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
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
      final state = Provider.of<NoteState>(context);
      return Container(
        width: width,
        height: height,
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: state.reminders.length,
            itemBuilder: (context, index) {
              Reminder data = state.reminders[index];
              return state.reminders.isEmpty
                  ? Center(
                      child: Text(
                        'You have 0 tasks today',
                        style: TextStyle(color: Colors.white60),
                      ),
                    )
                  : ReminderContainer(
                      reminder: data,
                    );
            }),
      );
    });
  }

  Widget _remindersContainer(Reminder reminder) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Color(0xff171719),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
        child: Row(
          children: <Widget>[
            Container(
              width: 7,
              height: 60,
              color: reminder.completed ?? false
                  ? Colors.green
                  : GlobalColors.redColor,
            ),
            SizedBox(width: config.xMargin(context, 7)),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  reminder.title,
                  style: TextStyle(
                      decoration: checked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      decorationColor: Colors.black,
                      decorationThickness: 3,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                 reminder.completed ? 'completed': reminder.time ?? 'Time not set',
                  style: TextStyle(
                      fontSize: config.textSize(context, 4),
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                )
              ],
            )),
            Checkbox(
                activeColor: Colors.green,
                checkColor: Colors.black,
                value: checked,
                onChanged: (value) {
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
      'Tasks',
      style: TextStyle(
          fontSize: config.textSize(context, 6.5),
          fontWeight: FontWeight.bold,
          color: GlobalColors.redColor),
    );
  }
}

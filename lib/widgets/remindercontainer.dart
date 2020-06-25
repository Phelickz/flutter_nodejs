import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_node_js/models/reminders.dart';
import 'package:flutter_node_js/responsiveness/dimensions.dart';
import 'package:flutter_node_js/utils/colors.dart';




class ReminderContainer extends StatefulWidget {
  final Reminder reminder;

  const ReminderContainer({Key key, this.reminder}) : super(key: key);
  @override
  _ReminderContainerState createState() => _ReminderContainerState();
}

class _ReminderContainerState extends State<ReminderContainer> {
  bool checked = false;
  SizeConfig config = SizeConfig();
  @override
  void initState() {
   SchedulerBinding.instance.addPostFrameCallback((_) { 
     setState(() {
       checked = widget.reminder.completed ?? false;
     });
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
              color: checked ? Colors.green : GlobalColors.redColor,
            ),
            SizedBox(width: config.xMargin(context, 7)),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.reminder.title,
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
                  checked ? 'Completed': widget.reminder.time ?? 'Time not set',
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
}
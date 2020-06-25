import 'package:flutter/material.dart';
import 'package:flutter_node_js/models/reminders.dart';
import 'package:flutter_node_js/responsiveness/dimensions.dart';
import 'package:flutter_node_js/screens/bottombar.dart';
import 'package:flutter_node_js/services/api.dart';
import 'package:flutter_node_js/services/snackBarService.dart';
import 'package:flutter_node_js/state/noteState.dart';
import 'package:flutter_node_js/state/state.dart';
import 'package:flutter_node_js/utils/colors.dart';
import 'package:flutter_node_js/utils/strings.dart';
import 'package:flutter_node_js/utils/validator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddReminders extends StatefulWidget {
  @override
  _AddRemindersState createState() => _AddRemindersState();
}

class _AddRemindersState extends State<AddReminders> {
  AuthStatus status;
  SizeConfig config = SizeConfig();

  DateTime now = DateTime.now();

  final _formKey = GlobalKey<FormState>();

  NoteProvider noteProvider = NoteProvider();

  TextEditingController _titleController = TextEditingController();

  TimeOfDay timeOfDay;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<NoteState>(context);
    String newDate = DateFormat.jm().format(now);
    String newD = DateFormat.MMMEd().format(now);
    final noteState = Provider.of<NoteState>(context);
    //A lifesaver that helps to format date and time
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    return Scaffold(
      floatingActionButton: _floatingAction(),
      backgroundColor: Colors.black,
      appBar: AppBar(
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
          'New Reminder',
          style: TextStyle(color: GlobalColors.redColor),
        ),
      ),
      body: _form(localizations, noteState),
    );
  }

  Widget _form(MaterialLocalizations localizations, NoteState noteState) {
    return ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Form(
                  key: _formKey,
                  child: Container(
                    width: config.xMargin(context, 0),
                    color: Color(0xff171719),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        controller: _titleController,
                        validator: UsernameValidator.validate,
                        // controller: _titleController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: config.yMargin(context, 3)),
              Text(
                'Set Reminder time',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: config.yMargin(context, 2)),
              Container(child: _once(localizations, noteState)),
              SizedBox(height: config.yMargin(context, 3)),
              Text(
                'Set Reminder Date',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: config.yMargin(context, 2)),
              Container(child: _date(localizations, noteState))
            ],
          ),
        ));
  }

  _date(MaterialLocalizations localizations, NoteState noteState) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.access_time,
          color: GlobalColors.redColor,
        ),
        SizedBox(width: config.xMargin(context, 1.5)),
        InkWell(
          focusColor: Theme.of(context).primaryColorLight,
          splashColor: Colors.greenAccent,
          onTap: () => selectStartDate(context, noteState),
          child: Text(
            DateFormat.MMMEd().format(noteState.startDate),
            // localizations.formatTimeOfDay(db.firstTime),
            style: TextStyle(
                color: GlobalColors.redColor,
                fontSize: config.xMargin(context, 4.2)),
          ),
        ),
      ],
    );
  }

  Future<Null> selectStartDate(
      BuildContext context, NoteState noteState) async {
    final DateTime selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2900));
    if (selectedDate.difference(noteState.startDate).inDays < 0) {
      showSnackBar(context, text: "Cannot set reminder in the past");
    } else {
      if (selectedDate != null && selectedDate != noteState.startDate) {
        noteState.updateStartDate(selectedDate);
      }
    }
  }

  _once(MaterialLocalizations localizations, NoteState noteState) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.access_time,
          color: GlobalColors.redColor,
        ),
        SizedBox(width: config.xMargin(context, 1.5)),
        InkWell(
          focusColor: Theme.of(context).primaryColorLight,
          splashColor: Colors.greenAccent,
          onTap: () => selectFirstTime(context, noteState),
          child: Text(
            localizations.formatTimeOfDay(noteState.firstTime),
            // localizations.formatTimeOfDay(db.firstTime),
            style: TextStyle(
                color: GlobalColors.redColor,
                fontSize: config.xMargin(context, 4.2)),
          ),
        ),
      ],
    );
  }

  Future<Null> selectFirstTime(
      BuildContext context, NoteState noteState) async {
    TimeOfDay currentTime = TimeOfDay.now();
    final TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: noteState.firstTime,
    );

    if (noteState.isToday() && selectedTime.hour < currentTime.hour) {
      showSnackBar(context, text: "Cannot set reminder in the past");
    } else {
      if (selectedTime != null && selectedTime != noteState.firstTime) {
        noteState.updateFirstTime(selectedTime);
      }
    }
  }

  void showSnackBar(BuildContext context, {String text: 'Enter drug name'}) {
    SnackBar snackBar = SnackBar(
      backgroundColor: Theme.of(context).buttonColor.withOpacity(.9),
      duration: Duration(seconds: 2),
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: config.textSize(context, 5.3),
            color: Theme.of(context).primaryColorLight),
      ),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  Widget _floatingAction() {
    return Builder(
      builder: (BuildContext _context) {
        final noteState = Provider.of<NoteState>(context);

        SnackBarService.instance.buildContext = _context;
        MaterialLocalizations localizations = MaterialLocalizations.of(context);
        return status == AuthStatus.Authenticating
            ? CircularProgressIndicator()
            : FloatingActionButton.extended(
                icon: Icon(Icons.save),
                backgroundColor: GlobalColors.redColor,
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  String userID = prefs.getString('userID');
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    noteProvider
                        .addReminder(Reminder(
                            title: _titleController.text,
                            time: localizations
                                .formatTimeOfDay(noteState.firstTime),
                            date:
                                DateFormat.MMMEd().format(noteState.startDate),
                            userId: userID,
                            completed: false))
                        .then((value) {
                      if (value == null) {
                        Future.delayed(Duration(seconds: 1)).then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                        });
                      }
                    });
                  }
                },
                label: Text('Save'));
      },
    );
  }
}

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

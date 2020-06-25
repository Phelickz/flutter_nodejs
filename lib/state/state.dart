
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_node_js/models/note.dart';
import 'package:flutter_node_js/models/reminders.dart';
import 'package:flutter_node_js/models/user.dart';
import 'package:flutter_node_js/services/api.dart';
import 'package:flutter_node_js/state/noteState.dart';


class NoteState with ChangeNotifier {
  ApiService apiService = ApiService();

  List<Note> _noteList = [];
  List<Note> _importantNote = [];

  List<Reminder> _reminders = [];

  List<Reminder> get reminders => _reminders; 

  List<Note> get noteList => _noteList;

  List<Note> get importantNote => _importantNote;

  TimeOfDay firstTime = TimeOfDay.now();

  DateTime startDate = DateTime.now();

  set noteList(List<Note> noteList) {
    _noteList = noteList; 
    notifyListeners();
  }

  set importantNote(List<Note> importantNote) {
    _importantNote = importantNote; 
    notifyListeners();
  }

  set reminders(List<Reminder> reminders) {
    _reminders = reminders; 
    notifyListeners();
  }

  void updateFirstTime(TimeOfDay selected){
    this.firstTime = selected;
    notifyListeners();
  }

  void updateStartDate(DateTime newDate){
    this.startDate = newDate;
    notifyListeners();
  }

  bool isToday(){
    return this.startDate.difference(DateTime.now()) == 0;
  }

  Future<String> login(User user) {
    apiService.login(user);
    notifyListeners();
  }

  Future<String> register(User user) {
    apiService.register(user);
    notifyListeners();
  }

  Future<Note> addNote(Note note) {
   return apiService.addNote(note);
  }
}
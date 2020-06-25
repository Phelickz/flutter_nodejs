import 'package:flutter/cupertino.dart';
import 'package:flutter_node_js/models/note.dart';
import 'package:flutter_node_js/models/reminders.dart';
import 'package:flutter_node_js/models/user.dart';
import 'package:flutter_node_js/services/api.dart';
import 'package:flutter_node_js/state/state.dart';

ApiService _apiService = ApiService();



class NoteProvider {

  Future<Note> getNoteById(String uid) => _apiService.getNoteById(uid);

  Future<List<Note>> getImportantNotes(NoteState noteState) => _apiService.getImportantNotes(noteState);

  Future<List<Note>> getAllNotes(NoteState noteState) => _apiService.getAllNotes(noteState);
  
  Future<String> register(User user) => _apiService.register(user);

  Future<String> login(User user) => _apiService.login(user);

  Future<User> getUser() => _apiService.getUser();

  Future<Note> addNote(Note note) => _apiService.addNote(note);

  Future<List<Reminder>> getAllReminders(NoteState noteState) => _apiService.getAllReminders(noteState);

 
  Future<Reminder> addReminder(Reminder reminder) => _apiService.addReminder(reminder);
}

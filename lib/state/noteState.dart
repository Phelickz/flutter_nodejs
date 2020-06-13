import 'package:flutter/cupertino.dart';
import 'package:flutter_node_js/models/note.dart';
import 'package:flutter_node_js/models/user.dart';
import 'package:flutter_node_js/services/api.dart';
import 'package:flutter_node_js/state/state.dart';

ApiService _apiService = ApiService();

NoteState _noteState = NoteState();

class NoteProvider {

  Future<Note> getNoteById(String uid) => _apiService.getNoteById(uid);

  Future<List<Note>> getAllNotes() => _apiService.getAllNotes(_noteState);
  
  Future<String> register(User user) => _apiService.register(user);

  Future<String> login(User user) => _apiService.login(user);

  Future<User> getUser() => _apiService.getUser();

  Future<Note> addNote(Note note) => _apiService.addNote(note);
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_node_js/models/note.dart';
import 'package:flutter_node_js/services/api.dart';

ApiService _apiService = ApiService();

class NoteProvider {

  Future<Note> getNoteById(String uid) => _apiService.getNoteById(uid);

  Future<List<Note>> getAllNotes() => _apiService.getAllNotes();
  
}

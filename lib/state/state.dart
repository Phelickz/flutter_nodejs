
import 'package:flutter/cupertino.dart';
import 'package:flutter_node_js/models/note.dart';
import 'package:flutter_node_js/state/noteState.dart';


class NoteState with ChangeNotifier {
  List<Note> _noteList = [];
  List<Note> _importantNote = [];

  List<Note> get noteList => _noteList;

  List<Note> get importantNote => _importantNote;

  set noteList(List<Note> noteList) {
    _noteList = noteList; 
    notifyListeners();
  }

  set importantNote(List<Note> importantNote) {
    _importantNote = importantNote; 
    notifyListeners();
  }
}
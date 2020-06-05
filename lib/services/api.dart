import 'dart:convert';
import 'dart:io';

import 'package:flutter_node_js/models/note.dart';
import 'package:flutter_node_js/settings.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  Future<List<Note>> getAllNotes() async {
    Response response = await http.get(backendUrl);
    if (response.statusCode != 200) {
      print('Some error occured');
      return null;
    }

    List<Note> _finalNotes = [];
    List apiData = json.decode(response.body);

    for (var i = 0; i < apiData.length; i++) {
      _finalNotes.add(Note(
          title: apiData[i]['title'],
          content: apiData[i]['content'],
          id: apiData[i]['_id'],
          createdAt: apiData[i]['createdAt']));
    }
    return _finalNotes;
  }

  Future<Note> getNoteById(String uid) async {
    Response response = await http.get(backendUrl + "/${uid}");
    if (response.statusCode != 200) {
      print('Some error occured');
      return null;
    }

    Note note = json.decode(response.body);
    return note;
  }
}

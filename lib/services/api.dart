import 'dart:convert';
import 'dart:io';

import 'package:flutter_node_js/models/note.dart';
import 'package:flutter_node_js/models/user.dart';
import 'package:flutter_node_js/services/snackBarService.dart';

import 'package:flutter_node_js/state/state.dart';
import 'package:flutter_node_js/utils/settings.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus {
  NotAutheticated,
  Authenticating,
  Authenticated,
  UserNotFound,
  Error
}

class ApiService {
  AuthStatus status;

  Future<User> getUser() async {
    try {
      final preference = await SharedPreferences.getInstance();
      String apiKey = preference.getString('userID');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      print(apiKey);
      Response response =
          await http.get(getUserUrl + '/${apiKey}', headers: headers);
      print(response.statusCode);
      if (response.statusCode != 200) {
        status = AuthStatus.NotAutheticated;
        return null;
      }

      status = AuthStatus.Authenticated;
      final Map data = json.decode(response.body);
      final User user = User.fromMap(data);
      return user;
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    final preference = await SharedPreferences.getInstance();
    await preference.setString('userID', null);
  }

  Future<String> login(User user) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    Map data = {"email": user.email, "password": user.password};
    String payload = json.encode(data);
    Response response =
        await http.post(loginUrl, headers: headers, body: payload);
    if (response.statusCode == 500) {
      status = AuthStatus.Error;
      SnackBarService.instance.showSnackBarError('Server Error. Try again');
      return null;
    } else if (response.statusCode == 404) {
      status = AuthStatus.UserNotFound;
      SnackBarService.instance.showSnackBarError('User does not exists');
      return null;
    } else if (response.statusCode == 401) {
      status = AuthStatus.NotAutheticated;
      SnackBarService.instance
          .showSnackBarError('Password does not match user');
      return null;
    } else if (response.statusCode == 200) {
      final Map user = json.decode(response.body);
      String apiKey = user['data']['_id'];

      final preferences = await SharedPreferences.getInstance();
      await preferences.setString('userID', apiKey);
      status = AuthStatus.Authenticated;
      SnackBarService.instance
          .showSnackBarSuccess('Welcome back ${user['data']['name']}');
      print(apiKey);
      return apiKey;
    }

    status = AuthStatus.Error;
    SnackBarService.instance.showSnackBarError('Server Error. Try again');
    return null;
  }

  Future<String> register(User user) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    Map data = {
      "name": user.name,
      "email": user.email,
      "password": user.password
    };
    String payload = json.encode(data);
    Response response =
        await http.post(registerUrl, headers: headers, body: payload);
    if (response.statusCode == 400) {
      status = AuthStatus.UserNotFound;
      SnackBarService.instance
          .showSnackBarError('Email Address already exists');
      return null;
    } else if (response.statusCode == 405) {
      status = AuthStatus.UserNotFound;
      SnackBarService.instance.showSnackBarError('Username already exists');
      return null;
    } else if (response.statusCode == 500) {
      status = AuthStatus.Error;
      SnackBarService.instance.showSnackBarError('Server Error. Try again');
      return null;
    } else if (response.statusCode == 200) {
      final Map user = json.decode(response.body);
      String apiKey = user['data']['_id'];

      final preferences = await SharedPreferences.getInstance();
      await preferences.setString('userID', apiKey);
      status = AuthStatus.Authenticated;
      SnackBarService.instance.showSnackBarSuccess('Account created');
      print(apiKey);
      return apiKey;
    }

    status = AuthStatus.Error;
    SnackBarService.instance.showSnackBarError('Server Error. Try again');
    return null;
  }

  Future<List<Note>> getAllNotes(NoteState noteState) async {
    try {
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
            date: apiData[i]['date'],
            important: apiData[i]['important'],
            userId: apiData[i]['userID'],
            createdAt: apiData[i]['createdAt']));
      }

      noteState.noteList = _finalNotes;
      return _finalNotes;
    } catch (e) {
      print(e);
    }
  }

  Future<List<Note>> getImportantNotes(NoteState noteState) async {
    Response response = await http.get(getImportant);
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
          date: apiData[i]['date'],
          important: apiData[i]['important'],
          userId: apiData[i]['userID'],
          createdAt: apiData[i]['createdAt']));
    }

    noteState.importantNote = _finalNotes;
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

  Future<Note> addNote(Note note) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    Map data = {
      "title": note.title,
      "content": note.content,
      "date": note.date,
      "important": note.important
    };
    String payload = json.encode(data);
    Response response =
        await http.post(addNoteUrl, headers: headers, body: payload);
    if (response.statusCode != 200) {
      status = AuthStatus.Error;
      SnackBarService.instance
          .showSnackBarError('An error occurred. Try again');
      return null;
    }

    status = AuthStatus.Authenticated;
    SnackBarService.instance.showSnackBarSuccess('Note saved successful');
    return null;
  }
}

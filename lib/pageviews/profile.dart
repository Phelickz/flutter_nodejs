import 'package:flutter/material.dart';
import 'package:flutter_node_js/state/noteState.dart';
import 'package:flutter_node_js/utils/colors.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  NoteProvider noteProvider = NoteProvider();
  String username;
  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  void getUserDetails() async {
    noteProvider.getUser().then((user) {
      if (user != null) {
        setState(() {
          username = user.name;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                username ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: GlobalColors.redColor),
              ),
              SizedBox(height: 20),
              FloatingActionButton.extended(
                  backgroundColor: GlobalColors.redColor,
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                  label: Text(
                    'Sign out',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

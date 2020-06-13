import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_node_js/screens/home.dart';
import 'package:flutter_node_js/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottombar.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String apiKey;

  @override
  void initState() {
    _getApiKey();
    Timer(Duration(seconds: 5), () {
      if (apiKey == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      }

      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
    super.initState();
  }

  void _getApiKey() async {
    final preference = await SharedPreferences.getInstance();
    String key = preference.getString('userID') ?? null;
    setState(() {
      apiKey = key;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.grey[800],
        body: Container(
      color: GlobalColors.blackColor,
      child: Center(
          child: Text(
        'stylio.',
        style: TextStyle(
            color: Colors.red[800], fontSize: 35, fontWeight: FontWeight.bold),
      )),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_node_js/screens/login.dart';
import 'package:flutter_node_js/screens/register.dart';
import 'package:flutter_node_js/screens/splash.dart';
import 'package:flutter_node_js/screens/test.dart';
import 'package:flutter_node_js/state/state.dart';
import 'package:flutter_node_js/utils/colors.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NoteState())
      ],
          child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Splash(),
      ),
    );
  }
}

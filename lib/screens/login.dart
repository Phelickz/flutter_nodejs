import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_node_js/models/user.dart';
import 'package:flutter_node_js/screens/register.dart';
import 'package:flutter_node_js/services/snackBarService.dart';
import 'package:flutter_node_js/state/noteState.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  NoteProvider noteProvider = NoteProvider();
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Container(
          width: width,
          height: height * 0.7,
          // color: Colors.blue,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 48.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 33,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[800]),
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextFormField(
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.email),
                                  border: InputBorder.none,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                  // fillColor: Colors.white,
                                  // filled: true,
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextFormField(
                              obscureText: _obscureText,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: _obscureText
                                        ? Icon(Icons.enhanced_encryption)
                                        : Icon(Icons.no_encryption),
                                    onPressed: _toggle,
                                  ),
                                  border: InputBorder.none,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                  // fillColor: Colors.white,
                                  // filled: true,
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password ? ',
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                      SizedBox(height: 60),
                      _button(),
                      SizedBox(height: 10),
                      Align(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => Register()));
                          },
                          child: Text(
                            'No account? Register!',
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )));
  }

  Widget _button() {
    return Builder(
      builder: (BuildContext _context) {
        SnackBarService.instance.buildContext = _context;
        return FloatingActionButton.extended(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              noteProvider.login(User(
                  email: _emailController.text,
                  password: _passwordController.text)).then((apiKey) => {
                    if(apiKey!=null){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()))
                    }
                  });
            },
            backgroundColor: Colors.red[800],
            label: Text(
              'Sign In',
              style: TextStyle(color: Colors.black),
            ));
      },
    );
  }
}

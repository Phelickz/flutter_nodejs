import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_node_js/models/user.dart';
import 'package:flutter_node_js/screens/home.dart';
import 'package:flutter_node_js/screens/login.dart';
import 'package:flutter_node_js/services/snackBarService.dart';
import 'package:flutter_node_js/state/noteState.dart';
import 'package:flutter_node_js/utils/validator.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  NoteProvider noteProvider = NoteProvider();

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
          height: height * 0.8,
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
                        'Register',
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
                              controller: _emailController,
                              validator: EmailValidator.validate,
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
                      SizedBox(height: 20),
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
                              validator: UsernameValidator.validate,
                              controller: _usernameController,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  suffixIcon:
                                      Icon(Icons.supervised_user_circle),
                                  border: InputBorder.none,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                  // fillColor: Colors.white,
                                  // filled: true,
                                  labelText: 'Username',
                                  labelStyle: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
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
                              validator: PasswordValidator.validate,
                              controller: _passwordController,
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
                      SizedBox(height: 50),
                      _button(),
                      SizedBox(height: 10),
                      Align(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: Text(
                            'Have an account? Sign In!',
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
    return Builder(builder: (BuildContext _context) {
      SnackBarService.instance.buildContext = _context;

      return FloatingActionButton.extended(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            noteProvider
                .register(User(
                    name: _usernameController.text,
                    email: _emailController.text,
                    password: _passwordController.text))
                .then((apiKey) {
              if (apiKey != null) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              }
              return null;
            });
          },
          backgroundColor: Colors.red[800],
          label: Text(
            'Register',
            style: TextStyle(color: Colors.black),
          ));
    });
  }
}

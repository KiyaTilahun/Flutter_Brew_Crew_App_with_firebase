// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:real_firabse/services/auth.dart';
import 'package:real_firabse/services/auth.dart';
import 'package:real_firabse/shared/constants.dart';
import 'package:real_firabse/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = "";
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign in to Brew Crew'),
              actions: [
                TextButton.icon(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ), // Background color
                    ),
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    label: Text(
                      "Register",
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textinputDecoration,
                        validator: (val) =>
                            val!.isEmpty ? "Enter an Email" : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: passwordDecoration,
                        validator: (val) =>
                            val!.length < 6 ? " password to short " : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ), // Background color
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              print('valid');
                              setState(() {
                                loading = true;
                              });
                              dynamic result =
                                  await _auth.singInpass(email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'please supply a valid email';
                                });
                              }
                            }
                          },
                          child: Text(
                            "Sign IN",
                            style: TextStyle(color: Colors.white),
                          )),
                      SizedBox(height: 20),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                )),
          );
  }
}

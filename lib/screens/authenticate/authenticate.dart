// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:real_firabse/screens/authenticate/register.dart';
import 'package:real_firabse/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleview() {
    setState(() => showSignIn=!showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView:toggleview);
    } else {
      return Register(toggleView:toggleview);
    }
  }
}

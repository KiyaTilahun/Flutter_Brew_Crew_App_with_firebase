// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_firabse/screens/authenticate/authenticate.dart';
import 'package:real_firabse/screens/home/home.dart';

import '../models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}

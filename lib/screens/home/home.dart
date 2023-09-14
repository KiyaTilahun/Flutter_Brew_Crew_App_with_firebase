// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:real_firabse/screens/home/brew_list.dart';
import 'package:real_firabse/services/auth.dart';
import 'package:real_firabse/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return  StreamProvider<QuerySnapshot?>.value(
       initialData: null,
      value: DatabaseService.withoutUID().brews,
     
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            TextButton.icon(
              label: Text(
                "logout",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                await _auth.signout();
              },
              icon: Icon(
                Icons.person_2,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body:Brew_List() ,
      ),
    );
  }
}

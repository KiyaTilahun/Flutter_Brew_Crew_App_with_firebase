// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_firabse/models/user.dart';
import 'package:real_firabse/services/database.dart';
import 'package:real_firabse/shared/constants.dart';
import 'package:real_firabse/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  String? currentName;
  String? _currentSugars;
  late int _currenStrength = 100;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;

            return Form(
              key: _formkey,
              child: Column(
                children: [
                  Text(
                    'Update your brew Setting',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData?.name,
                    decoration: InputDecoration(hintText: "Name"),
                    validator: (val) =>
                        val!.isEmpty ? " please enter a name " : null,
                    onChanged: (val) {
                      setState(() {
                        currentName = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  // dropdown
                  DropdownButtonFormField(
                      value: _currentSugars ?? userData?.sugars,
                      decoration: InputDecoration(hintText: "No. of Sugars"),
                      items: sugars.map((e) {
                        return DropdownMenuItem(
                          child: Text("$e sugars"),
                          value: e,
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _currentSugars = val!;
                        });
                      }),
                  // slider
                  Slider(
                    value: (_currenStrength?.toInt() ?? userData!.strength)!
                        .toDouble(),
                    min: 100.0,
                    max: 900.0,
                    activeColor: Colors.brown[_currenStrength!.toInt()],
                    divisions: 8,
                    label: _currenStrength?.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currenStrength = value.round();
                      });
                    },
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ), // Background color
                      ),
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugars ?? userData!.sugars,
                              currentName ?? userData!.name,
                              _currenStrength ?? userData!.strength);

                          
                        }
                      },
                      child: Text(
                        " Update",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}

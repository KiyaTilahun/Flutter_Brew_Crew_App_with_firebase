import 'package:flutter/material.dart';
import 'package:real_firabse/models/brew.dart';
import 'package:real_firabse/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_firabse/screens/home/brew_tile.dart';

class Brew_List extends StatefulWidget {
  const Brew_List({super.key});

  @override
  State<Brew_List> createState() => _Brew_ListState();
}

class _Brew_ListState extends State<Brew_List> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>?>(context) ?? [];
    print(brews);
    brews!.forEach((brews) {
      print(brews.name);
      print(brews.sugars);
      print(brews.strength);
    });
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return BrewTile(brew: brews[index]);
      },
    );
  }
}

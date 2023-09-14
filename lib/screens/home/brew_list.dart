import 'package:flutter/material.dart';
import 'package:real_firabse/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Brew_List extends StatefulWidget {
  const Brew_List({super.key});

  @override
  State<Brew_List> createState() => _Brew_ListState();
}

class _Brew_ListState extends State<Brew_List> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<QuerySnapshot>(context);
    print(brews);
    for (var doc in brews.docs) {
      print(doc.data());
    }
    return Container();
  }
}

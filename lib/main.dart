import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_notes/pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyNotes',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: LoginPage(),
    );
  }
}

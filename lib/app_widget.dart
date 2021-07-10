import 'package:flutter/material.dart';
import 'package:my_notes/pages/create_account_page.dart';
import 'package:my_notes/pages/create_note_page.dart';
import 'package:my_notes/pages/home_page.dart';
import 'package:my_notes/pages/login_page.dart';
import 'package:my_notes/pages/reset_password_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyNotes',
      theme: ThemeData(
        primaryColor: Color(0xFF3EBC90),
      ),
      initialRoute: '/login',
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/create-account': (context) => CreateAccountPage(),
        '/create-note': (context) => CreateNotePage(),
        '/reset-password': (context) => ResetPasswordPage(),
      },
    );
  }
}

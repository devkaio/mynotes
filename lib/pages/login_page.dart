import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/pages/profile_page.dart';
import 'package:my_notes/services/fire_auth.dart';
import 'package:my_notes/shared/button_widget.dart';
import 'package:my_notes/shared/input_text_widget.dart';
import 'package:my_notes/shared/text_button_widget.dart';
import 'package:my_notes/shared/text_widget.dart';
import 'package:my_notes/validators/validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: SafeArea(
        child: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Image(
                              image:
                                  AssetImage('assets/images/login_image.png'),
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                            TextWidget(
                              text: 'Welcome back!',
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3EBC90),
                            ),
                            InputTextWidget(
                              label: 'E-mail',
                              hintText: 'Type your e-mail',
                              controller: _emailTextController,
                              focusNode: _focusEmail,
                              onChanged: (value) {},
                              obscureText: false,
                              validator: (value) =>
                                  Validator.validateEmail(email: value),
                            ),
                            InputTextWidget(
                              label: 'Password',
                              hintText: 'Type your password',
                              controller: _passwordTextController,
                              focusNode: _focusPassword,
                              onChanged: (value) {},
                              obscureText: true,
                              validator: (value) =>
                                  Validator.validatePassword(password: value),
                            ),
                            TextButtonWidget(
                              onPressed: () {
                                Navigator.pushNamed(context, '/reset-password');
                              },
                              text: 'Forgot Password',
                            ),
                            _isProcessing
                                ? CircularProgressIndicator()
                                : ButtonWidget(
                                    text: 'Sign in',
                                    onPressed: () async {
                                      _focusEmail.unfocus();
                                      _focusPassword.unfocus();
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          _isProcessing = true;
                                        });

                                        User? user = await FireAuth
                                            .signInUsingEmailPassword(
                                          email: _emailTextController.text,
                                          password:
                                              _passwordTextController.text,
                                        );

                                        setState(() {
                                          _isProcessing = false;
                                        });

                                        if (user != null) {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfilePage(user: user),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    color: Color(0xFF3EBC90),
                                  ),
                            TextButtonWidget(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  User? user =
                                      await FireAuth.signInUsingEmailPassword(
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text,
                                  );
                                  print('success');
                                  if (user != null) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProfilePage(user: user)),
                                    );
                                    print('fail');
                                  }
                                }
                              },
                              text: 'Don\'t have an account yet? Sign Up!',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

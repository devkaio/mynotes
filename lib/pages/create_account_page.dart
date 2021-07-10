import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/services/fire_auth.dart';
import 'package:my_notes/shared/button_widget.dart';
import 'package:my_notes/shared/input_text_widget.dart';
import 'package:my_notes/shared/text_button_widget.dart';
import 'package:my_notes/shared/text_widget.dart';
import 'package:my_notes/validators/validators.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final GlobalKey<FormState> _registerKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/create_account_image.png'),
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _registerKey,
                  child: Column(
                    children: [
                      TextWidget(
                        text: 'Ready to save everything?',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3EBC90),
                      ),
                      TextWidget(
                        text:
                            'Create your free account and start creating unlimited notes!',
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF262626),
                      ),
                      InputTextWidget(
                        label: 'Full name',
                        hintText: 'Type your full name',
                        controller: _nameTextController,
                        focusNode: _focusName,
                        validator: (value) =>
                            Validators.validateName(name: value),
                        obscureText: false,
                      ),
                      InputTextWidget(
                        label: 'Email',
                        hintText: 'Type your email',
                        controller: _emailTextController,
                        focusNode: _focusEmail,
                        validator: (value) =>
                            Validators.validateName(name: value),
                        obscureText: false,
                      ),
                      InputTextWidget(
                        label: 'Password',
                        hintText: 'Type your password',
                        controller: _passwordController,
                        focusNode: _focusPassword,
                        validator: (value) =>
                            Validators.validatePassword(password: value),
                        obscureText: true,
                      ),
                      _isProcessing
                          ? CircularProgressIndicator()
                          : ButtonWidget(
                              text: 'Register',
                              onPressed: () async {
                                setState(() {
                                  _isProcessing = true;
                                });

                                if (_registerKey.currentState!.validate()) {
                                  User? user =
                                      await FireAuth.registerUsingEmailPassword(
                                          fullName: _nameTextController.text,
                                          email: _emailTextController.text,
                                          password: _passwordController.text);

                                  addUser();

                                  setState(() {
                                    _isProcessing = false;
                                  });

                                  if (user != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Account created. Please sign in'),
                                      ),
                                    );
                                    Navigator.pushReplacementNamed(
                                        context, '/login');
                                  }
                                }
                              },
                              color: Color(0xFF3EBC90),
                            ),
                      TextButtonWidget(
                        onPressed: () {
                          Navigator.popUntil(
                            context,
                            ModalRoute.withName('/login'),
                          );
                        },
                        text: 'Already have an account? Sign In!',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addUser() {
    return users
        .add({
          'name': _nameTextController.text,
          'email': _emailTextController.text,
        })
        .then((value) => print('User created'))
        .catchError((error) => ('Failed to create user: $error'));
  }
}

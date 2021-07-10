import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/services/fire_auth.dart';
import 'package:my_notes/shared/button_widget.dart';
import 'package:my_notes/shared/input_text_widget.dart';
import 'package:my_notes/shared/text_widget.dart';
import 'package:my_notes/validators/validators.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();

  final _focusEmail = FocusNode();

  bool _isProcessing = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.pushReplacementNamed(context, '/profile');
    }

    return firebaseApp;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
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
                  image: AssetImage('assets/images/reset_password_image.png'),
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextWidget(
                        text: 'Need help with your password?',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3EBC90),
                      ),
                      TextWidget(
                        text:
                            'Request a reset link by typing your registered email below.',
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF262626),
                      ),
                      InputTextWidget(
                        label: 'Email',
                        hintText: 'Type your registered email',
                        controller: _emailTextController,
                        focusNode: _focusEmail,
                        validator: (value) =>
                            Validators.validateLoginEmail(email: value),
                        obscureText: false,
                      ),
                      _isProcessing
                          ? CircularProgressIndicator()
                          : ButtonWidget(
                              text: 'Reset Password',
                              onPressed: () async {
                                _focusEmail.unfocus();
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isProcessing = true;
                                  });
                                  User? user = await FireAuth.resetPassword(
                                      email: _emailTextController.text);

                                  setState(() {
                                    _isProcessing = false;
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Password reset sent to email.'),
                                    ),
                                  );

                                  Navigator.pushReplacementNamed(
                                      context, '/login');
                                }
                              },
                              color: Color(0xFF3EBC90),
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
}

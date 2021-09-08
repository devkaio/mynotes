import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateNotePage extends StatefulWidget {
  final String? title;
  final String? subtitle;
  CreateNotePage({
    Key? key,
    this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  _CreateNotePageState createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final formKey = GlobalKey<FormState>();
  var title;
  var subtitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                initialValue: widget.title,
                onChanged: (value) {
                  title = value;
                },
                validator: (value) =>
                    value!.isEmpty ? "Title precisa ser preeenchido" : null,
                decoration: InputDecoration(labelText: "Title"),
              ),
              TextFormField(
                initialValue: widget.subtitle,
                validator: (value) =>
                    value!.isEmpty ? "SubTitle precisa ser preeenchido" : null,
                onChanged: (value) {
                  subtitle = value;
                },
                decoration: InputDecoration(labelText: "Subtitle"),
              ),
              SizedBox(
                height: 48,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            addNote();
                            setState(() {});
                          },
                          child: Text("Save"))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void addNote() async {
    CollectionReference ref = FirebaseFirestore.instance
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('notes');

    var data = {
      'title': title,
      'subtitle': subtitle,
    };
    ref.add(data);
    Navigator.pop(context);
  }
}

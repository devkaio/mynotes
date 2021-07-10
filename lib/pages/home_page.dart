import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/pages/create_note_page.dart';

import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference notes = FirebaseFirestore.instance.collection('notes');

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: StreamBuilder(
            stream: notes.orderBy('title').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('Loading'));
              }

              return ListView(
                children: snapshot.data!.docs.map((note) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(note['title']),
                        subtitle: Text(note['subtitle']),
                        onLongPress: () {
                          note.reference.delete();
                        },
                      ),
                    ],
                  );
                }).toList(),
              );
            },
          ),
        ),
        persistentFooterButtons: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CreateNotePage()));
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}

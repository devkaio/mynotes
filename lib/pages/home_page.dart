import 'package:flutter/material.dart';
import 'package:my_notes/pages/create_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final notes = <Map<String, dynamic>>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            notes.length,
            (index) => Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreatePage(
                                title: notes[index]['title'],
                                subtitle: notes[index]['subtitle'],
                              ))).then((value) {
                    notes[index] = value;
                    setState(() {});
                  });
                },
                leading: Icon(Icons.book),
                title: Text(notes[index]['title']),
                subtitle: Text(notes[index]['subtitle']),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreatePage()))
              .then((value) {
            notes.add(value);
            setState(() {});
          });
        },
        icon: Icon(Icons.add),
        label: Text('Criar'),
      ),
    );
  }
}

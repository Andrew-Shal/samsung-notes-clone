import 'package:flutter/material.dart';
import 'blocs/notes_provider.dart';
import 'screens/notes_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NotesProvider(
      child: MaterialApp(
        title: 'Notes Application',
        home: Scaffold(body: NotesList()),
        theme: ThemeData.dark(),
      ),
    );
  }
}

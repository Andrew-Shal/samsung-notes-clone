import 'package:flutter/material.dart';
import 'notes_bloc.dart';
export 'notes_bloc.dart';

class NotesProvider extends InheritedWidget {
  final NotesBloc bloc;
  NotesProvider({Key key, Widget child})
      : bloc = NotesBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static NotesBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<NotesProvider>()).bloc;
  }
}

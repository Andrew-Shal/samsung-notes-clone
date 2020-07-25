import 'package:flutter/material.dart';
import '../../../../models/note_model.dart';

class NoteListItem extends StatelessWidget {
  final NoteModel _noteModel;
  NoteListItem(NoteModel noteModel) : _noteModel = noteModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Card(
              elevation: 5,
              shape: Border(right: BorderSide(color: Colors.red, width: 8)),
              child: ListTile(
                onTap: () {
                  print("note ${_noteModel.id} clicked!");
                },
                onLongPress: () {},
                title: Text('${_noteModel.title}'),
                subtitle: Row(children: buildSubtitle()),
              ),
            ))
      ],
    );
  }

  List<Widget> buildSubtitle() {
    // group date and favorite on one line
    List<Widget> children = [];
    children.add(Text('${_noteModel.dateCreated}'));

    // show/hide if is favorite
    if (_noteModel.isFavorite) {
      children.add(
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 15.0,
        ),
      );
    }
    return children;
  }
}

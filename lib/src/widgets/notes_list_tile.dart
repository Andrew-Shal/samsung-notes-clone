import 'package:flutter/material.dart';
import '../models/note_model.dart';

class NotesListTile extends StatelessWidget {
  final NoteModel noteItem;
  final onNoteItemLongPressed;
  NotesListTile({this.noteItem, this.onNoteItemLongPressed});

  @override
  Widget build(BuildContext context) {
    return buildTile(context, noteItem);
  }

  Widget buildTile(BuildContext context, NoteModel n) {
    return Column(children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Card(
            elevation: 5,
            shape: Border(right: BorderSide(color: Colors.red, width: 8)),
            child: ListTile(
              onTap: () {
                print("note ${n.id} clicked!");
                // Navigator.push();
              },
              onLongPress: () => onNoteItemLongPressed(n.id),
              title: Text('${n.title}'),
              subtitle: buildSubtitle(n),
            ),
          ))
    ]);
  }

  Row buildSubtitle(NoteModel n) {
    // group date and favorite on one line
    List<Widget> children = [];
    children.add(Text('${n.dateCreated}'));

    // show/hide if is favorite
    if (n.isFavorite) {
      children.add(
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 15.0,
        ),
      );
    }
    return Row(children: children);
  }
}

import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:notes_app/src/pages/note_editor/edit_note/controller.dart';

class NoteMoreOptions extends StatelessWidget {
  final EditNoteController editNoteController = Get.find();

  @override
  Widget build(BuildContext ctx) {
    return FocusedMenuHolder(
      blurSize: 2,
      // blurBackgroundColor: Colors.black,
      menuWidth: MediaQuery.of(ctx).size.width * 0.5,
      menuItemExtent: 70,
      animateMenuItems: false,
      duration: Duration(milliseconds: 100),
      menuBoxDecoration: BoxDecoration(color: Colors.black54, boxShadow: [
        BoxShadow(color: Colors.black54, blurRadius: 5, spreadRadius: 1),
      ]),
      child: IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () {},
        alignment: Alignment.centerRight,
      ),
      onPressed: () {},
      menuItems: <FocusedMenuItem>[
        FocusedMenuItem(
          title: Text('Delete'),
          onPressed: () {
            print('delete button activated');
            editNoteController.deleteNote();
          },
          backgroundColor: Colors.black54,
          trailingIcon: Icon(Icons.edit),
        ),
        FocusedMenuItem(
          title: Text('Pin to Home Screen'),
          onPressed: () {},
          backgroundColor: Colors.black54,
          trailingIcon: Icon(Icons.sort),
        ),
        FocusedMenuItem(
          title: Text('Print'),
          onPressed: () {},
          backgroundColor: Colors.black54,
          trailingIcon: Icon(Icons.view_column),
        )
      ],
    );
  }
}

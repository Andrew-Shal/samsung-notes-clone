import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

class AllNotesMoreOptions extends StatelessWidget {
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
          title: Text('Edit'),
          onPressed: () {},
          backgroundColor: Colors.black54,
          trailingIcon: Icon(Icons.edit),
        ),
        FocusedMenuItem(
          title: Text('Sort'),
          onPressed: () {},
          backgroundColor: Colors.black54,
          trailingIcon: Icon(Icons.sort),
        ),
        FocusedMenuItem(
          title: Text('View'),
          onPressed: () {},
          backgroundColor: Colors.black54,
          trailingIcon: Icon(Icons.view_column),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import './home_drawer_item.dart';

class HomeDrawer extends StatelessWidget {
  // ignore: todo
  // TODO : move over to separate file of get managed by state
  final List<Map<String, dynamic>> menuItems = [
    {
      "title": "",
      "leading": null,
      "type": "F_BTN",
      "trailing": Icons.settings,
    },
    {
      "title": 'All notes',
      "leading": Icons.book,
      "type": "LIST",
      "trailing": null,
    },
    {
      "title": 'Favorites',
      'leading': Icons.star,
      "type": "LIST",
      "trailing": null,
    },
    {
      "title": 'Frequently used',
      'leading': Icons.bookmark,
      "type": "LIST",
      "trailing": null,
    },
    {
      "title": 'Trash',
      'leading': Icons.delete,
      "type": "LIST",
      "trailing": null,
    },
    {
      "title": null,
      'leading': null,
      "type": "DIVIDER",
      "trailing": null,
    },
    {
      "title": "Categories",
      'leading': null,
      "type": "DROPDOWN",
      "trailing": null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: buildMenuItems(),
      ),
    );
  }

  List<Widget> buildMenuItems() {
    List<Widget> children = [];
    menuItems.forEach((element) {
      children.add(HomeDrawerItem(element));
    });
    return children;
  }
}

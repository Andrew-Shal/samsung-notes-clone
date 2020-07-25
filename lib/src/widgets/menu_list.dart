import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
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
      children.add(MenuListItem(element));
    });

    return children;
  }
}

class MenuListItem extends StatelessWidget {
  final menuData;
  MenuListItem(data) : menuData = data;

  @override
  Widget build(BuildContext context) {
    if (menuData['type'] == 'F_BTN') {
      return ListTile(
        trailing: IconButton(icon: Icon(menuData['trailing']), onPressed: null),
      );
    } else if (menuData['type'] == 'LIST') {
      return ListTile(
        leading: Icon(menuData['leading']),
        title: Text(menuData['title']),
      );
    } else if (menuData['type'] == 'DIVIDER') {
      return Divider(color: Colors.white);
    }

    // DropDown type
    return ListTile(
      title: Text(menuData['title']),
    );
  }
}

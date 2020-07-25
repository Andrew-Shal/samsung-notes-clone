import 'package:flutter/material.dart';

class HomeDrawerItem extends StatelessWidget {
  final menuData;
  HomeDrawerItem(data) : menuData = data;

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

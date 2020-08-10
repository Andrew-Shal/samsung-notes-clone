import 'package:flutter/material.dart';
import 'package:notes_app/src/pages/home/controller.dart';
import './note_list_item.dart';
import 'package:get/get.dart';

class NotesList extends StatelessWidget {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
          itemCount: controller.notes.length,
          itemBuilder: (context, int idx) {
            return NoteListItem(controller.notes.elementAt(idx));
          },
        ));
  }

  noItems() {
    return Center(child: Text("You don't have any notes"));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/src/pages/note_editor/edit_note/controller.dart';
import 'package:zefyr/zefyr.dart';

class EditNote extends StatelessWidget {
  @override
  build(BuildContext context) {
    return GetBuilder<EditNoteController>(
        init: EditNoteController(),
        builder: (ctrl) {
          return Scaffold(
              appBar: AppBar(
                  leading: BackButton(
                    onPressed: () {
                      // TODO : snackbar with option to save, discard, cancel changes
                      ctrl.saveDocument();
                      Get.back();
                      Get.snackbar("update", 'Note state sucesfully updated!');
                    },
                  ),
                  title: Text('Edit Note'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        ctrl.saveDocument();
                        Get.snackbar(
                            "update", 'Note state sucesfully updated!');
                      },
                      child: Text('save'),
                    )
                  ]),
              body: Container(
                child: Column(
                  children: [
                    TextField(
                      controller: TextEditingController()..text = ctrl.title,
                      onChanged: (value) {
                        ctrl.updateTitle(value);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title',
                      ),
                    ),
                    Expanded(child: zefScaffold(ctrl)),
                  ],
                ),
              ));
        });
  }

  Widget zefScaffold(EditNoteController _controller) {
    if (_controller.zefcontroller == null)
      return Text('An error occured when loading this document');
    return ZefyrScaffold(
        child: ZefyrEditor(
      controller: _controller.zefcontroller,
      focusNode: _controller.focusNode,
      autofocus: false,
    ));
  }
}

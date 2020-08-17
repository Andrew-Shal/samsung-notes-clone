import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/src/pages/note_editor/edit_note/controller.dart';
import 'package:zefyr/zefyr.dart';
import './widgets/note_more_options.dart';

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
                      ctrl.triggerUpdateDocument();
                    },
                  ),
                  title: Text('Edit Note'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        ctrl.updateDocument();
                      },
                      child: Text('save'),
                    ),
                    NoteMoreOptions(),
                  ]),
              body: Container(
                child: Column(
                  children: [
                    TextField(
                      controller: TextEditingController()
                        ..text = ctrl.bindedTitle,
                      onChanged: (value) {
                        ctrl.updateTitle(value);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title',
                      ),
                    ),
                    Expanded(child: zefScaffold(ctrl)),
                    Obx(() => confirmationBanner(ctrl)),
                  ],
                ),
              ));
        });
  }

  Widget confirmationBanner(EditNoteController _controller) {
    if (_controller.showConfirmation == false) return Container();

    return AlertDialog(
        content: Text('Save your changes or discard them?'),
        actions: <Widget>[
          RaisedButton(
            color: Colors.black54,
            onPressed: () {
              _controller.showConfirmation = false;
            },
            child: Text('Cancel'),
          ),
          Container(height: 40, child: VerticalDivider(color: Colors.white)),
          RaisedButton(
            color: Colors.black54,
            onPressed: () {
              Get.back();
              _controller.showConfirmation = false;
            },
            child: Text('Discard'),
          ),
          Container(height: 40, child: VerticalDivider(color: Colors.white)),
          RaisedButton(
            color: Colors.black54,
            onPressed: () {
              _controller.showConfirmation = false;
              _controller.updateDocument();
              Get.back();
            },
            child: Text('Save'),
          ),
        ]);
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

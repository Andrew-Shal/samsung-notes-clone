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
                      Get.toNamed('/');
                    },
                  ),
                  title: Text('Edit Note'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        ctrl.saveDocument();
                      },
                      child: Text('save'),
                    )
                  ]),
              body: Container(
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        ctrl.updateTitle(value);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'title',
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
      return Center(child: CircularProgressIndicator());
    return ZefyrScaffold(
        child: ZefyrEditor(
      controller: _controller.zefcontroller,
      focusNode: _controller.focusNode,
      autofocus: false,
    ));
  }
}

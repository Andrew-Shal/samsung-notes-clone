import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/src/pages/note_editor/new_note/controller.dart';
import 'package:zefyr/zefyr.dart';

class NewNote extends StatelessWidget {
  @override
  build(BuildContext context) {
    return GetBuilder<NewNoteController>(
        init: NewNoteController(),
        builder: (ctrl) {
          return Scaffold(
              appBar: AppBar(
                  leading: BackButton(
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  title: Text('New Note'),
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
                        hintText: 'Title',
                      ),
                    ),
                    Expanded(
                      child: ZefyrScaffold(
                        child: ZefyrEditor(
                          controller: ctrl.zefcontroller,
                          focusNode: ctrl.focusNode,
                          autofocus: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}

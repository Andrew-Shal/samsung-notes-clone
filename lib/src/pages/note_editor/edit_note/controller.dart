import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/src/controller.dart';
import '../../../models/note_model.dart';
import 'package:zefyr/zefyr.dart';
import 'package:quill_delta/quill_delta.dart';
import 'dart:convert';

class EditNoteController extends GetxController {
  AppController appController = Get.find();

  ZefyrController zefcontroller;
  FocusNode focusNode;

  NoteModel noteModel;

  String title = '';
  String note = ''; // not being observed, used only for initial value

  EditNoteController() {
    noteModel = Get.arguments as NoteModel;
    title = noteModel.title;
    note = noteModel.note;
    loadWYSIWYG();
  }

  loadWYSIWYG() async {
    focusNode = FocusNode();

    final document = NotusDocument.fromJson(jsonDecode(note));
    zefcontroller = ZefyrController(document);
  }

  void updateTitle(String newValue) {
    title = newValue;
  }

  void saveDocument() async {
    // here you should update the noteModel.title to value of temp title
    final contents = jsonEncode(zefcontroller.document.toJson());
    noteModel.title = title;
    noteModel.note = contents;
    final id = await appController.dbProvider.updateNote(noteModel);
    noteModel = await appController.dbProvider.fetchNote(id);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/src/controller.dart';
import '../../../models/note_model.dart';
import 'package:zefyr/zefyr.dart';
import 'package:quill_delta/quill_delta.dart';
import 'dart:convert';

class EditNoteController extends GetxController {
  AppController appController = Get.find();

  /// Allows to control the editor and the document.
  ZefyrController zefcontroller;

  /// Zefyr editor like any other input field requires a focus node.
  FocusNode focusNode;

  NoteModel noteModel;

  EditNoteController() {
    noteModel = NoteModel();
    loadWYSIWYG();
  }

  loadWYSIWYG() async {
    focusNode = FocusNode();

    // Here we must load the document and pass it to Zefyr controller.
    final document = await _loadDocument();
    zefcontroller = ZefyrController(document);
  }

  /// Loads the document to be edited in Zefyr.
  Future<NotusDocument> _loadDocument() async {
    noteModel = await appController.dbProvider
        .fetchNote(int.parse(Get.parameters['id']));
    final Delta delta = Delta()..insert(noteModel.note);
    return NotusDocument.fromDelta(delta);
  }

  void updateTitle(String newValue) {
    noteModel.title = newValue;
  }

  void saveDocument() {
    // Notus documents can be easily serialized to JSON by passing to
    // `jsonEncode` directly
    final contents = jsonEncode(zefcontroller.document);
    noteModel.note = contents;

    appController.dbProvider.insertNote(noteModel);
  }
}

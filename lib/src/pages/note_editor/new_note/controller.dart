import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/src/controller.dart';
import '../../../models/note_model.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';
import 'dart:convert';

class NewNoteController extends GetxController {
  AppController appController = Get.find();

  /// Allows to control the editor and the document.
  ZefyrController zefcontroller;

  /// Zefyr editor like any other input field requires a focus node.
  FocusNode focusNode;

  NoteModel noteModel;

  NewNoteController() {
    loadWYSIWYG();

    noteModel = NoteModel();
  }

  loadWYSIWYG() {
    // Here we must load the document and pass it to Zefyr controller.
    final document = _loadDocument();
    zefcontroller = ZefyrController(document);
    focusNode = FocusNode();
  }

  /// Loads the document to be edited in Zefyr.
  NotusDocument _loadDocument() {
    // For simplicity we hardcode a simple document with one line of text
    // saying "Zefyr Quick Start".
    // (Note that delta must always end with newline.)
    final Delta delta = Delta()..insert("Zefyr Quick Start\n");
    return NotusDocument.fromDelta(delta);
  }

  void updateTitle(String newValue) {
    noteModel.title = newValue;
    update();
  }

  void saveDocument() {
    // Notus documents can be easily serialized to JSON by passing to
    // `jsonEncode` directly
    final contents = jsonEncode(zefcontroller.document);
    noteModel.note = contents;
    print(noteModel.note);
    print(noteModel.title);

    appController.dbProvider.insertNote(noteModel);
    /*
    int id;
    String title;
    var note;
    bool isRemoved;
    bool isFavorite;
    CategoryModel category;
    DateTime dateCreated;
    */
  }
}

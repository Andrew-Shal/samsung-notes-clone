import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/src/controller.dart';
import 'package:notes_app/src/pages/home/controller.dart';
import '../../../models/note_model.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';
import 'dart:convert';

class NewNoteController extends GetxController {
  AppController appController = Get.find();
  HomeController homeController = Get.find();

  ZefyrController zefcontroller;
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
    update();
  }

  NotusDocument _loadDocument() {
    final Delta delta = Delta()..insert("Zefyr Quick Start\n");
    return NotusDocument.fromDelta(delta);
  }

  void updateTitle(String newValue) {
    noteModel.title = newValue;
  }

  void saveDocument() async {
    final contents = jsonEncode(zefcontroller.document.toJson());
    noteModel.note = contents;
    int id = await appController.dbProvider.insertNote(noteModel);

    // ignore: todo
    // TODO: instead of setting the id, we can set the entire inserted item and update notemodel to get info as date created, date updated, id, is removed, is favorite. then we can pass to route instead of fetching again on edit route
    noteModel.id = id;
    homeController.loadNotes();
    Get.back();
    Get.snackbar(
      "saved",
      "note sucessfully saved!",
    );
  }
}

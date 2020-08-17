import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/src/controller.dart';
import 'package:notes_app/src/pages/home/controller.dart';
import '../../../models/note_model.dart';
import 'package:zefyr/zefyr.dart';
import 'dart:convert';

class EditNoteController extends GetxController {
  AppController appController = Get.find();
  HomeController homeController = Get.find();

  ZefyrController zefcontroller;
  FocusNode focusNode;

  NoteModel noteModel;

  String bindedTitle = '';
  // not being observed, used only for initial value
  String initialNoteValue = '';

  // keep track of banner display
  RxBool _showConfirmation = RxBool(false);
  bool get showConfirmation => _showConfirmation.value;
  set showConfirmation(bool val) => _showConfirmation.value = val;

  EditNoteController() {
    noteModel = Get.arguments as NoteModel;

    bindedTitle = noteModel.title;
    initialNoteValue = noteModel.note;
    loadWYSIWYG();
  }

  loadWYSIWYG() async {
    focusNode = FocusNode();

    final document = NotusDocument.fromJson(jsonDecode(initialNoteValue));
    zefcontroller = ZefyrController(document);
  }

  void updateTitle(String newValue) {
    bindedTitle = newValue;
  }

  void updateDocument() async {
    // save changes
    final contents = jsonEncode(zefcontroller.document.toJson());
    noteModel.title = bindedTitle;
    noteModel.note = contents;
    final id = await appController.dbProvider.updateNote(noteModel);
    noteModel = await appController.dbProvider.fetchNote(id);
    Get.back();
    Get.snackbar("update", 'Note state sucesfully updated!');
  }

  void triggerUpdateDocument() {
    // check to see if changes were made
    if (jsonEncode(zefcontroller.document.toJson()) != initialNoteValue ||
        noteModel.title != bindedTitle) {
      // show confirmation banner
      showConfirmation = true;
    } else {
      // no changes made, go back.
      Get.back();
    }
  }

  void deleteNote() async {
    int id = await appController.dbProvider.deleteNote(noteModel.id);
    homeController.loadNotes();
    Get.back();
    Get.snackbar('Delete', 'Note at id:$id sucesfully deleted');
  }
}

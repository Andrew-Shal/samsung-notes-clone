import 'package:get/get.dart';
import 'package:notes_app/src/controller.dart';
import '../../models/note_model.dart';

class HomeController extends GetxController {
  AppController appController = Get.find();
  int notesCount = 0;
  List<NoteModel> notes = List<NoteModel>();

  HomeController() {
    // update page title
    appController.setAppBarTitle("All notes");

    print("home controller: $notesCount");

    loadNotesCount();
    loadNotes();
  }

  loadNotes() async {
    // load notes
    notes = await appController.dbProvider.fetchNotes();
    update();
  }

  // set state methods
  loadNotesCount() async {
    notesCount = await appController.dbProvider.fetchNotesCount();
    update();
  }
}

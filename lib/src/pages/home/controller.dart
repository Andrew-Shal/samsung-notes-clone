import 'package:get/get.dart';
import 'package:notes_app/src/controller.dart';
import '../../models/note_model.dart';

class HomeController extends GetxController {
  AppController appController = Get.find();

  RxList<NoteModel> _notes = RxList<NoteModel>(List<NoteModel>());
  set notes(List<NoteModel> val) => _notes.value = val;
  List<NoteModel> get notes => _notes.value;

  HomeController() {
    // update page title
    appController.setAppBarTitle("All notes");

    // get notes from db
    loadNotes();
  }

  loadNotes() async {
    // load notes
    notes = await appController.dbProvider.fetchNotes();
  }
}

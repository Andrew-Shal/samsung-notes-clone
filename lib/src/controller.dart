import 'package:get/get.dart';
import './resources/notes_db_provider.dart';

class AppController extends GetxController {
  // accesible states
  String appBarTitle = "Notes Application";
  NotesDbProvider dbProvider; // shared database instance

  AppController() {
    // create instance
    dbProvider = NotesDbProvider();
  }

  // state update methods
  setAppBarTitle(String newTitle) {
    appBarTitle = newTitle;
  }
}

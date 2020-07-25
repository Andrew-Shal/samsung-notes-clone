import 'package:get/route_manager.dart';
import './pages/home/index.dart';
import './pages/note_editor/new_note/index.dart';

routes() => [
      GetPage(name: "/", page: () => Home()),
      GetPage(name: "/note/add", page: () => NewNote()),
    ];

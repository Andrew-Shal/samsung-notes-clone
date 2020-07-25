import 'package:notes_app/src/models/note_model.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/notes_db_provider.dart';

class NotesBloc {
  final _dao = notesDbProvider;
  final _notes = PublishSubject<List<NoteModel>>();
  final _notesCount = BehaviorSubject<int>();

  Stream<List<NoteModel>> get notes => _notes.stream;
  Stream<int> get notesCount => _notesCount.stream;

  fetchNotes() async {
    final notes = await _dao.fetchNotes();
    _notes.sink.add(notes);
  }

  fetchNotesCount() async {
    final count = await _dao.fetchNotesCount();
    _notesCount.sink.add(count);
  }

  dispose() {
    _notes.close();
    _notesCount.close();
  }
}

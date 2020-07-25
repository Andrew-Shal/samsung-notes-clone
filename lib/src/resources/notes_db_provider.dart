import 'dart:io';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../models/note_model.dart';

class NotesDbProvider {
  Database db;
  static const String dbName = "notes18.db";

  Future _open({name = dbName}) async {
    if (db == null || db.isOpen) {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, dbName);

      db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database newDb, int version) async {
          await newDb.execute("""
        CREATE TABLE categories(
          id                INTEGER PRIMARY KEY NOT NULL,
          name              TEXT NOT NULL,
          color_identifier  TEXT NOT NULL,
          is_removed        INTEGER DEFAULT 0
        )""");
          await newDb.execute("""
        CREATE TABLE notes(
          id            INTEGER PRIMARY KEY NOT NULL,
          title         TEXT NULL,
          note          BLOB NULL,
          category_fk   INTEGER NOT NULL,
          is_favorite   INTEGER DEFAULT 0,
          is_removed    INTEGER DEFAULT 0,
          date_created  TEXT,
          FOREIGN KEY (category_fk) REFERENCES categories(id) 
        )""");
          await newDb.execute("""
        CREATE TABLE note_in_category(
          id   INTEGER PRIMARY KEY NOT NULL,
          note_id  INTEGER NOT NULL,
          category_id INTEGER NOT NULL,
          FOREIGN KEY (note_id) REFERENCES notes(id),
          FOREIGN KEY (category_id) REFERENCES categories(id)
        )""");
          /*await newDb.execute("DELETE FROM note_in_category");
          await newDb.execute("DELETE FROM notes");
          await newDb.execute("DELETE FROM categories");*/

          await newDb.execute(
              "INSERT INTO categories(name,color_identifier)VALUES('uncategorized','#DCDCDC')");
          await newDb.execute(
              "INSERT INTO notes(title,note,category_fk,date_created)VALUES('test','{\"0\":\"firstitem\",\"1\":\"secondItem\"}',1,datetime('now'))");
          await newDb.execute(
              "INSERT INTO notes(title,note,category_fk,is_favorite,date_created)VALUES('test 2','{\"0\":\"thirdItem\",\"1\":\"fourthItem\"}',1,1,datetime('now'))");

          await newDb.execute(
              "INSERT INTO notes(title,note,category_fk,date_created)VALUES('test 3','{\"0\":\"firstitem\",\"1\":\"secondItem\"}',1,datetime('now'))");
          await newDb.execute(
              "INSERT INTO notes(title,note,category_fk,is_favorite,date_created)VALUES('test 4','{\"0\":\"thirdItem\",\"1\":\"fourthItem\"}',1,0,datetime('now'))");
          await newDb.execute(
              "INSERT INTO notes(title,note,category_fk,date_created)VALUES('test 5','{\"0\":\"firstitem\",\"1\":\"secondItem\"}',1,datetime('now'))");
          await newDb.execute(
              "INSERT INTO notes(title,note,category_fk,is_favorite,date_created)VALUES('test 6','{\"0\":\"thirdItem\",\"1\":\"fourthItem\"}',1,1,datetime('now'))");
          await newDb.execute(
              "INSERT INTO notes(title,note,category_fk,date_created)VALUES('test 7','{\"0\":\"firstitem\",\"1\":\"secondItem\"}',1,datetime('now'))");
          await newDb.execute(
              "INSERT INTO notes(title,note,category_fk,is_favorite,date_created)VALUES('test 8','{\"0\":\"thirdItem\",\"1\":\"fourthItem\"}',1,0,datetime('now'))");
          await newDb.execute(
              "INSERT INTO notes(title,note,category_fk,date_created)VALUES('test 9','{\"0\":\"firstitem\",\"1\":\"secondItem\"}',1,datetime('now'))");
          await newDb.execute(
              "INSERT INTO notes(title,note,category_fk,is_favorite,date_created)VALUES('test 10','{\"0\":\"thirdItem\",\"1\":\"fourthItem\"}',1,1,datetime('now'))");

          await newDb.execute(
              "INSERT INTO note_in_category(note_id,category_id)VALUES(1,1)");
          await newDb.execute(
              "INSERT INTO note_in_category(note_id,category_id)VALUES(2,1)");
          await newDb.execute(
              "INSERT INTO note_in_category(note_id,category_id)VALUES(3,1)");
          await newDb.execute(
              "INSERT INTO note_in_category(note_id,category_id)VALUES(4,1)");
          await newDb.execute(
              "INSERT INTO note_in_category(note_id,category_id)VALUES(5,1)");
          await newDb.execute(
              "INSERT INTO note_in_category(note_id,category_id)VALUES(6,1)");

          await newDb.execute(
              "INSERT INTO note_in_category(note_id,category_id)VALUES(7,1)");
          await newDb.execute(
              "INSERT INTO note_in_category(note_id,category_id)VALUES(8,1)");
          await newDb.execute(
              "INSERT INTO note_in_category(note_id,category_id)VALUES(9,1)");
          await newDb.execute(
              "INSERT INTO note_in_category(note_id,category_id)VALUES(10,1)");
        },
        onOpen: (db) {
          print('db opened!');
        },
      );
    }
  }

  Future<List<NoteModel>> fetchNotes() async {
    await _open();
    List<NoteModel> notesList = [];

    final maps = await db.rawQuery("""
        SELECT n.id AS note_id, n.title, n.note, n.is_removed AS note_removed, n.is_favorite, n.date_created,c.id AS category_id, c.name,c.color_identifier,c.is_removed AS category_removed
          FROM notes n 
          JOIN note_in_category nic ON nic.note_id = n.id
          JOIN categories c ON c.id = nic.category_id
          WHERE note_removed=0
   """);
    maps.forEach((item) {
      notesList.add(NoteModel.fromDb(item));
    });

    return notesList;
  }

  Future<int> fetchNotesCount() async {
    await _open();

    final count = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM notes WHERE is_removed = 0"));
    return count;
  }

  void insertNote(NoteModel newNote) async {
    await _open();

    int noteId = await db.insert("notes", {
      "title": newNote.title,
      "note": newNote.note,
      "category_fk": 1,
      "date_created": DateTime.now().toString(),
    }).whenComplete(() {
      print('Sucessfully saved');
    }).catchError((err) => print('err saving $err'));

    db.insert("note_in_category", {
      "note_id": noteId,
      "category_id": 1
    }).catchError((err) => print('err saving $err'));
  }
}

final NotesDbProvider notesDbProvider = NotesDbProvider();

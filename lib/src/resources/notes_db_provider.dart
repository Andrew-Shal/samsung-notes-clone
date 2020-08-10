import 'dart:io';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../models/note_model.dart';

class NotesDbProvider {
  Database db;
  static const String dbName = "notes32.db";

  Future _open({name = dbName}) async {
    if (db == null || db.isOpen) {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, dbName);

      db = await openDatabase(path, version: 1,
          onCreate: (Database newDb, int version) async {
        await newDb.execute("""
        CREATE TABLE categories(
          id                      INTEGER PRIMARY KEY NOT NULL,
          name                    TEXT NOT NULL,
          color_identifier        TEXT NOT NULL,
          is_removed              INTEGER DEFAULT 0,
          category_date_created       TEXT DEFAULT CURRENT_TIMESTAMP
        )""");
        await newDb.execute("""
        CREATE TABLE notes(
          id                      INTEGER PRIMARY KEY NOT NULL,
          title                   TEXT NULL,
          note                    BLOB NULL,
          category_fk             INTEGER NOT NULL DEFAULT 1,
          is_favorite             INTEGER DEFAULT 0,
          is_removed              INTEGER DEFAULT 0,
          note_date_created   TEXT DEFAULT CURRENT_TIMESTAMP,
          note_date_updated   TEXT NOT NULL,
          FOREIGN KEY (category_fk) REFERENCES categories(id) 
        )""");

        await newDb.execute(
            "INSERT INTO categories(name,color_identifier)VALUES('uncategorized','#DCDCDC')");
      });
    }
  }

  Future<List<NoteModel>> fetchNotes() async {
    await _open();
    List<NoteModel> notesList = [];

    final maps = await db.rawQuery("""
      SELECT n.id AS note_id, n.title, n.note, n.is_removed AS note_removed, n.is_favorite, n.note_date_created,n.note_date_updated,c.id AS category_id, c.name,c.color_identifier,c.is_removed AS category_removed,c.category_date_created
      FROM notes n
      LEFT JOIN categories c
      ON n.category_fk = c.id
      WHERE n.is_removed = 0;
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

  Future<int> insertNote(NoteModel newNote) async {
    await _open();

    // insert note, category defaults to 1(uncategorized)
    final int id = await db.rawInsert("""
      INSERT INTO notes
      (title,note,note_date_updated) 
      VALUES
      ('${newNote.title}','${newNote.note}',datetime('now'));
      """);

    return id;
  }

  Future<NoteModel> fetchNote(int id) async {
    await _open();

    // get note where id is found and note is removed is not 0
    final res = await db.rawQuery("""
      SELECT n.id AS note_id, n.title, n.note, n.is_removed AS note_removed, n.is_favorite, n.note_date_created, n.note_date_updated,c.id AS category_id, c.name,c.color_identifier,c.is_removed AS category_removed, c.category_date_created
      FROM notes n
      LEFT JOIN categories c
      ON n.category_fk = c.id
      WHERE n.is_removed = 0
      AND n.id = $id;
    """);

    return NoteModel.fromDb(res.first);
  }
}

import 'dart:convert';
import './category_model.dart';

class NoteModel {
  int id;
  String title;
  var note;
  bool isRemoved;
  bool isFavorite;
  CategoryModel category;
  DateTime dateCreated;

  NoteModel() {}

  NoteModel.fromDb(Map<String, dynamic> parsedJSON) {
    this.id = parsedJSON['note_id'];
    this.title = parsedJSON['title'];
    this.note = jsonDecode(parsedJSON['note']) ?? {};
    this.isRemoved = parsedJSON['note_removed'] == 1 ? true : false;
    this.isFavorite = parsedJSON['is_favorite'] == 1 ? true : false;
    this.category = CategoryModel.fromDb(parsedJSON);
    this.dateCreated = DateTime.parse(parsedJSON['date_created']);
  }
}

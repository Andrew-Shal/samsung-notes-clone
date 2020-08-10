import 'dart:convert';
import './category_model.dart';
import 'package:get/get.dart';

class NoteModel {
  RxInt _id = RxInt();
  set id(int val) => _id.value = val;
  int get id => _id.value;

  RxString _title = RxString();
  set title(String val) => _title.value = val;
  String get title => _title.value;

  RxString _note = RxString();
  set note(String val) => _note.value = val;
  String get note => _note.value;

  RxBool _isRemoved = RxBool();
  set isRemoved(bool val) => _isRemoved.value = val;
  bool get isRemoved => _isRemoved.value;

  RxBool _isFavorite = RxBool();
  set isFavorite(bool val) => _isFavorite.value = val;
  bool get isFavorite => _isFavorite.value;

  Rx<CategoryModel> _category = Rx<CategoryModel>();
  set category(CategoryModel val) => _category.value = val;
  CategoryModel get category => _category.value;

  Rx<DateTime> _dateCreated = Rx<DateTime>();
  set dateCreated(DateTime val) => _dateCreated.value = val;
  DateTime get dateCreated => _dateCreated.value;

  Rx<DateTime> _dateUpdated = Rx<DateTime>();
  set dateUpdated(DateTime val) => _dateUpdated.value = val;
  DateTime get dateUpdated => _dateUpdated.value;

  NoteModel();

  NoteModel.fromDb(Map<String, dynamic> parsedJSON) {
    this.id = parsedJSON['note_id'];
    this.title = parsedJSON['title'];
    this.note = jsonDecode(parsedJSON['note']) ?? {};
    this.isRemoved = parsedJSON['note_removed'] == 1 ? true : false;
    this.isFavorite = parsedJSON['is_favorite'] == 1 ? true : false;
    this.category = CategoryModel.fromDb(parsedJSON);
    this.dateCreated = DateTime.parse(parsedJSON['note_date_created']);
    this.dateUpdated = DateTime.parse(parsedJSON['note_date_updated']);
  }
  toString() {
    return '$id, $title, $note, $isRemoved, $isFavorite, {$category}, $dateCreated, $dateUpdated';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "title": title,
      "note": note,
      "isRemoved": isRemoved,
      "isFavorite": isFavorite,
      "category": category.toMap(),
      "dateCreated": dateCreated,
      "dateUpdated": dateUpdated,
    };
  }
}

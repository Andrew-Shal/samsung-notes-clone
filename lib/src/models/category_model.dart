import 'package:get/get.dart';

class CategoryModel {
  RxInt _id = RxInt();
  set id(int val) => _id.value = val;
  int get id => _id.value;

  RxString _name = RxString();
  set name(String val) => _name.value = val;
  String get name => _name.value;

  RxString _colorIdentifier = RxString();
  set colorIdentifier(String val) => _colorIdentifier.value = val;
  String get colorIdentifier => _colorIdentifier.value;

  RxBool _isRemoved = RxBool();
  set isRemoved(bool val) => _isRemoved.value = val;
  bool get isRemoved => _isRemoved.value;

  // ignore: todo
  // TODO : convet type to datetime
  Rx<DateTime> _dateCreated = Rx<DateTime>();
  set dateCreated(DateTime val) => _dateCreated.value = val;
  DateTime get dateCreated => _dateCreated.value;

  CategoryModel.fromDb(Map<String, dynamic> parsedJSON) {
    this.id = parsedJSON['category_id'];
    this.name = parsedJSON['name'];
    this.colorIdentifier = parsedJSON['color_identifier'];
    this.isRemoved = parsedJSON['category_removed'] == 1 ? true : false;
    this.dateCreated = DateTime.parse(parsedJSON['category_date_created']);
  }
  toString() {
    return '$id, $name, $colorIdentifier, $isRemoved, $dateCreated';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "colorIdentifier": colorIdentifier,
      "isRemoved": isRemoved,
      "dateCreated": dateCreated,
    };
  }
}

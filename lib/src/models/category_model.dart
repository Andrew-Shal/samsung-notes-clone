class CategoryModel {
  int id;
  String name;
  String colorIdentifier;
  bool isRemoved;

  CategoryModel.fromDb(Map<String, dynamic> parsedJSON) {
    this.id = parsedJSON['category_id'];
    this.name = parsedJSON['name'];
    this.colorIdentifier = parsedJSON['color_identifier'];
    this.isRemoved = parsedJSON['category_removed'] == 1 ? true : false;
  }
}
class CategoryModel {
  String? name;
  String? image;

  CategoryModel({this.name, this.image});

  CategoryModel.fromJson(dynamic data) {
    if (data == null) return;

    name = data['name'];
    image = data['image'];
  }

  toJson() {
    return {'name': name, 'image': image};
  }
}

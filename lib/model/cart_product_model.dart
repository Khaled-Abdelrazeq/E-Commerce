class CartProductModel {
  String? name;
  String? image;
  double? price;
  int? quantity;
  int? size;
  String? color;

  CartProductModel(
      {this.name,
      this.image,
      this.price,
      this.quantity,
      this.size,
      this.color});

  CartProductModel.fromJson(dynamic data) {
    if (data == null) return;

    name = data['name'];
    image = data['image'];
    price = data['price'];
    quantity = data['quantity'];
    size = data['size'];
    color = data['color'];
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
      'size': size,
      'color': color
    };
  }
}

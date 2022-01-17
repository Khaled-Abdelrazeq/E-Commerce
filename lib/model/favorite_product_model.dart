class FavoriteProductModel {
  String? name;
  String? image;
  String? price;
  String? priceAfterDiscount;
  String? rate;
  String? discount;

  FavoriteProductModel(
      {this.name,
      this.image,
      this.price,
      this.priceAfterDiscount,
      this.rate,
      this.discount});

  FavoriteProductModel.fromJson(dynamic data) {
    if (data == null) return;

    name = data['name'];
    image = data['image'];
    price = data['price'];
    priceAfterDiscount = data['priceAfterDiscount'];
    rate = data['rate'];
    discount = data['discount'];
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'priceAfterDiscount': priceAfterDiscount,
      'rate': rate,
      'discount': discount
    };
  }
}

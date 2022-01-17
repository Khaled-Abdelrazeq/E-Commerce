import 'package:e_commerce/model/cart_product_model.dart';
import 'package:e_commerce/model/product_model.dart';

class UserModel {
  String? userId;
  String? email;
  String? name;
  String? pic;
  List<ProductModel>? favourites = [];
  List<CartProductModel>? cart = [];

  UserModel(
      {this.userId,
      this.email,
      this.name,
      this.pic,
      this.cart,
      this.favourites});

  UserModel.fromJson(dynamic data) {
    if (data == null) return;

    userId = data['userId'];
    email = data['email'];
    name = data['name'];
    pic = data['pic'];

    if (data['favourites'] != null) {
      data['favourites'].forEach((element) {
        favourites?.add(ProductModel.fromJson(element));
      });
    }
    if (data['cart'] != null) {
      data['cart'].forEach((element) {
        cart?.add(CartProductModel.fromJson(element));
      });
    }
  }

  toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'pic': pic,
      'favourites': favourites,
      'cart': cart
    };
  }
}

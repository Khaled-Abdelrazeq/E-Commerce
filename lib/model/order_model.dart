import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/model/user_model.dart';
import 'cart_product_model.dart';

class OrderModel {
  UserModel? userModel;
  List<CartProductModel>? productModel = [];
  double? shipping;
  double? importCharges;
  double? couponDiscountPrice;
  double? totalPrice;

  OrderModel(
      {this.userModel,
      this.productModel,
      this.couponDiscountPrice,
      this.importCharges,
      this.shipping,
      this.totalPrice});

  OrderModel.fromJson(dynamic data) {
    if (data == null) return;

    shipping = data['shipping'];
    couponDiscountPrice = data['couponDiscount'];
    importCharges = data['importCharges'];
    totalPrice = data['totalPrice'];

    if (data['userModel'] != null) {
      userModel = UserModel.fromJson(data['userModel']);
    }

    if (data['productModel'] != null) {
      data['productModel'].forEach((element) {
        productModel?.add(CartProductModel.fromJson(element));
      });
    }
  }

  toJson() {
    int max = productModel!.length - 1;
    List<Map> data =
        List.generate(max + 1, (index) => productModel![index].toJson());

    return {
      'productModel': data,
      'userModel': userModel?.toJson(),
      'totalPrice': totalPrice,
      'shipping': shipping,
      'importCharges': importCharges,
      'couponDiscount': couponDiscountPrice
    };
  }
}

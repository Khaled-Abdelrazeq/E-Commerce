import 'package:e_commerce/model/cart_product_model.dart';
import 'package:e_commerce/model/order_model.dart';
import 'package:e_commerce/model/user_model.dart';
import 'package:e_commerce/services/firestore_user.dart';
import 'package:e_commerce/services/orders_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CartViewModel extends GetxController {
  List<CartProductModel> cartProducts = [];
  UserModel? userModel;

  final ValueNotifier<bool> _loadingCategory = ValueNotifier(false);
  ValueNotifier<bool> get loadingCategory => _loadingCategory;

  String couponCode = '';
  double importCharges = 0;
  double shipping = 0;
  double totalPrice = 0;
  double itemsPrice = 0;
  double couponDiscountPrice = 0;
  int itemCount = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCartElements();
  }

  void getCartElements() async {
    cartProducts = [];
    itemsPrice = 0.0;
    importCharges = 0.0;
    _loadingCategory.value = true;
    await FirestoreUser().getProducts().then((value) {
      userModel = UserModel.fromJson(value);
    });

    int length = userModel?.cart?.length ?? 0;
    for (int i = 0; i < length; i++) {
      cartProducts.add(userModel!.cart![i]);
      int quantity = cartProducts[i].quantity!;
      double price = cartProducts[i].price!;
      itemsPrice += (quantity * price);
      importCharges += (itemsPrice * 0.1);
    }
    shipping = 10;
    itemCount = length;
    totalPrice = itemsPrice + shipping + importCharges - couponDiscountPrice;
    loadingCategory.value = false;
    update();
  }

  void addCartProduct(CartProductModel model) async {
    bool isFound = false;
    for (int i = 0; i < cartProducts.length; i++) {
      if (cartProducts[i].name == model.name) {
        isFound = true;
        break;
      } else {
        isFound = false;
      }
    }

    if (!isFound) {
      cartProducts.add(model);
      int max = cartProducts.length - 1;
      List<Map> data =
          List.generate(max + 1, (index) => cartProducts[index].toJson());
      data[max] = model.toJson();
      await FirestoreUser().addCartOrFavoriteProduct({'cart': data});
      Get.snackbar('Notification', 'Product Added To Cart!');
    } else {
      Get.snackbar('Notification', 'Product Already Added!');
    }
    update();
  }

  void deleteElementFromCart(CartProductModel model, int index) async {
    cartProducts.removeAt(index);
    int max = cartProducts.length - 1;
    List<Map> data =
        List.generate(max + 1, (index) => cartProducts[index].toJson());

    await FirestoreUser()
        .addCartOrFavoriteProduct({'cart': data})
        .then((value) => print('Deleted Successfully!'))
        .catchError((e) => print('error in deleting ${e.toString()}'));
    update();
  }

  void addProductQuantity(int number, CartProductModel model, int index) async {
    int max = cartProducts.length - 1;
    List<Map> data =
        List.generate(max + 1, (index) => cartProducts[index].toJson());

    data[index]['quantity'] += number;

    await FirestoreUser()
        .addCartOrFavoriteProduct({'cart': data})
        .then((value) => debugPrint('Quantity Updated Successfully!'))
        .catchError(
            (e) => debugPrint('error in Updating Quantity ${e.toString()}'));
    update();

    if (data[index]['quantity'] <= 0) {
      deleteElementFromCart(model, index);
    }
    getCartElements();
    update();
  }

  void checkOut() async {
    //TODO Add User Location

    if (cartProducts.isNotEmpty) {
      await OrdersServices()
          .addNewOrder(OrderModel(
            couponDiscountPrice: couponDiscountPrice,
            importCharges: importCharges,
            shipping: shipping,
            userModel: UserModel(
                name: userModel?.name,
                email: userModel?.email,
                pic: userModel?.pic,
                userId: userModel?.userId),
            productModel: cartProducts,
            totalPrice: totalPrice,
          ))
          .catchError((e) => print('Error Check Out ${e.toString()}'));

      ///Delete all cart elements
      await FirestoreUser().addCartOrFavoriteProduct({'cart': []});
      update();
      getCartElements();
    } else {
      Get.snackbar('Notification', 'Please add items first');
    }
  }
}

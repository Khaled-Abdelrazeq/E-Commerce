import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/model/order_model.dart';
import 'package:intl/intl.dart';

class OrdersServices {
  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('Orders');

  Future<void> addNewOrder(OrderModel model) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);

    return await orderCollection.doc(formattedDate).set(model.toJson());
  }
}

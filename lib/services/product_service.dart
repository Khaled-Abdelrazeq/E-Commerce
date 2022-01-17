import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('Products');

  Future<List<QueryDocumentSnapshot>> getProducts() async {
    var data = await _productsCollection.get();

    return data.docs;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesService {
  final CollectionReference _manCollection = FirebaseFirestore.instance
      .collection('categories')
      .doc('rgxatQ6h1c7XNTVdWBFv')
      .collection('Man');

  final CollectionReference _womanCollection = FirebaseFirestore.instance
      .collection('categories')
      .doc('rgxatQ6h1c7XNTVdWBFv')
      .collection('Woman');

  Future<List<QueryDocumentSnapshot>> getManCategory() async {
    var value = await _manCollection.get();

    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getWomanCategory() async {
    var value = await _womanCollection.get();

    return value.docs;
  }
}

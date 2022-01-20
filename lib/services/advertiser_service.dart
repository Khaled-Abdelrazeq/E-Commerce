import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/model/advertiser_model.dart';

class AdvertiserService {
  final CollectionReference _advertiserCollection =
      FirebaseFirestore.instance.collection('Advertiser');

  Future<void> addNewCarousel(AdvertiserModel model) async {
    // return await userCollection.doc(userModel.userId).set(userModel.toJson());
  }

  Future<List<QueryDocumentSnapshot>> getAdvertiser() async {
    var data = await _advertiserCollection.get();

    return data.docs;
  }
}

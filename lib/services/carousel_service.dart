import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/model/carousel_model.dart';

class CarouselService {
  final CollectionReference _carouselCollection =
      FirebaseFirestore.instance.collection('Carousel');

  Future<void> addNewCarousel(CarouselModel model) async {
    // return await userCollection.doc(userModel.userId).set(userModel.toJson());
  }

  Future<List<QueryDocumentSnapshot>> getCarousels() async {
    var data = await _carouselCollection.get();

    return data.docs;
  }
}

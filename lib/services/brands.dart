import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bricko_web/helpers/constants.dart';
import 'package:bricko_web/models/brands.dart';

class BrandsServices {
  String collection = "sets";

  Future<List<BrandModel>> getAll() async =>
      firebaseFiretore.collection(collection).get().then((result) {
        List<BrandModel> brands = [];
        for (DocumentSnapshot brand in result.docs) {
          brands.add(BrandModel.fromSnapshot(brand));
        }
        return brands;
      });
}

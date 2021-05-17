import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  // static const BRAND = "brand";
  static const TITLE_EN = "title_en";
  static const TITLE_RU = "title_ru";

  String _titleEn;
  String _titleRu;
  // String _brand;

//  getters
  // String get brand => _brand;
  String get titleEn => _titleEn;
  String get titleRu => _titleRu;

  BrandModel.fromSnapshot(DocumentSnapshot snapshot) {
    // _brand = snapshot.data()[BRAND];
    _titleEn = snapshot.data()[TITLE_EN];
    _titleRu = snapshot.data()[TITLE_RU];
  }
}

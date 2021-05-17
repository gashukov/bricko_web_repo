import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesModel {
  
    static const TITLE_EN = "title_en";
  static const TITLE_RU = "title_ru";

  
  String _titleEn;
  String _titleRu;

//  getters
  String get titleEn => _titleEn;
  String get titleRu => _titleRu;
  

  CategoriesModel.fromSnapshot(DocumentSnapshot snapshot) {
    _titleEn = snapshot.data()[TITLE_EN];
    _titleRu = snapshot.data()[TITLE_RU];
  
  }
}

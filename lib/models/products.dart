import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ACTIVE = "productActive";
  static const SET = "productSet";
  static const TITLE_EN = "productTitle_en";
  static const TITLE_RU = "productTitle_ru";
  static const DESCRIPTION_EN = "productDescription_en";
  static const DESCRIPTION_RU = "productDescription_ru";
  static const PRICE_TYPE = "productPriceType";
  static const IAPID = "iapID";
  static const ADS_PRICE = "productAdsPrice";
  static const CATEGORIES = "categories";
  static const SCREENS_COUNT = "productScreensCount";

  bool _active;
  String _pSet;
  String _titleEn;
  String _titleRu;
  String _descriptionEn;
  String _descriptionRu;
  String _priceType;
  String _iapID;
  int _adsPrice;
  List<dynamic> _categories;
  int _screensCount;

  get active => this._active;
  get pSet => this._pSet;
  get titleEn => this._titleEn;
  get titleRu => this._titleRu;
  get descriptionEn => this._descriptionEn;
  get descriptionRu => this._descriptionRu;
  get priceType => this._priceType;
  get iapID => this._iapID;
  get adsPrice => this._adsPrice;
  get categories => this._categories;
  get screensCount => this._screensCount;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _active = snapshot.data()[ACTIVE];
    _pSet = snapshot.data()[SET];
    _titleEn = snapshot.data()[TITLE_EN];
    _titleRu = snapshot.data()[TITLE_RU];
    _descriptionEn = snapshot.data()[DESCRIPTION_EN];
    _descriptionRu = snapshot.data()[DESCRIPTION_RU];
    _priceType = snapshot.data()[PRICE_TYPE];
    _iapID = snapshot.data()[IAPID];
    _adsPrice = snapshot.data()[ADS_PRICE];
    _categories = snapshot.data()[CATEGORIES];
    _screensCount = snapshot.data()[SCREENS_COUNT];
  }
}

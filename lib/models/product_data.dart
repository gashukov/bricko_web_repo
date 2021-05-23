import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:bricko_web/utils/app_data.dart';
import 'package:bricko_web/main.dart';
import 'package:bricko_web/componets/instructions_viewer.dart';
import 'package:bricko_web/componets/buy_button.dart';
import 'package:bricko_web/pages/product_details.dart';
import 'dart:async';

class ProductData {
  String pID;
  String pPriceType;
  int pAdsPrice;
  String pTitleEN;
  String pTitleRU;
  String pDescriptionEN;
  String pDescriptionRU;
//  bool pDownloaded = false;
  bool pUnlocked = false;
  bool pPurchased = false;
  int pScreensCount;
  List<dynamic> pCategories;
  String pSet;
  String pIapID;


  ProductData(String pID, String pPriceType, int pAdsPrice, String pTitleEN, String pTitleRU, String pDescriptionEN, String pDescriptionRU, int productScreensCount, List<dynamic> pCategories, String pSet, String pIapID) {
    this.pID = pID;
    this.pPriceType = pPriceType;
    this.pAdsPrice = pAdsPrice;
    this.pTitleEN = pTitleEN;
    this.pTitleRU = pTitleRU;
    this.pDescriptionEN = pDescriptionEN;
    this.pDescriptionRU = pDescriptionRU;
    this.pScreensCount = productScreensCount;
    this.pCategories = pCategories;
    this.pSet = pSet;
    this.pIapID = pIapID;
  }

  String getActualTitle(BuildContext context) {
    switch(FlutterI18n.currentLocale(context).languageCode) {
      case "ru":
        return pTitleRU;
        break;
      default:
        return pTitleEN;
        break;
    }
  }

  String getActualDescription(BuildContext context) {
    switch(FlutterI18n.currentLocale(context).languageCode) {
      case "ru":
        return pDescriptionRU;
        break;
      default:
        return pDescriptionEN;
        break;
    }
  }

  String getActualSet(BuildContext context) {
    switch(FlutterI18n.currentLocale(context).languageCode) {
      case "ru":
        return pDescriptionRU;
        break;
      default:
        return pDescriptionEN;
        break;
    }
  }

  ButtonBuyState getActualButtonState() {
    switch (pPriceType) {
      case priceTypeFree:
        if(!fileStorage.isArchiveExists(pID)) {
          return ButtonBuyState.DOWNLOAD;
        } else {
          return ButtonBuyState.OPEN;
        }
        break;
      case priceTypePaid:
        if(!owned.contains(pID) && !downloadedOnce.contains(pID)) {
          return ButtonBuyState.BUY;
        } else if(!fileStorage.isArchiveExists(pID)) {
          return ButtonBuyState.DOWNLOAD;
        } else {
          return ButtonBuyState.OPEN;
        }
        break;
      case priceTypeAds:
        if((!viewsRemains.containsKey(pID) || viewsRemains[pID] != 0) && !downloadedOnce.contains(pID)) {
          return ButtonBuyState.UNLOCK;
        } else {
          if(!fileStorage.isArchiveExists(pID)) {
            return ButtonBuyState.DOWNLOAD;
          } else {
            return ButtonBuyState.OPEN;
          }
        }
        break;
    }
  }

  IconData getBuyIcon() {

    switch(getActualButtonState()) {

      case ButtonBuyState.OPEN:
        return Icons.remove_red_eye;
        break;
      case ButtonBuyState.DOWNLOAD:
        return Icons.file_download;
        break;
      case ButtonBuyState.UNLOCK:
        return Icons.slideshow;
        break;
      case ButtonBuyState.BUY:
        return Icons.shop;
        break;
    }
  }

  String getBuyText() {

    switch(getActualButtonState()) {

      case ButtonBuyState.OPEN:
        return "open";
        break;
      case ButtonBuyState.DOWNLOAD:
        return "download";
        break;
      case ButtonBuyState.UNLOCK:
        return "unlock";
        break;
      case ButtonBuyState.BUY:
        return "buy";
        break;
    }

  }

  Color getBuyColor() {

    switch(getActualButtonState()) {

      case ButtonBuyState.OPEN:
        return Colors.green.shade900;
        break;
      case ButtonBuyState.DOWNLOAD:
        return Colors.orange.shade900;
        break;
      case ButtonBuyState.UNLOCK:
        return Colors.blue.shade900;
        break;
      case ButtonBuyState.BUY:
        return Colors.red.shade900;
        break;
    }
  }



}
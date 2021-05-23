import 'package:flutter_translate/flutter_translate.dart';

import 'app_data.dart';
import 'package:flutter/material.dart';
import 'package:bricko_web/models/product_data.dart';
import 'package:bricko_web/main.dart';
import 'package:connectivity/connectivity.dart';

String getPriceByPriceType(BuildContext context, ProductData productData) {
  switch (productData.pPriceType) {
    case priceTypeFree:
      return translate("free");
      break;
    case priceTypeAds:
      if (viewsRemains == null) return null;

      if (!viewsRemains.containsKey(productData.pID)) {
        return "${productData.pAdsPrice} ${translate("video_ads")}";
      } else {
        if (viewsRemains[productData.pID] == 0) {
          return translate("instruction_unlocked");
        } else {
          return "${viewsRemains[productData.pID]} ${translate("video_ads")}";
        }
      }

      break;
    case priceTypePaid:
      return "1";
      // if(owned.contains(productData.pID)) {
      //   return translate("product_owned");
      // } else if (iapProducts == null || iapProducts.isEmpty) {
      //   return null;
      // } else {
      //   return iapProducts.firstWhere((e) => e.id == productData.pIapID).price;
      // }

      break;
  }
  return null;
}

String getIconPathByPID(String pID) {
  return "/products/${pID.toLowerCase()}/icon.png";
}

String getScreensPathByPID(String pID) {
  return "/products/${pID.toLowerCase()}/screens/";
}

Future<bool> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

// import 'dart:async';
// import 'dart:io';
// import 'package:bricks_build_instructions/main.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
// import 'package:bricks_build_instructions/state_widget.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'help_functions.dart';

// class PurchaseManager {

//   bool _iapIsAvailable;
//   StreamSubscription _subscription;
//   List<PurchaseDetails> purchases;
//   String _currentProductID;
//   String _currentIapID;
//   String _currentUserId;

//   Future init(String userID) async {
//     _currentUserId = userID;
//     return _initializeIap();
//   }


//   Future _initializeIap() async {
//     _iapIsAvailable = await InAppPurchaseConnection.instance.isAvailable();
//     await _getPastPurchases();
//     _subscription = InAppPurchaseConnection.instance.purchaseUpdatedStream.listen((data) {
//       print("PURCHASE UPDATE");
//       purchases.addAll(data);
//       _verifyPurchases(data);
// //      changeButtonState();

//     });
//   }

//   Future buyInstruction(String pIapID, String productID) async {
//     print("TESTPURCH: buy press");
//     _currentProductID = productID;
//     _currentIapID = pIapID;
//     return checkInternet().then((intenet) {
//       if (intenet != null && intenet) {
//         dataStorage.startBuyProduct(_currentUserId, pIapID);
//         PurchaseParam purchaseParam = PurchaseParam(productDetails: iapProducts.firstWhere((e) => e.id == pIapID));
//         return InAppPurchaseConnection.instance.buyConsumable(purchaseParam: purchaseParam);
//       }
//       return false;
//     });
//   }




//   Future<void> _getPastPurchases() async{
//     QueryPurchaseDetailsResponse response = await InAppPurchaseConnection.instance.queryPastPurchases();
//     for(PurchaseDetails pur in response.pastPurchases) {



//       if(Platform.isIOS) {
//         InAppPurchaseConnection.instance.completePurchase(pur);
//       }
//     }
// //
// //    for(PurchaseDetails pur in response.pastPurchases) {
// //      print("consume past purchases: ${pur.productID}");
// //      await InAppPurchaseConnection.instance.consumePurchase(pur);
// //
// //    }
// //
// //    response = await InAppPurchaseConnection.instance.queryPastPurchases();
// //
// //    for(PurchaseDetails pur in response.pastPurchases) {
// //      print("left past purchases: ${pur.productID}");
// //
// //    }


//     purchases = response.pastPurchases;

//   }

//   void _verifyPurchases(List<PurchaseDetails> newPurchases) {
//     print("TESTPURCH: verify");
//     if (newPurchases != null && newPurchases.isNotEmpty && newPurchases[0].productID == _currentIapID && newPurchases[0].status == PurchaseStatus.purchased) {
//       print("TESTPURCH: verify inside");
//       if(!owned.contains(_currentProductID)) {
//         print("VERIFY");
//         DocumentReference ref = firestore.collection('users').document(_currentUserId);
//         owned.add(_currentProductID);
// //        dataStorage.addInstructionBuy(_currentUserId, _currentProductID);
//         ref.setData({
//           'owned': owned,
//         }, merge: true);
//         StateWidget.priceController.sink.add("update");
//         StateWidget.buyButtonController.sink.add("update");
//       }
//     }
//   }

// }
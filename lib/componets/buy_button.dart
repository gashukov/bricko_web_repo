import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:bricko_web/models/product_data.dart';
import 'package:bricko_web/utils/app_data.dart';
import 'dart:async';
import 'package:bricko_web/main.dart';
import 'instructions_viewer.dart';
import 'package:bricko_web/state_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuyButtonBar extends StatefulWidget {
  ProductData productData;

  @override
  State<StatefulWidget> createState() {
    return new _BuyButtonBarState(productData);
  }

  BuyButtonBar(ProductData productData) {
    this.productData = productData;
  }
}

class _BuyButtonBarState extends State<BuyButtonBar> {
  ProductData _productData;

  IconData _buttonIcon = Icons.shop;
  String _buttonText = "buy";
  Color _buttonColor = Colors.red.shade900;
  Function _buttonAction;
  bool _blocked = false;
  bool _removeButton = false;

  String _succesMsg;
  String _errorMsg;

  _BuyButtonBarState(ProductData productData) {
    _productData = productData;
    _buttonIcon = productData.getBuyIcon();
    _buttonText = productData.getBuyText();
    _buttonColor = productData.getBuyColor();
    _buttonAction = getActualAction();
    _blocked = dataStorage.archiveIsDownloadingNow(_productData.pID);

    if (_blocked) {
      _waitForArchiveLoading();
    }
  }

  @override
  void initState() {
    changeButtonState();

    super.initState();
  }

  @override
  void dispose() {
//    _subscription.cancel();
    super.dispose();
  }

  _waitForArchiveLoading() async {
    while (_blocked) {
      _blocked = dataStorage.archiveIsDownloadingNow(_productData.pID);
      if (!_blocked) {
//        changeButtonState();
        StateWidget.buyButtonController.sink.add("update");
        break;
      }
      await new Future.delayed(const Duration(seconds: 1));
    }
  }

  void changeButtonState() {
//    print("CHANGE BUTTON STATE $mounted");
//    if(!mounted) return;
//    setState(() {
    _buttonIcon = _productData.getBuyIcon();
    _buttonText = _productData.getBuyText();
    _buttonColor = _productData.getBuyColor();
    _buttonAction = getActualAction();
    _blocked = dataStorage.archiveIsDownloadingNow(_productData.pID);
//    });
  }

  Function getActualAction() {
    Function callback;

    // switch(_productData.getActualButtonState()) {
//
    // case ButtonBuyState.OPEN:
    // callback = () async {
    // _openInstruction();
    // };
    // break;
//       case ButtonBuyState.DOWNLOAD:
//         callback = () async {
//           await _downLoadInstruction();
//         };
//         break;
//       case ButtonBuyState.UNLOCK:
//         callback = () async {
//           await _viewAdForUnlock();
//         };
// //        callback = _unlockInstruction();
//         break;
//       case ButtonBuyState.BUY:
//         callback = () async {
//           await _buyInstruction();
//         };
// //        callback = _buyInstruction();
//         break;
    // }

    print("callback == null ${(callback == null)}");
    return callback;
  }

//   /// загрузка архива в память
//   Future _buyInstruction() async {

//     return purchaseManager.buyInstruction(_productData.pIapID, _productData.pID);

//   }

//   /// загрузка архива в память
//   Future<bool> _downLoadInstruction() async {
//     String path = await fileStorage.downloadInstructionArchive(_productData);
//     if (path != null) {
//       dataStorage.setInstructionsDownloaded(_productData.pID, true);

//       if(!downloadedOnce.contains(_productData.pID)) {
//         DocumentReference ref = firestore.collection('users').document(StateWidget.of(context).state.user.uid);
//         downloadedOnce.add(_productData.pID);
//         ref.setData({
//           'downloadedOnce': downloadedOnce
//         }, merge: true);
//       }

//       Fluttertoast.showToast(msg: _succesMsg, toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.black87, textColor: Colors.white);
//       return true;
//     }
//     Fluttertoast.showToast(msg: _errorMsg, toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.black87, textColor: Colors.white);
//     return false;
//   }

//   /// просмотр рекламы для разблокировки инструкции
//   Future _viewAdForUnlock() async {

//     unlockableProduct = _productData;

//     RewardedVideoAd.instance.show()
//         .catchError((onError) {
//           print("change try times $tryTimes" );
//       if (tryTimes <= 0) {
//         tryTimes = 12;
//         tryToLoadAfterDelay();
//       }
//       Fluttertoast.showToast(msg: FlutterI18n.translate(context, "video_not_loaded"), toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.black87, textColor: Colors.white);
//     });

// //    print("uid" + StateWidget.of(context).state.user.uid);

//   }

//   bool _wasRewarded = false;

//   void addRewardedAdListener(FirebaseUser user) {

//     if(RewardedVideoAd.instance.listener == null) {
//       RewardedVideoAd.instance.listener = (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
//         print("REWARDED: ${event.toString()}");

//         switch(event) {

//           case RewardedVideoAdEvent.loaded:
//             tryTimes = 12;
//             break;
//           case RewardedVideoAdEvent.failedToLoad:
//             print("try times $tryTimes");
//             tryToLoadAfterDelay();
//             break;
//           case RewardedVideoAdEvent.opened:
//             _wasRewarded = false;
//             break;
//           case RewardedVideoAdEvent.leftApplication:
//             break;
//           case RewardedVideoAdEvent.closed:

//             if(_wasRewarded) {
//               StateWidget.priceController.sink.add("update");
//               Fluttertoast.showToast(msg: FlutterI18n.translate(context, "thx_for_watching"), toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.black87, textColor: Colors.white);

//               if(viewsRemains[unlockableProduct.pID] <= 0) {
// //                changeButtonState();
//                 StateWidget.buyButtonController.add("update");
//               }
//             }
//             RewardedVideoAd.instance.load(adUnitId: "ca-app-pub-8405597663015191/4385746308", targetingInfo: targetingInfo);

//             break;
//           case RewardedVideoAdEvent.rewarded:
//             print("REWARDED: получаем реф");
//             DocumentReference ref = firestore.collection('users').document(user.uid);

//             viewsRemains.update(unlockableProduct.pID, (views) => --views, ifAbsent: () => unlockableProduct.pAdsPrice-1);
//             print("REWARDED: апдейтнутый вьюс ремейнс");
//             viewsRemains.forEach((k,v) => print("$v $k"));
//             ref.setData({
//               'viewsRemains': viewsRemains,
//             }, merge: true);

//             _wasRewarded = true;
//             break;
//           case RewardedVideoAdEvent.started:
//             break;
//           case RewardedVideoAdEvent.completed:
//             break;
//         }
//       };

//       RewardedVideoAd.instance.load(adUnitId: "ca-app-pub-8405597663015191/4385746308", targetingInfo: targetingInfo);
//     }

//   }

//   static int tryTimes = 12;

//   Future tryToLoadAfterDelay() async {
//     tryTimes--;
//     if (tryTimes > 0) {
//       return new Future.delayed(const Duration(seconds: 5), () => RewardedVideoAd.instance.load(adUnitId: "ca-app-pub-8405597663015191/4385746308", targetingInfo: targetingInfo));
//     }
//   }

  // _openInstruction() async {

  //   Navigator.of(context).push(new MaterialPageRoute(
  //       builder: (BuildContext context) => new InstructionsViewer(_productData.pID)));

  // }

  void _blockButton(bool block) {
    setState(() {
      _blocked = block;
    });
  }

  bool notNull(Object o) => o != null;

  @override
  Widget build(BuildContext context) {
    // addRewardedAdListener(StateWidget.of(context).state.user);

    return new StreamBuilder(
      stream: StateWidget.buyButtonController.stream,
//      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          changeButtonState();
        }
        return new BottomAppBar(
          color: Theme.of(context).primaryColor,
          elevation: 0.0,
          shape: new CircularNotchedRectangle(),
          notchMargin: 5.0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ///del button
                _productData.getActualButtonState() == ButtonBuyState.OPEN &&
                        !_blocked
                    ? _buildRemoveButton()
                    : null,

                ///buy button
                Flexible(flex: 2, child: _buildBuyButton()),
              ].where(notNull).toList(),
            ),
          ),
        );
      },
    );
  }

  Flexible _buildRemoveButton() {
    return Flexible(
      fit: FlexFit.tight,
      flex: 1,
      child: RaisedButton(
        onPressed: () {
          fileStorage.removeInstructionArchive(_productData.pID);
//        changeButtonState();

          StateWidget.buyButtonController.sink.add("update");
        },
        color: Colors.grey,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
              SizedBox(
                width: 4.0,
              ),
              Text(
                FlutterI18n.translate(context, "remove"),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  RaisedButton _buildBuyButton() {
    if (_blocked) {
      return new RaisedButton(
        onPressed: () async {},
        color: _buttonColor,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                FlutterI18n.translate(context, "loading"),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 4.0,
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    } else {
      return new RaisedButton(
        onPressed: () async {
          _succesMsg = FlutterI18n.translate(context, "archive_load_success") +
              _productData.getActualTitle(context);
          _errorMsg = FlutterI18n.translate(context, "archive_load_error") +
              _productData.getActualTitle(context);

          _blockButton(true);
          await _buttonAction();
          StateWidget.buyButtonController.sink.add("update");
//          changeButtonState();
        },
        color: _buttonColor,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                _buttonIcon,
                color: Colors.white,
              ),
              SizedBox(
                width: 4.0,
              ),
              Text(
                FlutterI18n.translate(context, _buttonText),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }
  }
}

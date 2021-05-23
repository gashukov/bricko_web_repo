import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';

import 'models/state.dart';
import 'main.dart';

class StateWidget extends StatefulWidget {
  final StateModel state;
  final Widget child;

  static final StreamController<String> priceController =
      new StreamController<String>.broadcast();
  static final StreamController<String> buyButtonController =
      new StreamController<String>.broadcast();

  // bool _iapAvailable = true;
  // List<ProductDetails> _iapProducts = [];
  // List<PurchaseDetails> _iapPurchases = [];
  StreamSubscription _subscription;

  StateWidget({
    @required this.child,
    this.state,
  });

  // Returns data of the nearest widget _StateDataWidget
  // in the widget tree.
  static _StateWidgetState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_StateDataWidget>())
        .data;
  }

  @override
  _StateWidgetState createState() => new _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  StateModel state;
  GoogleSignInAccount googleUser;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    if (widget.state != null) {
      state = widget.state;
    } else {
      state = new StateModel(isLoading: true);
      initUser();
    }
  }

  // Future<void> _getProducts() async{
  //   iapProducts = new List<ProductDetails>();
  //   List<String> ids = new List();

  //   QuerySnapshot qs = await firestore.collection(productsRoot).getDocuments();
  //   for(DocumentSnapshot ds in qs.docs) {
  //     ids.add(ds.data[productIAPID]);
  //   }
  //   bool ava = await InAppPurchaseConnection.instance.isAvailable();
  //   print("PRODUCTS AVAILABLE " + ava.toString());
  //   ProductDetailsResponse response = await InAppPurchaseConnection.instance.queryProductDetails(Set.from(ids.where((e) => e != "")));
  //   iapProducts.addAll(response.productDetails);
  //   ids.forEach((f) => print("PRODUCTS IDS" + f.toString()));
  //   iapProducts.forEach((ProductDetails f) => print("PRODUCTS" + f.id.toString()));
  // }

  Future<Null> initUser() async {
    print("дебаг: инит юзер");
    googleUser = _googleSignIn.currentUser;
    // Try to sign in the previous user:

    await dataStorage.init();

    if (dataStorage.preferences.containsKey(rememberMePref)) {
      rememberMe = dataStorage.preferences.getBool(rememberMePref);
    } else {
      dataStorage.preferences.setBool(rememberMePref, true);
    }

//    if(!dataStorage.preferences.containsKey(logOutPref)) {
//      await dataStorage.preferences.setBool(logOutPref, false);
//    }

    if (googleUser == null && rememberMe) {
      print("дебаг: юзер = нулл входим тихо");
      googleUser = await _googleSignIn.signInSilently();
    } else if (!rememberMe) {
      await _googleSignIn.signOut();
    }

    if (googleUser == null) {
      print("дебаг: юзер все равно = нулл");
      setState(() {
        state.isLoading = false;
      });
    } else {
      print("дебаг: вошли тихо");
      await signInWithGoogle();
    }
  }

  Future<Null> signInWithGoogle() async {
    if (googleUser == null) {
      print("дебаг: юзер = нулл");
      // Start the sign-in process:
      googleUser = await _googleSignIn.signIn();
      print("дебаг: дождались сигн ин");
    }

    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    print("дебаг: дождались аутентификатион");
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    print("дебаг: дождались signInWithCredential");

//    dataStorage.preferences.setBool(logOutPref, false);

    // await updateUserData(userCredential.user); //todo закомментил для теста
    // await onLogIn(userCredential.user);

    setState(() {
      state.isLoading = false;
      state.user = userCredential.user;
    });
  }

//   Future updateUserData(User user) async {
//     DocumentReference ref = firebaseFirestore.collection('users').doc(user.uid);

//     await ref.set({
//       'uid': user.uid,
//       'email': user.email,
//       'displayName': user.displayName,
// //      'lastSeen': DateTime.now(),
//     }, SetOptions(merge: true));

//     print("ДАННЫЕ ДОБАВЛЕНЫ В БАЗУ ДАННЫХ");
//   }

  // Future onLogIn(FirebaseUser user) async {
  //   await purchaseManager.init(user.uid);
  //   listenUserData(user);

  //   _getProducts();
  // }

  // StreamSubscription<DocumentSnapshot> listenUser;
  // void listenUserData(FirebaseUser user) {
  //   owned?.clear();
  //   viewsRemains?.clear();
  //   downloadedOnce?.clear();

  //   listenUser = firestore.collection('users').document(user.uid).snapshots().listen((snapshot) {
  //     ///listen owned
  //     bool notFound = snapshot["owned"] == null;
  //     owned?.clear();
  //     if (!notFound) {
  //       owned = new List<String>.from(snapshot["owned"]);
  //     }

  //     if(owned == null) {
  //       owned = new List<String>();
  //     }

  //     print("TESTPURCH: owned ");
  //     for(int i = 0; i < owned.length; i ++) {
  //       print("TESTPURCH: " + owned[i]);
  //     }
  //     print("TESTPURCH: inventory ");
  //     for(int i = 0; i < purchaseManager.purchases.length; i ++) {
  //       print("TESTPURCH: " + purchaseManager.purchases[i].productID);
  //     }

  //     for (int i = 0 ; i < purchaseManager.purchases.length; i++ ) {
  //       print("TESTPURCH: status " + purchaseManager.purchases[i].status.toString() + "   " + (purchaseManager.purchases[i].status == PurchaseStatus.purchased).toString());
  //       print("TESTPURCH: startbuy " + dataStorage.getStartBuyProduct(user.uid));
  //       if (dataStorage.getStartBuyProduct(user.uid) == purchaseManager.purchases[i].productID) {
  //         print("TESTPURCH: purchased and was started from id ");
  //         if(owned.contains(purchaseManager.purchases[i].productID)) {
  //           print("TESTPURCH: contains");
  //           InAppPurchaseConnection.instance.consumePurchase(purchaseManager.purchases[i]);
  //         } else {
  //           print("TESTPURCH: not contains");
  //           owned.add(purchaseManager.purchases[i].productID);
  //           firestore.collection('users').document(user.uid).setData({
  //             'owned': owned,
  //           }, merge: true);
  //         }
  //       }
  //     }

  //     print("GET OWNED");
  //     owned.forEach((e) => print(e));

  //     ///listen views ads
  //     bool viewsRemainsNotFound = snapshot["viewsRemains"] == null;
  //     if (!viewsRemainsNotFound) {
  //       viewsRemains = new Map<String, int>.from(snapshot["viewsRemains"]);
  //     }

  //     if(viewsRemains == null) {
  //       viewsRemains = new Map<String, int>();
  //     }
  //     viewsRemains?.forEach((k,v) => print("$k  $v"));

  //     ///listen downloaded
  //     bool downloadedNotFound = snapshot["downloadedOnce"] == null;
  //     if (!downloadedNotFound) {
  //       downloadedOnce = new List<String>.from(snapshot["downloadedOnce"]);
  //     }

  //     if(downloadedOnce == null) {
  //       downloadedOnce = new List<String>();
  //     }
  //   });
  //   listenUser.onError((error) {
  //     print("не удалось получить данные юзера" + error.toString());
  //   });
  // }

//  void updateUserAdsViews(String pID, int viewsRemain) async {
//    DocumentReference ref = firestore.collection('users').document(state.user.uid);
//
//    await ref.setData({
//      'uid': user.uid,
//      'email': user.email,
//      'displayName': user.displayName,
//      'lastSeen': DateTime.now()
//    }, merge: true);
//
//  }
//
//  Map<String, int> viewsRemains = new Map();
//
//  Future<int> getUserAdsViewsRemain(String pID) async {
//    firestore.collection('users').document(state.user.uid).snapshots().listen((snapshot) {
//      viewsRemains = snapshot["viewsRemains"];
//    });
//
//  }

  Future<Null> signOut() async {
    setState(() {
      state.isLoading = true;
      state.user = null;
    });
    await _auth.signOut();
    googleUser = null;
    await _googleSignIn.signOut();

    setState(() {
      state.isLoading = false;
    });

//    dataStorage.preferences.setBool(logOutPref, true);
  }

  @override
  void dispose() {
    if (!rememberMe) {
      signOut();
    }
    // listenUser.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new _StateDataWidget(
      data: this,
      child: widget.child,
    );
  }
}

class _StateDataWidget extends InheritedWidget {
  final _StateWidgetState data;

  _StateDataWidget({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  // Rebuild the widgets that inherit from this widget
  // on every rebuild of _StateDataWidget:
  @override
  bool updateShouldNotify(_StateDataWidget old) => true;
}

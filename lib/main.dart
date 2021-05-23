import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'state_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'utils/file_storage.dart';
import 'utils/data_storage.dart';
import 'models/product_data.dart';

FilesStorage fileStorage;
DataStorage dataStorage;
// PurchaseManager purchaseManager;
final Future<FirebaseApp> initialization = Firebase.initializeApp();

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

bool rememberMe = true;
String rememberMePref = "remember_me";
bool logOut = false;
String logOutPref = "log_out";

Map<String, int> viewsRemains;
List<String> owned;
List<String> downloadedOnce;
ProductData unlockableProduct;
// List<ProductDetails> iapProducts;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  fileStorage = new FilesStorage();
  fileStorage.init();
  dataStorage = new DataStorage();
  dataStorage.init();
  // purchaseManager = new PurchaseManager();

  initApp();
}

initApp() {
  StateWidget stateWidget =
      new StateWidget(child: new BricksBuildInstructionsApp());
  runApp(stateWidget);
}

//class Utils {
//
//  static List<Future> getInitializers() {
//    List<Future> result = new List();
//    result.add(getIconsNames());
//
//    return result;
//  }
//
//  static Future getIconsNames() async{
//    Firestore firestore = Firestore.instance;
//
//    List<DocumentSnapshot> docs;
//    firestore.collection("instructions").getDocuments().then((snap) {
//      docs = snap.documents;
//      docs.forEach((d) {
//        print(d.data["icon_name"]);
//      });
//    });
//  }
//
//}

import 'package:bricko_web/utils/locator.dart';
import 'package:bricko_web/utils/streams.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  fileStorage = new FilesStorage();
  fileStorage.init();
  dataStorage = new DataStorage();
  dataStorage.init();

  await initialization;
  // purchaseManager = new PurchaseManager();

  StreamsUtil.initStreams();

  initApp();
}

initApp() async {
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en', supportedLocales: ['en', 'ru']);

  StateWidget stateWidget =
      new StateWidget(child: new BricksBuildInstructionsApp());
  runApp(LocalizedApp(delegate, stateWidget));
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
//      docs = snap.docs;
//      docs.forEach((d) {
//        print(d.data["icon_name"]);
//      });
//    });
//  }
//
//}

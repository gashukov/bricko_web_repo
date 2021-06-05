import 'package:cloud_firestore/cloud_firestore.dart';

import 'app_data.dart';

List<QueryDocumentSnapshot> categoriesSnapshots;
List<QueryDocumentSnapshot> setsSnapshots;

class StreamsUtil {
  static initStreams() {
    FirebaseFirestore.instance
        .collection(categoriesRoot)
        .snapshots()
        .listen((event) {
      categoriesSnapshots = event.docs;
    });
    FirebaseFirestore.instance.collection(setsRoot).snapshots().listen((event) {
      setsSnapshots = event.docs;
    });
  }
}

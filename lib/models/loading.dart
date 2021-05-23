import 'package:cloud_firestore/cloud_firestore.dart';


class LoadingService {
  static const String _instructionsPath = "instructions";

  List<DocumentSnapshot> instructionsData;

  Future getInstructionsData() async {
//    _firestore.collection(_instructionsPath).getDocuments()
  }

}


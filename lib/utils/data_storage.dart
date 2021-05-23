import 'package:shared_preferences/shared_preferences.dart';

class DataStorage {
  SharedPreferences preferences;


  Future init() async {
    if(preferences != null)
      return;
    preferences = await SharedPreferences.getInstance();
    _clearAllDownloadingArchiveKeys();
  }


  DataStorage() {



  }

  startBuyProduct(String userID, String iapID) {
    preferences.setString("startbuy" + userID, iapID);
  }

  String getStartBuyProduct(String userID) {
    if (!preferences.containsKey("startbuy" + userID)) {
      return "";
    }
    return preferences.getString("startbuy" + userID);
  }

  removeStartBuyProduct(String userID) {
    preferences.remove("startbuy" + userID);
  }

  savePage(String pID, double page) {
    preferences.setDouble("${pID}_page", page);
    print("save $pID page $page");
  }

  double getPage(String pID) {
    if(!preferences.containsKey("${pID}_page"))
      return 0.0;
    print("get $pID page ${preferences.getDouble("${pID}_page")}");
    return preferences.getDouble("${pID}_page");
  }

  _clearAllDownloadingArchiveKeys() {
    for(String key in preferences.getKeys()) {
      if(key.contains("_archive_downloading")) {
        preferences.setBool(key, false);
      }
    }
  }

  bool instructionIsDownloaded(String pID) {
    if (preferences.containsKey("${pID}_downloaded")) {
      if (preferences.getBool("${pID}_downloaded")) {
        return true;
      }
    } else {
      preferences.setBool("${pID}_downloaded", false);
    }
    return false;
  }

  Future<bool> setInstructionsDownloaded(String pID, bool downloaded) async {
    return await preferences.setBool("${pID}_downloaded", downloaded);
  }

  bool archiveIsDownloadingNow(String pID) {
    if (preferences.containsKey("${pID}_archive_downloading")) {
      if (preferences.getBool("${pID}_archive_downloading")) {
        return true;
      }
    } else {
      preferences.setBool("${pID}_archive_downloading", false);
    }
    return false;
  }

  Future<bool> setArchiveDownloadingNow(String pID, bool downloaded) async {
    return await preferences.setBool("${pID}_archive_downloading", downloaded);
  }


}
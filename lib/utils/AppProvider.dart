import 'package:flutter/material.dart';
import 'enumerators.dart';

class AppProvider with ChangeNotifier {
  DisplayedPage currentPage;
  double revenue = 0;

  AppProvider.init() {
    changeCurrentPage(DisplayedPage.HOME);
  }

  changeCurrentPage(DisplayedPage newPage) {
    currentPage = newPage;
    notifyListeners();
  }
}

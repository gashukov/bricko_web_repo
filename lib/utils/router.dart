import 'package:bricko_web/pages/home.dart';
import 'package:bricko_web/pages/layout.dart';
import 'package:bricko_web/pages/login.dart';
import 'package:bricko_web/pages/sets_page.dart';
import 'package:flutter/material.dart';

import '../app.dart';
import '../constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  print('generateRoute: ${settings.name}');
  switch (settings.name) {
    case HomeRoute:
      return _getPageRoute(HomePage());
    // case UsersRoute:
    //   return _getPageRoute(UsersPage());
    case LoginRoute:
      return _getPageRoute(LoginPage());
    case LayoutRoute:
      return _getPageRoute(LayoutTemplate());
    // case CategoriesRoute:
    //   return _getPageRoute(CategoriesPage());
    case SetsRoute:
      return _getPageRoute(SetsPage());
    case PageControllerRoute:
      return _getPageRoute(AppPagesController());
    default:
      return _getPageRoute(HomePage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(
    builder: (context) => child,
  );
}

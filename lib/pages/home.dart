import 'package:bricko_web/componets/header.dart';
import 'package:bricko_web/componets/products.dart';
import 'package:bricko_web/constants.dart';
import 'package:bricko_web/controllers/MenuController.dart';
import 'package:bricko_web/widgets/DrawerListTile.dart';
import 'package:flutter/material.dart';

//my own imports

import 'package:bricko_web/models/state.dart';
import 'package:bricko_web/state_widget.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:bricko_web/componets/sets_chips.dart';
import 'package:provider/provider.dart';

import '../responsive.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StateModel appState;

  Widget _buildContent() {
    if (appState.isLoading) {
      print("билдим загрузку");
      return _buildMainView(
        body: _buildLoadingIndicator(primaryColor),
      );
    }
    // else if (!appState.isLoading && appState.user == null) {
    //   print("билдим логин паге");
    //   return new LoginPage();
    // }
    else {
      print("билдим хоум паге");
      return _buildMainContent();
    }
//    return _buildMainContent();
  }

  // индикатор загрузки
  Center _buildLoadingIndicator(Color color) {
    return Center(
        child: new CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(color),
    ));
  }

  // основной таб
  Scaffold _buildMainView({Widget body}) {
    return Scaffold(
      body: SafeArea(
        child: body,
      ),
    );
  }

  Drawer sideMenu() {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            new UserAccountsDrawerHeader(
              accountName: appState.user != null
                  ? Text(appState.user.displayName)
                  : Text("User"),
              accountEmail: appState.user != null
                  ? Text(appState.user.email)
                  : Text("user@email.com"),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  // backgroundColor: Colors.grey,
                  backgroundImage: appState.user != null
                      ? NetworkImage(appState.user.photoURL)
                      : null,
                ),
              ),
              decoration: new BoxDecoration(color: secondaryColor),
            ),

            DrawerListTile(
              title: "Главная",
              iconData: Icons.home,
              press: () {
                Navigator.of(context).pop();
              },
            ),

            // Divider(),

            DrawerListTile(
              title: translate("logout"),
              iconData: Icons.logout,
              press: () {
                NavigatorState navigator = Navigator.of(context);
                Navigator.of(context).pop(); // Added
                Route route = ModalRoute.of(context);
                while (navigator.canPop()) navigator.removeRouteBelow(route);

                StateWidget.of(context).signOut();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: sideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: sideMenu(),
              ),
            Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Column(
                      children: [
                        // new SetsChips(),
                        Header(),
                        SizedBox(height: defaultPadding),
                        Products(null, null),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build the content depending on the state:
    appState = StateWidget.of(context).state;
    return _buildContent();
  }
}

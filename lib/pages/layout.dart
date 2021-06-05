import 'package:bricko_web/componets/DrawerListTile.dart';
import 'package:bricko_web/models/state.dart';
import 'package:bricko_web/utils/AppProvider.dart';
import 'package:bricko_web/utils/enumerators.dart';
import 'package:bricko_web/utils/locator.dart';
import 'package:bricko_web/utils/navigation_service.dart';
import 'package:bricko_web/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../state_widget.dart';

class LayoutTemplate extends StatefulWidget {
  @override
  _LayoutTemplateState createState() => _LayoutTemplateState();
}

class _LayoutTemplateState extends State<LayoutTemplate> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  StateModel appState;

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    return _buildContent();

    // return Scaffold(
    //   key: _key,
    //   backgroundColor: Colors.white,
    //   drawer: Container(
    //     color: Colors.white,
    //     child: ListView(
    //       children: [
    //         UserAccountsDrawerHeader(
    //           accountEmail: Text("abc@gmail.com"),
    //           accountName: Text("Santos Enoque"),
    //         ),
    //         ListTile(
    //           title: Text("Lessons"),
    //           leading: Icon(Icons.book),
    //         )
    //       ],
    //     ),
    //   ),
    //   body: Row(
    //     children: [
    //       SideMenu(),
    //       Expanded(
    //         child: Column(
    //           children: [
    //             // NavigationBar(),
    //             Expanded(
    //               child: Navigator(
    //                 key: locator<NavigationService>().navigatorKey,
    //                 onGenerateRoute: generateRoute,
    //                 initialRoute: HomeRoute,
    //               ),
    //             )
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }

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
      print("билдим лэйаут");
      return _buildMainContent();
    }
//    return _buildMainContent();
  }

  Scaffold _buildMainView({Widget body}) {
    return Scaffold(
      appBar: PreferredSize(
        // We set Size equal to passed height (50.0) and infinite width:
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          elevation: 2.0,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: body,
      ),
    );
  }

  Center _buildLoadingIndicator(Color color) {
    return Center(
        child: new CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(color),
    ));
  }

  Widget _buildMainContent() {
    print("лэйаут билдится");
    return Scaffold(
      // appBar: new AppBar(
      //   elevation: 0.1,
      //   backgroundColor: Colors.red.shade900,
      //   title: Text(translate("home_title")),
      // ),
      key: _key,
      drawer: sideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            // if (Responsive.isDesktop(context))
            Expanded(
              // default flex = 1
              // and it takes 1/6 part of the screen
              child: sideMenu(),
            ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: Navigator(
                key: locator<NavigationService>().navigatorKey,
                initialRoute: HomeRoute,
                onGenerateRoute: generateRoute,
              ),
            ),
          ],
        ),
      ),

      // new Column(
      //   children: <Widget>[

      //     new SetsChips(),

      //     Flexible(child: Products(null, null)),
      //   ],
      // ),
    );
  }

  Drawer sideMenu() {
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: appState.user != null
                  ? Text(appState.user.displayName)
                  : Text("mashukovg@gmail.com"),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  // backgroundColor: Colors.grey,
                  backgroundImage: appState.user != null
                      ? NetworkImage(appState.user.photoURL)
                      : Image.asset('images/unnamed.jpg').image,
                ),
              ),
              decoration: new BoxDecoration(color: secondaryColor),
            ),
            DrawerListTile(
              title: "Инструкции",
              active: appProvider.currentPage == DisplayedPage.HOME,
              iconData: Icons.list_alt,
              press: () {
                appProvider.changeCurrentPage(DisplayedPage.HOME);
                locator<NavigationService>().navigateTo(HomeRoute);
              },
            ),
            DrawerListTile(
              title: "Наборы",
              active: appProvider.currentPage == DisplayedPage.SETS,
              iconData: Icons.crop_square,
              press: () {
                appProvider.changeCurrentPage(DisplayedPage.SETS);
                locator<NavigationService>().navigateTo(SetsRoute);
              },
            ),
            DrawerListTile(
              title: "Категории",
              active: appProvider.currentPage == DisplayedPage.CATEGORIES,
              iconData: Icons.category,
              press: () {
                appProvider.changeCurrentPage(DisplayedPage.CATEGORIES);
                locator<NavigationService>().navigateTo(CategoriesRoute);
              },
            ),
            DrawerListTile(
              title: "Пользователи",
              active: appProvider.currentPage == DisplayedPage.USERS,
              iconData: Icons.supervised_user_circle_sharp,
              press: () {
                appProvider.changeCurrentPage(DisplayedPage.USERS);
                locator<NavigationService>().navigateTo(UsersRoute);
              },
            ),
            DrawerListTile(
              title: translate("logout"),
              active: false,
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
}

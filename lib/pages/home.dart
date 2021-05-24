import 'package:bricko_web/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//my own imports
import 'package:bricko_web/componets/products.dart';
import 'package:bricko_web/models/state.dart';
import 'package:bricko_web/state_widget.dart';
import 'package:bricko_web/main.dart';
import 'package:bricko_web/utils/app_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bricko_web/componets/category_chips.dart';
import 'package:bricko_web/componets/sets_chips.dart';
import 'package:flutter_translate/flutter_translate.dart';

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
        body: _buildLoadingIndicator(Colors.red.shade900),
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

//   Widget _buildImageCorousel() {
//     return new Container(
//       height: 200.0,
//       child:  new Carousel(
//         boxFit: BoxFit.cover,
//         images: [

//           AssetImage('images/w3.jpeg'),
//           AssetImage('images/m1.jpeg'),
//           AssetImage('images/c1.jpg'),
//           AssetImage('images/w4.jpeg'),
//           AssetImage('images/m2.jpg'),
//         ],
//         autoplay: false,
// //      animationCurve: Curves.fastOutSlowIn,
// //      animationDuration: Duration(milliseconds: 1000),
//         dotSize: 4.0,
//         indicatorBgPadding: 2.0,
//       ),
//     );
//   }

  Widget _buildMainContent() {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red.shade900,
        title: Text(translate("home_title")),
//        actions: <Widget>[
//          new IconButton(
//              icon: Icon(
//                Icons.search,
//                color: Colors.white,
//              ),
//              onPressed: () {}),
////          new IconButton(
////              icon: Icon(
////                Icons.shopping_cart,
////                color: Colors.white,
////              ),
////              onPressed: () {})
//        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
//            header
            new UserAccountsDrawerHeader(
              accountName: appState.user != null
                  ? Text(appState.user.displayName)
                  : Text("User"),
              accountEmail: appState.user != null
                  ? Text(appState.user.email)
                  : Text("user@email.com"),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: appState.user != null
                      ? NetworkImage(appState.user.photoURL)
                      : null,
                ),
              ),
              decoration: new BoxDecoration(color: Colors.red.shade900),
            ),

//            body

            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: ListTile(
                title: Text('Главная'),
                leading: Icon(Icons.home),
              ),
            ),

//            InkWell(
//              onTap: (){},
//              child: ListTile(
//                title: Text('Профиль'),
//                leading: Icon(Icons.person),
//              ),
//            ),

//            InkWell(
//              onTap: (){},
//              child: ListTile(
//                title: Text('My Orders'),
//                leading: Icon(Icons.shopping_basket),
//              ),
//            ),

//            InkWell(
//              onTap: (){},
//              child: ListTile(
//                title: Text('Категории'),
//                leading: Icon(Icons.dashboard),
//              ),
//            ),

//            InkWell(
//              onTap: (){},
//              child: ListTile(
//                title: Text('Favourites'),
//                leading: Icon(Icons.favorite),
//              ),
//            ),

            Divider(),

            InkWell(
              onTap: () async {
                NavigatorState navigator = Navigator.of(context);
                Navigator.of(context).pop(); // Added
                Route route = ModalRoute.of(context);
                while (navigator.canPop()) navigator.removeRouteBelow(route);

                StateWidget.of(context).signOut();

//                FirebaseAuth.instance.signOut().then((value){
//                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
//                });
              },
              child: ListTile(
                title: Text(translate("logout")),
                leading: Icon(
                  Icons.transit_enterexit,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
      body: new Column(
        children: <Widget>[
          //image carousel begins here
//          image_carousel,

//          //padding widget
//          new Padding(padding: const EdgeInsets.all(4.0),
//            child: Container(
//                alignment: Alignment.centerLeft,
//                child: new Text('Categories')),),
//
//          //Horizontal list view begins here
//          HorizontalList(),

          //padding widget
//          new Padding(padding: const EdgeInsets.all(8.0),
//            child: Container(
//                alignment: Alignment.centerLeft,
//                child: new Text('All instructions')),),

          //grid view

          new SetsChips(),

          Flexible(child: Products(null, null)),
        ],
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

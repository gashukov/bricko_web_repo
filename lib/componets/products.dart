import 'package:bricko_web/state_widget.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bricko_web/pages/product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bricko_web/main.dart';
import 'package:bricko_web/utils/app_data.dart';
import 'package:bricko_web/utils/help_functions.dart';
import 'package:bricko_web/models/product_data.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();

  String category;
  String set;

  Products(this.set, this.category);
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
        stream: firebaseFirestore.collection(productsRoot).snapshots(),
        builder: (context, snapshot) {
          return new StreamBuilder(
              stream: firebaseFirestore
                  .collection(usersRoot)
                  .doc(StateWidget.of(context).state.user.uid)
                  .snapshots(),
              builder: (context, snapshotuser) {
                if (!snapshot.hasData || !snapshotuser.hasData) {
                  return new Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ),
                  );
                } else {
                  List<String> localOwned = snapshotuser.data["owned"] == null
                      ? null
                      : List.from(snapshotuser.data["owned"]);
                  if (localOwned != null) {
                    localOwned.forEach((e) => print("LOCAL OWNED ${e}"));
                  }

                  List<DocumentSnapshot> productList = snapshot.data.documents;
                  print("CHECK OWNED");
                  productList.removeWhere((DocumentSnapshot d) =>
                      !(d[productActive] ||
                          localOwned != null &&
                              localOwned.contains(d.id.replaceAll(" ", ""))));
                  if (widget.set != null) {
                    productList = productList
                        .where((DocumentSnapshot d) =>
                            d[productSet].toString() == widget.set)
                        .toList();
                  }
                  if (widget.category != null) {
                    productList = productList
                        .where((DocumentSnapshot d) =>
                            (d[productCategories] as List<dynamic>)
                                .contains(widget.category))
                        .toList();
                  }

                  if (productList.length == 0) {
                    return new Center(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Icon(
                            Icons.find_in_page,
                            color: Colors.black45,
                            size: 80.0,
                          ),
                          new Text(
                            FlutterI18n.translate(context, "no_instructions"),
                            style: new TextStyle(
                              color: Colors.black45,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return new StaggeredGridView.countBuilder(
                        crossAxisCount: 2,
                        itemCount: productList.length,
                        staggeredTileBuilder: (int index) =>
                            new StaggeredTile.count(1, 1.24),
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        itemBuilder: (BuildContext context, int index) {
                          return SingleProduct(new ProductData(
                              productList[index].id.replaceAll(" ", ""),
                              productList[index][productPriceType],
                              productList[index][productAdsPrice],
                              productList[index][productTitleEN],
                              productList[index][productTitleRU],
                              productList[index][productDescriptionEN],
                              productList[index][productDescriptionRU],
                              productList[index][productScreensCount],
                              productList[index][productCategories],
                              productList[index][productSet],
                              productList[index][productIAPID]));
                        });
                  }
                }
              });
        });

//    return new StreamBuilder(
//        stream: firestore.collection(productsRoot).snapshots(),
//        builder: (context, snapshot){
//          if(!snapshot.hasData) {
//            return new Center(
//              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),),
//            );
//          } else {
//            List<DocumentSnapshot> productList = snapshot.data.documents;
//            print("CHECK OWNED");
//            productList.removeWhere((DocumentSnapshot d) => !(d[productActive] || owned.contains(d.documentID.replaceAll(" ", ""))));
//            if (widget.set != null) {
//              productList = productList.where((DocumentSnapshot d) => d[productSet].toString() == widget.set).toList();
//            }
//            if (widget.category != null) {
//              productList = productList.where((DocumentSnapshot d) => (d[productCategories] as List<dynamic>).contains(widget.category)).toList();
//            }
//
//
//
//            if(productList.length == 0) {
//
//              return new Center(
//                child: new Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    new Icon(
//                      Icons.find_in_page,
//                      color: Colors.black45,
//                      size: 80.0,
//                    ),
//                    new Text(
//                      FlutterI18n.translate(context, "no_instructions"),
//                      style: new TextStyle(
//                        color: Colors.black45,
//                        fontSize: 20,
//                      ),
//                    )
//                  ],
//                ),
//              );
//
//            } else {
//              return  new StaggeredGridView.countBuilder(
//
//                  crossAxisCount: 2,
//                  itemCount: productList.length,
//                  staggeredTileBuilder: (int index) => new StaggeredTile.count(1, 1.25),
//
//                  mainAxisSpacing: 4.0,
//                  crossAxisSpacing: 4.0,
//                  itemBuilder: (BuildContext context, int index) {
//                    return SingleProduct(
//                        new ProductData(
//                            productList[index].documentID.replaceAll(" ", ""),
//                            productList[index][productPriceType],
//                            productList[index][productAdsPrice],
//                            productList[index][productTitleEN],
//                            productList[index][productTitleRU],
//                            productList[index][productDescriptionEN],
//                            productList[index][productDescriptionRU],
//                            productList[index][productScreensCount],
//                            productList[index][productCategories],
//                            productList[index][productSet],
//                            productList[index][productIAPID]
//                        )
//                    );
//                  });
//            }
//          }
//        });
  }
}

class SingleProduct extends StatefulWidget {
  ProductData productData;
  SingleProduct(this.productData);

  @override
  State<StatefulWidget> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  String _price;

  Future _getPriceAfterDelay(BuildContext context) {
    return new Future.delayed(
        new Duration(seconds: 2),
        () => setState(() {
              _price = getPriceByPriceType(context, widget.productData);
            }));
  }

  @override
  Widget build(BuildContext context) {
    _price = getPriceByPriceType(context, widget.productData);
    if (_price == null) _getPriceAfterDelay(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      child: Material(
        child: InkWell(
          // onTap:
          // () {
          //   Navigator.of(context).push(new MaterialPageRoute(
          //       builder: (BuildContext context) =>
          //           new ProductDetails(widget.productData)));
          // },
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: FirebaseImage(
                      'gs://bricko.appspot.com' +
                          getIconPathByPID(widget.productData.pID),
                      cacheRefreshStrategy: CacheRefreshStrategy.NEVER,
                      shouldCache: true,
                      firebaseApp: FirebaseFirestore.instance.app,
                    ),
                    width: double.maxFinite,
                    fit: BoxFit.fitWidth,
                  ),
//                child: Image.asset(
//                  "images/logo.png",
//
//                ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 2),
                  child: Text(
                    widget.productData.getActualTitle(context),
                    style: TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black87),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                  ),
                ),
              ),

              ///product price
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 2, 8, 4),
                  child: Text(
                    _price != null
                        ? _price
                        : FlutterI18n.translate(context, "loading_3dots"),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

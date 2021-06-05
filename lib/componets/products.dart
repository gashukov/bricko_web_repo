import 'package:bricko_web/state_widget.dart';
import 'package:bricko_web/utils/AppProvider.dart';
import 'package:bricko_web/utils/enumerators.dart';
import 'package:bricko_web/utils/locator.dart';
import 'package:bricko_web/utils/navigation_service.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bricko_web/pages/product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bricko_web/main.dart';
import 'package:bricko_web/utils/app_data.dart';
import 'package:bricko_web/utils/help_functions.dart';
import 'package:bricko_web/models/product_data.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:bricko_web/utils/firebase_storage_image.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../responsive.dart';

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
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    return new StreamBuilder(
      stream: FirebaseFirestore.instance.collection(categoriesRoot).snapshots(),
      builder: (context, snapshotCat) {
        return new StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection(productsRoot).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ),
                );
              } else {
                // List<String> localOwned = snapshotuser.data["owned"] == null ? null : List.from(snapshotuser.data["owned"]);
                // if(localOwned != null) {
                //   localOwned.forEach((e) => print("LOCAL OWNED ${e}"));
                // }
                List<DocumentSnapshot> productList = snapshot.data.docs;
                List<DocumentSnapshot> categoriesList = snapshotCat.data.docs;

                print("CHECK OWNED");
                // todo заменить на локальную проверку
                // productList.removeWhere((DocumentSnapshot d) => !(d[productActive] || localOwned != null && localOwned.contains(d.id.replaceAll(" ", ""))));
                productList
                    .removeWhere((DocumentSnapshot d) => !d[productActive]);
                // if (widget.set != null) {
                //   productList = productList
                //       .where((DocumentSnapshot d) =>
                //           d[productSet].toString() == widget.set)
                //       .toList();
                // }
                // if (widget.category != null) {
                //   productList = productList
                //       .where((DocumentSnapshot d) =>
                //           (d[productCategories] as List<dynamic>)
                //               .contains(widget.category))
                //       .toList();
                // }

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
                          translate("no_instructions"),
                          style: new TextStyle(
                            color: Colors.black45,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Инструкции",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                            ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                  width: 120, height: 45),
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green),
                                  onPressed: () {
                                    appProvider.changeCurrentPage(
                                        DisplayedPage.ADDCATEGORY);
                                    locator<NavigationService>()
                                        .navigateTo(AddCategoryRoute);
                                  },
                                  icon: Icon(Icons.add),
                                  label: Text("Создать")),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: DataTable(
                            horizontalMargin: 0,
                            columnSpacing: defaultPadding,
                            // dataRowHeight: 100,
                            columns: [
                              DataColumn(
                                label: Text("Название"),
                              ),
                              DataColumn(
                                label: Text("Категория"),
                              ),
                              DataColumn(
                                label: Text("Набор"),
                              ),
                              DataColumn(
                                label: Text(""),
                              ),
                              // DataColumn(
                              //   label: Text(""),
                              // ),
                            ],
                            rows: List.generate(
                              productList.length,
                              (index) => singleProductRow(
                                  new ProductData(
                                      productList[index].id.replaceAll(" ", ""),
                                      productList[index]
                                          .data()[productPriceType],
                                      productList[index]
                                          .data()[productAdsPrice],
                                      productList[index].data()[productTitleEN],
                                      productList[index].data()[productTitleRU],
                                      productList[index]
                                          .data()[productDescriptionEN],
                                      productList[index]
                                          .data()[productDescriptionRU],
                                      productList[index]
                                          .data()[productScreensCount],
                                      productList[index]
                                          .data()[productCategories],
                                      productList[index].data()[productSet],
                                      productList[index].data()[productIAPID]),
                                  categoriesList,
                                  context),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Container(
                            //   padding: EdgeInsets.symmetric(horizontal: 15),
                            //   child: Text("Rows per page:"),
                            // ),
                            // if (tablesProvider.perPages != null)
                            //   Container(
                            //     padding: EdgeInsets.symmetric(horizontal: 15),
                            //     child: DropdownButton(
                            //         value: tablesProvider.currentPerPage,
                            //         items: tablesProvider.perPages
                            //             .map((e) => DropdownMenuItem(
                            //                   child: Text("$e"),
                            //                   value: e,
                            //                 ))
                            //             .toList(),
                            //         onChanged: (value) {}),
                            //   ),
                            // Container(
                            //   padding: EdgeInsets.symmetric(horizontal: 15),
                            //   child: Text(
                            //       "${tablesProvider.currentPage} - ${tablesProvider.currentPage} of ${tablesProvider.total}"),
                            // ),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 16,
                              ),
                              onPressed: () {},
                              padding: EdgeInsets.symmetric(horizontal: 15),
                            ),
                            Text("1"),
                            IconButton(
                              icon: Icon(Icons.arrow_forward_ios, size: 16),
                              onPressed: () {},
                              padding: EdgeInsets.symmetric(horizontal: 15),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }
              }
            });
      },
    );

//    return new StreamBuilder(
//        stream: firestore.collection(productsRoot).snapshots(),
//        builder: (context, snapshot){
//          if(!snapshot.hasData) {
//            return new Center(
//              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),),
//            );
//          } else {
//            List<DocumentSnapshot> productList = snapshot.data.docs;
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

DataRow singleProductRow(ProductData productData,
    List<DocumentSnapshot> categoriesList, BuildContext context) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Image(
                image: FirebaseImage(
                  'gs://bricko.appspot.com' + getIconPathByPID(productData.pID),
                  shouldCache: false,
                  firebaseApp: FirebaseFirestore.instance.app,
                ),
                width: 100,
                height: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(productData.getActualTitle(context)),
            ),
          ],
        ),
      ),
      DataCell(Text(categoriesList
          .firstWhere(
              (element) => element.id == productData.pCategories[0].toString())
          .data()["title_ru"])),
      DataCell(Text(productData.pSet.toString())),
      DataCell(Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(primary: primaryColor),
                onPressed: () {},
                icon: Icon(Icons.edit),
                label: Text("Изменить")),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                  onPressed: () {},
                  icon: Icon(Icons.delete),
                  label: Text("Удалить"))),
        ],
      )),
    ],
  );
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
                  // child: Image(
                  //   image: FirebaseStorageImage(
                  //       'gs://bricko.appspot.com' +
                  //           getIconPathByPID(widget.productData.pID),
                  //       scale: 1,
                  //       firebaseApp: firebaseFirestore.app),
                  //   width: double.maxFinite,
                  //   fit: BoxFit.fitWidth,
                  // ),
                  child: Image(
                    image: FirebaseImage(
                        'gs://bricko.appspot.com' +
                            getIconPathByPID(widget.productData.pID),
                        shouldCache: true,
                        firebaseApp: FirebaseFirestore.instance.app,
                        cacheRefreshStrategy: CacheRefreshStrategy.NEVER),
                    width: double.maxFinite,
                    fit: BoxFit.fitWidth,
                  ),
                  // child: Image.asset(
                  //   "images/logo.png",
                  // ),
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
                    _price != null ? _price : translate("loading_3dots"),
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

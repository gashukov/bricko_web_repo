import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bricko_web/componets/category_chips.dart';
import 'package:bricko_web/componets/products.dart';

class ProductsPage extends StatelessWidget {

  String set;
  String category;
  String title;

  ProductsPage(this.title, this.set, this.category);

  @override
  Widget build(BuildContext context) {

    List<Widget> bodyWidgets = List<Widget>();

    if(set != null && category == null) bodyWidgets.add(new CategoryChips(title, set));
    bodyWidgets.add(Flexible(child: Products(set, category)));

    return new Scaffold(
      appBar: new AppBar(
        iconTheme: new IconThemeData(color: Colors.white),
        title: new Text(title),
        centerTitle: false,
      ),
      body: new Column(
        children: bodyWidgets,
      ),
    );
  }

}
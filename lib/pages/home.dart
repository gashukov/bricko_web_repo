import 'package:bricko_web/constants.dart';
import 'package:flutter/material.dart';

//my own imports
import 'package:bricko_web/componets/products.dart';
import 'package:bricko_web/componets/header.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print("хоум билдится");
    

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            // new SetsChips(),
            Header("Панель администратора", true),
            SizedBox(height: defaultPadding),
            Products(null, null),
          ],
        ),
      ),
    );
  }
}

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
import 'package:bricko_web/componets/products_page.dart';

class SetsChips extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    /// category chips
    return StreamBuilder(
        stream: firebaseFirestore.collection(setsRoot).snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData) {
            return new Center(
              child: Container(
                height: 60,
              )
            );
          } else {
            final int dataCount = snapshot.data.documents.length;
//            print("data count $dataCount");
            if(dataCount == 0) {

              return new Center(
                  child: Container(
                    height: 60,
                  )
              );

            } else {
              List<DocumentSnapshot> c = snapshot.data.documents;
              c.forEach((f) => print("set loaded " + f.id));


              return Container(
                height: 60,
                child: new ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dataCount,
                  itemBuilder: (BuildContext context, int index) {
                    String title = snapshot.data.documents[index][FlutterI18n.currentLocale(context).languageCode == "ru" ? "title_ru" : "title_en"];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ActionChip(
                        pressElevation: 2,
                        backgroundColor: Colors.white,
                        elevation: 4.0,
                        onPressed: () {
//                          setCategory((snapshot.data.documents[index] as DocumentSnapshot).documentID);

                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) => new ProductsPage(title, (snapshot.data.documents[index] as DocumentSnapshot).id, null)));
                        },
                        label: Text(title),
                      ),
                    );
                  },
                ),
              );
            }
          }
        }
    );
  }

}
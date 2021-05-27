import 'package:bricko_web/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//my own imports
import 'package:bricko_web/componets/products.dart';
import 'package:bricko_web/componets/header.dart';
import 'package:bricko_web/utils/app_data.dart';
import 'package:flutter_translate/flutter_translate.dart';

class SetsPage extends StatefulWidget {
  @override
  _SetsPageState createState() => _SetsPageState();
}

class _SetsPageState extends State<SetsPage> {
  @override
  Widget build(BuildContext context) {
    print("sets билдится");

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            // new SetsChips(),
            Header(),
            SizedBox(height: defaultPadding),
            setsWidget(),
          ],
        ),
      ),
    );
  }

  Widget setsWidget() {
    return new StreamBuilder(
        stream: FirebaseFirestore.instance.collection(setsRoot).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
            );
          } else {
            List<DocumentSnapshot> setsList = snapshot.data.docs;

            if (setsList.length == 0) {
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
                      translate("no_sets"),
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
                    Text(
                      "Наборы",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: DataTable(
                        horizontalMargin: 0,
                        columnSpacing: defaultPadding,
                        // dataRowHeight: 100,
                        columns: [
                          DataColumn(
                            label: Text("Идентификатор"),
                          ),
                          DataColumn(
                            label: Text("Название рус."),
                          ),
                          DataColumn(
                            label: Text("Название англ."),
                          ),
                          DataColumn(
                            label: Text(""),
                          ),
                          // DataColumn(
                          //   label: Text(""),
                          // ),
                        ],
                        rows: List.generate(
                          setsList.length,
                          (index) => singleSetsRow(
                              setsList[index].id.replaceAll(" ", ""),
                              setsList[index].data()[setTitleRU],
                              setsList[index].data()[setTitleEN]),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }
        });
  }

  DataRow singleSetsRow(String id, String titleRu, String titleEn) {
    return DataRow(
      cells: [
        DataCell(Text(id)),
        DataCell(Text(titleRu)),
        DataCell(Text(titleEn)),
        DataCell(Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                  label: Text("Изменить")),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
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
}

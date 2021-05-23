
import 'package:flutter/material.dart';
import 'package:bricko_web/main.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class ArchiveSizeText extends StatefulWidget {

  String pID;


  ArchiveSizeText(this.pID);

  @override
  State<StatefulWidget> createState() {
    return new _ArchiveSizeTextState(pID);
  }

}

class _ArchiveSizeTextState extends State<ArchiveSizeText> {

  String _sizeText = "-";


  _ArchiveSizeTextState(String pID) {
    fileStorage.getArchiveSize(pID).then((value) => {
      setState(() {
        print("SET STATE ARSIZE $value");
        _sizeText = value;
      })
    }
    );
  }


  @override
  Widget build(BuildContext context) {
    return new Text(
      _sizeText + " MB",
      style: new TextStyle(
          fontSize: 14.0),
    );
  }

}

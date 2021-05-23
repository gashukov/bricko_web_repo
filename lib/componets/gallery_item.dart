import 'package:bricko_web/main.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:bricko_web/utils/help_functions.dart';

class GalleryItem {
  GalleryItem({this.pID, this.isSvg = false, this.index});

  final String pID;
  final bool isSvg;
  final int index;
}

class GalleryExampleItemThumbnail extends StatelessWidget {
  const GalleryExampleItemThumbnail({Key key, this.galleryItem, this.onTap})
      : super(key: key);

  final GalleryItem galleryItem;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
//    return Container(
//        padding: const EdgeInsets.symmetric(horizontal: 5.0),
//        child: GestureDetector(
//          onTap: onTap,
//          child: Hero(
//            tag: galleryExampleItem.id,
//            child: Image.asset(galleryExampleItem.resource, height: 80.0),
//          ),
//        ));

    return GestureDetector(
      onTap: onTap,
      child: new Stack(
        alignment: Alignment.center,
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.only(left: 5.0, right: 5.0),
            height: 140,
            width: 249,
            child: Hero(
              child: Image(
                image: FirebaseImage(
                  'gs://bricko.appspot.com' +
                      getScreensPathByPID(galleryItem.pID) +
                      '0${galleryItem.index + 1}.jpg',
                  cacheRefreshStrategy: CacheRefreshStrategy.NEVER,
                  shouldCache: true,
                  firebaseApp: firebaseFirestore.app,
                ),
              ),
              tag: galleryItem.pID + "${galleryItem.index}",
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 5.0, right: 5.0),
            height: 140,
            width: 249,
            decoration: new BoxDecoration(color: Colors.grey.withAlpha(50)),
          ),
        ],
      ),
    );
  }
}

//List<GalleryItem> galleryItems = <GalleryItem>[
//  GalleryItem(
//    id: "tag1",
//    resource: "assets/gallery1.jpg",
//  ),
//  GalleryItem(id: "tag2", resource: "assets/firefox.svg", isSvg: true),
//  GalleryItem(
//    id: "tag3",
//    resource: "assets/gallery2.jpg",
//  ),
//  GalleryItem(
//    id: "tag4",
//    resource: "assets/gallery3.jpg",
//  ),
//];

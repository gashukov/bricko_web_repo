// import 'package:bricko_web/componets/cache_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:bricko_web/componets/cache_image.dart';
// import 'package:bricko_web/utils/help_functions.dart';
// import 'package:bricko_web/models/product_data.dart';
// import 'package:flutter_i18n/flutter_i18n.dart';
// import 'package:bricko_web/componets/buy_button.dart';
// import 'package:bricko_web/main.dart';
// import 'package:bricko_web/componets/archive_size_text.dart';
// import 'package:bricko_web/componets/gallery_item.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:bricko_web/utils/app_data.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:async';
// import 'package:bricko_web/state_widget.dart';

// class ProductDetails extends StatefulWidget {
//   ProductData productData;
//   ProductDetails(this.productData);

//   @override
//   _ProductDetailsState createState() => _ProductDetailsState(productData);
// }

// class _ProductDetailsState extends State<ProductDetails> {


//   String _price;

// //  final StreamController<String> _priceController = new StreamController<String>();


// //  @override
// //  void dispose() {
// //    super.dispose();
// //    _priceController.close();
// //  }

//   _ProductDetailsState(ProductData productData){
//   }

//   List<GalleryItem> galleryItems;

//   void open(BuildContext context, final int index) {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => GalleryPhotoViewWrapper(
//             minScale: PhotoViewComputedScale.contained,
//             maxScale: PhotoViewComputedScale.contained*3,
//             galleryItems: galleryItems,
//             backgroundDecoration: const BoxDecoration(
//               color: Colors.black,
//             ),
//             initialIndex: index,
//           ),
//         ));
//   }

//   @override
//   void initState() {

//     galleryItems = new List();
//     for(int i = 0; i < widget.productData.pScreensCount; i++) {
//       galleryItems.add(new GalleryItem(
//           index: i,
//           pID: widget.productData.pID
//       ));
//     }


//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: new AppBar(
//         iconTheme: new IconThemeData(color: Colors.white),
//         title: new Text(FlutterI18n.translate(context, "product_details")),
//         centerTitle: false,
//       ),

//       /// app bar
//       bottomNavigationBar: new BuyButtonBar(widget.productData),

// //      floatingActionButton: new Stack(
// //        alignment: Alignment.topLeft,
// //        children: <Widget>[
// //          new FloatingActionButton(
// //            onPressed: () {
// //              Navigator.of(context).push(new CupertinoPageRoute(
// //                  builder: (BuildContext context) => new GirliesCart()));
// //            },
// //            child: new Icon(Icons.shopping_cart),
// //          ),
// //          new CircleAvatar(
// //            radius: 10.0,
// //            backgroundColor: Colors.red,
// //            child: new Text(
// //              "0",
// //              style: new TextStyle(color: Colors.white, fontSize: 12.0),
// //            ),
// //          )
// //        ],
// //      ),


//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       body: new Stack(
//         alignment: Alignment.topCenter,
//         children: <Widget>[
// //          new Container(
// //            height: 300.0,
// //            decoration: new BoxDecoration(
// //                borderRadius: new BorderRadius.only(
// //                  bottomRight: new Radius.circular(100.0),
// //                  bottomLeft: new Radius.circular(100.0),
// //                ),
// ////                image: new DecorationImage(
// ////                    image: new NetworkImage(widget.itemImage),
// ////                    fit: BoxFit.fitHeight)
// //                image: new DecorationImage(
// //                    image: ,
// //                    fit: BoxFit.fitHeight)
// //            ),
// //
// //          ),
// //          new Container(
// //            height: 300.0,
// //            decoration: new BoxDecoration(
// //              color: Colors.grey.withAlpha(50),
// //              borderRadius: new BorderRadius.only(
// //                bottomRight: new Radius.circular(100.0),
// //                bottomLeft: new Radius.circular(100.0),
// //              ),
// //            ),
// //          ),
//           new SingleChildScrollView(
//             padding: const EdgeInsets.all(8.0),
//             child: new Column(
//               children: <Widget>[
//                 new Card(
//                   child: new Container(
//                     width: screenSize.width,
//                     margin: new EdgeInsets.only(left: 20.0, right: 20.0),
//                     child: Row(
//                       children: <Widget>[
//                         new Padding(
//                           padding: const EdgeInsets.all(4),
//                           /// product icon
//                           child: new CacheImage.firebase(
//                             placeholder: SizedBox(
//                                 height: 75,
//                                 width: 75,
//                                 child: Center(child: CircularProgressIndicator())),
//                             path: getIconPathByPID(widget.productData.pID),
// //                                fit: BoxFit.fitHeight,
//                             height: 75,
//                             width: 75,
//                             duration: Duration(milliseconds: 300),
//                           ),
//                         ),
// //                        new SizedBox(
// //                          width: 10,
// //                        ),
//                         Expanded(
//                           child: new Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               /// product title
//                               Padding(
//                                 padding: const EdgeInsets.all(4),
//                                 child: new Text(
//                                   widget.productData.getActualTitle(context),
//                                   style: new TextStyle(
//                                       fontSize: 18.0, fontWeight: FontWeight.normal),
//                                 ),
//                               ),
//                               /// product archive size
//                               Padding(
//                                   padding: const EdgeInsets.all(4),
//                                   child: new ArchiveSizeText(widget.productData.pID)
//                               ),
//                               /// product price

//                               Padding(
//                                 padding: const EdgeInsets.all(4.0),
//                                 child: new Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[

//                                     StreamBuilder(
//                                       stream: StateWidget.priceController.stream,
//                                       initialData: _price,
//                                       builder: (BuildContext context, AsyncSnapshot snapshot) {
//                                         _price = getPriceByPriceType(context, widget.productData);

//                                         return new Text(
//                                           _price == null ? FlutterI18n.translate(context, "loading_3dots") : _price,
//                                           style: new TextStyle(
//                                               fontSize: 16.0,
//                                               fontWeight: FontWeight.bold),
//                                         );
//                                       },
//                                     ),


//                                   ],
//                                 ),
//                               ),
//                               new SizedBox(
//                                 height: 10.0,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),



//                 /// images
//                 new Card(
//                   child: new Container(
//                     width: screenSize.width,
//                     height: 150.0,
//                     child: new ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: widget.productData.pScreensCount,
//                         itemBuilder: (context, index) {


//                           return GalleryExampleItemThumbnail(
//                             onTap: (){
//                               open(context, index);
//                             },
//                             galleryItem: galleryItems[index],
//                           );

//                         }),
//                   ),
//                 ),

//                 /// description
//                 new Card(
//                   child: new Container(
//                     width: screenSize.width,
//                     margin: new EdgeInsets.only(left: 20.0, right: 20.0),
//                     child: new Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.only(top: 10, bottom: 10),
//                           child: new Text(
//                             FlutterI18n.translate(context, "description"),
//                             style: new TextStyle(
//                                 fontSize: 18.0, fontWeight: FontWeight.w700),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 10.0),
//                           child: new Text(
//                             widget.productData.getActualDescription(context),
//                             style: new TextStyle(
//                                 fontSize: 14.0, fontWeight: FontWeight.w400),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 /// required sets, categories
//                 new Card(
//                   child: new Container(
//                     width: screenSize.width,
//                     margin: new EdgeInsets.only(left: 20.0, right: 20.0),
//                     child: new Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Padding(
//                           padding: EdgeInsets.only(top: 10, bottom: 10),
//                           child: new Text(
//                             FlutterI18n.translate(context, "required_sets"),
//                             style: new TextStyle(
//                                 fontSize: 18.0, fontWeight: FontWeight.w700),
//                           ),
//                         ),
//                         new SizedBox(
//                           height: 50.0,
//                           child: StreamBuilder(
//                               stream: Firestore.instance.collection(setsRoot).document(widget.productData.pSet).snapshots(),
//                               builder: (context, snapshot){
//                                 if(snapshot.hasData) {
//                                   return new ListView.builder(
//                                       scrollDirection: Axis.horizontal,
//                                       itemCount: 1,
//                                       itemBuilder: (context, index) {
//                                         return new Stack(
//                                           alignment: Alignment.center,
//                                           children: <Widget>[
//                                             Padding(
//                                               padding: const EdgeInsets.all(4.0),
//                                               child: new ChoiceChip(
//                                                 // ignore: unrelated_type_equality_checks
//                                                   label: new Text(FlutterI18n.currentLocale(context) == "ru" ? snapshot.data["title_ru"] : snapshot.data["title_en"]),
//                                                   selected: false),
//                                             )
//                                           ],
//                                         );
//                                       });
//                                 } else {
//                                   return new ListView.builder(
//                                       scrollDirection: Axis.horizontal,
//                                       itemCount: 1,
//                                       itemBuilder: (context, index) {
//                                         return new Stack(
//                                           alignment: Alignment.center,
//                                           children: <Widget>[
//                                             Padding(
//                                               padding: const EdgeInsets.all(4.0),
//                                               child: new ChoiceChip(
//                                                 // ignore: unrelated_type_equality_checks
//                                                   label: new Text(FlutterI18n.translate(context, "loading_3dots")),
//                                                   selected: false),
//                                             )
//                                           ],
//                                         );
//                                       });
//                                 }

//                               }
//                           ),



//                         ),
//                         /// categories
// //                        Padding(
// //                          padding: const EdgeInsets.only(top: 10, bottom: 10),
// //                          child: new Text(
// //                            FlutterI18n.translate(context, "categories"),
// //                            style: new TextStyle(
// //                                fontSize: 18.0, fontWeight: FontWeight.w700),
// //                          ),
// //                        ),
// //                        new SizedBox(
// //                          height: 50.0,
// //                          child: new ListView.builder(
// //                              scrollDirection: Axis.horizontal,
// //                              itemCount: widget.productData.pCategories.length,
// //                              itemBuilder: (context, index) {
// //                                return new Padding(
// //                                  padding: const EdgeInsets.all(4.0),
// //                                  child: new ChoiceChip(
// //                                      label: new Text(), ///todo
// //                                      selected: false),
// //                                );
// //                              }),
// //                        ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class GalleryPhotoViewWrapper extends StatefulWidget {
//   GalleryPhotoViewWrapper(
//       {this.loadingChild,
//         this.backgroundDecoration,
//         this.minScale,
//         this.maxScale,
//         this.initialIndex,
//         @required this.galleryItems})
//       : pageController = PageController(initialPage: initialIndex);

//   final Widget loadingChild;
//   final Decoration backgroundDecoration;
//   final dynamic minScale;
//   final dynamic maxScale;
//   final int initialIndex;
//   final PageController pageController;
//   final List<GalleryItem> galleryItems;

//   @override
//   State<StatefulWidget> createState() {
//     return _GalleryPhotoViewWrapperState();
//   }
// }

// class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
//   int currentIndex;
//   @override
//   void initState() {
//     currentIndex = widget.initialIndex;
//     super.initState();
//   }

//   void onPageChanged(int index) {
//     setState(() {
//       currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           decoration: widget.backgroundDecoration,
//           constraints: BoxConstraints.expand(
//             height: MediaQuery.of(context).size.height,
//           ),
//           child: Stack(
//             alignment: Alignment.bottomRight,
//             children: <Widget>[
//               PhotoViewGallery.builder(
//                 scrollPhysics: const BouncingScrollPhysics(),
//                 builder: _buildItem,
//                 itemCount: widget.galleryItems.length,
//                 loadingChild: widget.loadingChild,
//                 backgroundDecoration: widget.backgroundDecoration,
//                 pageController: widget.pageController,
//                 onPageChanged: onPageChanged,
//               ),
// //              Container(
// //                padding: const EdgeInsets.all(20.0),
// //                child: Text(
// //                  "Image ${currentIndex + 1}",
// //                  style: const TextStyle(
// //                      color: Colors.white, fontSize: 17.0, decoration: null),
// //                ),
// //              )
//             ],
//           )),
//     );
//   }

//   PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
//     final GalleryItem item = widget.galleryItems[index];
//     return PhotoViewGalleryPageOptions.customChild(
//       child: Center(
//         child: CacheImage.firebase(
//           placeholder: Center(child: CircularProgressIndicator()),
//           path: getScreensPathByPID(item.pID) + "0${item.index+1}.jpg", /// todo сделать норм
//         ),
//       ),
//       initialScale: PhotoViewComputedScale.contained,
//       minScale: widget.minScale,
//       maxScale: widget.maxScale,
// //      heroTag: item.pID + "${item.index}",
//       childSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
//     );
//   }
// }
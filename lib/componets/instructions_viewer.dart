// import 'package:flutter_i18n/flutter_i18n.dart';
// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:bricko_web/main.dart';
// import 'package:flutter/services.dart';
// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:bricko_web/utils/app_data.dart';

// InterstitialAd interPages;

// class InstructionsViewer extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() => _InstructionsViewerState(pID);


//   String pID;
//   static List<ImageProvider> pages;


//   InstructionsViewer(this.pID) {

//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//     SystemChrome.setEnabledSystemUIOverlays([]);




//   }




// }

// class _InstructionsViewerState extends State<InstructionsViewer> {

// //  List<File> pages;
//   PageController controller;

//   bool _hideStuff = false;
//   Timer _hideTimer;
//   Timer _pageAdsTimer;
//   bool allowToShowAds = true;
//   bool adsShowingNow = false;
//   double pageToSave;

//   _InstructionsViewerState(String pID){

//     if(InstructionsViewer.pages != null && InstructionsViewer.pages.length != 0) {
//       InstructionsViewer.pages.clear();
//     }

//     new Future.delayed(const Duration(seconds: 3), () {
//       InstructionsViewer.pages = fileStorage.getInstructionImages(pID);
//       if (mounted) {
//         setState(() {
//           _initSlider(pID);
//         });
//       }
//     });





//     if(!owned.contains(pID)) {
//       interPages = buildInterstitial()..load();
//     } else {
//       allowToShowAds = false;
//     }

//   }

//   _initSlider(String pID) {
//     print("round' 1");
//     controller = new PageController(initialPage: dataStorage.getPage(pID).round(), keepPage: false);
//     print("round' 2");
//     _sliderValue = (dataStorage.getPage(pID) + 1)?.clamp(1, InstructionsViewer.pages.length);
//     pageToSave = controller.initialPage.toDouble();
//     controller.addListener((){
//       setState(() {

//         _sliderValue = (controller.page + 1).clamp(1, InstructionsViewer.pages.length);
//         pageToSave = controller.page;
//         print("slider value $_sliderValue");
//         print("page to save $pageToSave");
//       });
//     });
//   }



//   InterstitialAd buildInterstitial() {

//     return new InterstitialAd(
//       // Replace the testAdUnitId with an ad unit id from the AdMob dash.
//       // https://developers.google.com/admob/android/test-ads
//       // https://developers.google.com/admob/ios/test-ads
//       adUnitId: "ca-app-pub-8405597663015191/4987306132",
// //      adUnitId: InterstitialAd.testAdUnitId, //todo заменить на рабочий айди
//       targetingInfo: targetingInfo,
//       listener: (MobileAdEvent event) {
//         print("InterstitialAd event is $event");
//         switch(event) {
//           case MobileAdEvent.loaded:

//             break;
//           case MobileAdEvent.failedToLoad:
//             tryToLoadAfterDelay();
//             break;
//           case MobileAdEvent.clicked:
//             break;
//           case MobileAdEvent.impression:
//             break;
//           case MobileAdEvent.opened:
//             _startAdsTimer();
//             break;
//           case MobileAdEvent.leftApplication:
//             break;
//           case MobileAdEvent.closed:
//             print("реклама закрыта, new page = $newPage, current page = ${controller.page}");
//             adsShowingNow = false;
//             changePage(newPage);
//             interPages = buildInterstitial()..load();
//             break;
//         }
//       },
//     );
//   }

//   Future tryToLoadAfterDelay() async {
//     return new Future.delayed(const Duration(seconds: 30), () => mounted ? (interPages = buildInterstitial()..load()) : "not mounted"); //todo будет загружать в портретной ориентации если за 30 сек выйти из просмотра инструкции
//   }



//   double _sliderValue = 1.0;

//   void _startHideTimer() {
//     _hideTimer = Timer(const Duration(seconds: 3), () {
//       setState(() {
//         _hideStuff = true;
//       });
//     });
//   }

//   void _cancelAndRestartTimer() {
//     _hideTimer?.cancel();

//     setState(() {
//       _hideStuff = false;

//       _startHideTimer();
//     });
//   }

//   void _startAdsTimer() {
//     allowToShowAds = false;
//     _pageAdsTimer = Timer(Duration(seconds: adsDelaySeconds), () {
//       allowToShowAds = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {

//     if (InstructionsViewer.pages == null || InstructionsViewer.pages.isEmpty) {
//       return Scaffold(
//         body: Center(child: new Text(FlutterI18n.translate(context, "loading_3dots"))),
//       );
//     } {
//       print("max = ${InstructionsViewer.pages.length.toDouble()}");
//       return Scaffold(
//         body: Stack(
//           children: <Widget>[
//             Container(
//                 child: PhotoViewGallery.builder(
//                   scrollPhysics: const NeverScrollableScrollPhysics(),
//                   pageController: controller,
//                   builder: (BuildContext context, int index) {
//                     return PhotoViewGalleryPageOptions.customChild(
//                       initialScale: 1.toDouble(),
//                       minScale: PhotoViewComputedScale.contained * 1,
//                       maxScale: PhotoViewComputedScale.contained * 3,
//                       basePosition: Alignment.center,
//                       child: Stack(children: <Widget>[
//                         Container(
//                           color: Colors.white,
//                           width: double.infinity,
//                           height: double.infinity,
//                         ),
//                         Image(image: InstructionsViewer.pages[index]),
//                         GestureDetector(
//                           onTap: () {
//                             _cancelAndRestartTimer();
//                           },
//                           child: Container(
//                             color: Colors.transparent,
//                           ),
//                         ),
//                       ]),
//                       childSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
// //              heroTag: galleryItems[index].id,
//                     );
//                   },
//                   itemCount: InstructionsViewer.pages.length,
// //          loadingChild: widget.loadingChild,
// //          backgroundDecoration: widget.backgroundDecoration,
// //          pageController: widget.pageController,
// //          onPageChanged: onPageChanged,
//                 )
//             ),




//             AnimatedOpacity(
//               opacity: _hideStuff ? 0.0 : 1.0,
//               duration: Duration(milliseconds: 300),
//               child: Stack(
//                 children: <Widget>[
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Container(
//                       height: 80,
//                       child: IgnorePointer(
//                         ignoring: _hideStuff,
//                         child: Slider(
//                           onChangeStart: (double value){
//                             _hideTimer?.cancel();
//                           },
//                           onChangeEnd: (double value){
//                             _startHideTimer();
//                           },
//                           onChanged: (double value) async {
//                             newPage = value;
//                             if(adsShowingNow) return;
//                             if(allowToShowAds) {
//                               print("реклама разрешена");
//                               interPages.isLoaded().then((loaded) {
//                                 if(loaded) {
//                                   print("реклама загружена");
//                                   adsShowingNow = true;
//                                   interPages.show();
//                                 } else {
//                                   print("реклама не загружена");
//                                   changePage(value);
//                                 }
//                               });
//                             } else {
//                               print("реклама не разрешена");
//                               changePage(value);
//                             }
//                           },
//                           value: _sliderValue,
//                           min: 1.0,
//                           max: InstructionsViewer.pages.length.toDouble(),
//                           divisions: InstructionsViewer.pages.length - 1,

//                         ),
//                       ),
//                     ),
//                   ),
//                   Align(
//                       alignment: Alignment.centerRight,
//                       child: GestureDetector(
//                         child: Container(
//                           height: MediaQuery.of(context).size.height / 2,
//                           width: 150,
//                           color: Colors.transparent,
//                           child: new Icon(Icons.keyboard_arrow_right, size: 48),
//                         ),
//                         onTap:() {
//                           if(allowToShowAds) {
//                             interPages.isLoaded().then((loaded) {
//                               if(loaded) {
//                                 newPage = controller.page+2;
//                                 interPages.show();
//                               } else {
//                                 controller.nextPage(duration: new Duration(milliseconds: 150), curve: Curves.linear);
//                               }
//                             });

//                           } else {
//                             controller.nextPage(duration: new Duration(milliseconds: 150), curve: Curves.linear);
//                           }
//                         } ,
//                       )
//                   ),

//                   Align(
//                       alignment: Alignment.centerLeft,
//                       child: GestureDetector(
//                         child: Container(
//                           height: MediaQuery.of(context).size.height / 2,
//                           width: 150,
//                           color: Colors.transparent,
//                           child: new Icon(Icons.keyboard_arrow_left, size: 48),
//                         ),
//                         onTap:() {
//                           if(allowToShowAds) {
//                             interPages.isLoaded().then((loaded) {
//                               if(loaded) {
//                                 newPage = controller.page;
//                                 interPages.show();
//                               } else {
//                                 controller.previousPage(duration: new Duration(milliseconds: 150), curve: Curves.linear);
//                               }
//                             });

//                           } else {
//                             controller.previousPage(duration: new Duration(milliseconds: 150), curve: Curves.linear);
//                           }
//                         } ,
//                       )
//                   ),
//                   Align(
//                     alignment: Alignment.bottomRight,
//                     child: Container(
//                       child: Text(
//                         ((pageToSave == null ? 0 : pageToSave.round()) + 1).toString(),
//                         style: TextStyle(
//                             color: Colors.black
//                         ),
//                       ),
//                       decoration: new BoxDecoration (
//                           borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
//                           color: Colors.white
//                       ),
//                       padding: EdgeInsets.all(4.0),
//                     ),
//                   ),

//                 ],
//               ),
//             ),

//           ],
//         ),
//       );
//     }

//   }

//   //переменная чтобы переключаться на новую страницу после закрытия рекламы
//   double newPage;

//   changePage(double value) {
//     int page = value.floor() - 1;
// //                      print("page = " + page.toString());
//     controller.jumpToPage(page);
// //                      print("page changed $value");
//   }


//   @override
//   void dispose() {
//     if (pageToSave != null) {
//       dataStorage.savePage(widget.pID, pageToSave);
//     }

//     InstructionsViewer.pages?.clear();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitDown,
//       DeviceOrientation.portraitUp,
//     ]);
//     SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
//     _hideTimer?.cancel();
//     _pageAdsTimer?.cancel();
//     interPages.dispose();
//     super.dispose();
//   }


// }

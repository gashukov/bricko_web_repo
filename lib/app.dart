import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'pages/home.dart';
import 'pages/login.dart';

class BricksBuildInstructionsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        onGenerateTitle: (BuildContext context) => translate('app_title'),
        theme: ThemeData(primaryColor: Colors.red.shade900),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => HomePage(),
          // '/login': (context) => LoginPage(),
        },
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:role_maister/config/app_router.dart';
import 'package:role_maister/config/firebase_logic.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'dart:ui' as ui;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseService().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.defaultLanguageCode = 'en'});

  final String defaultLanguageCode;

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  late Locale _locale;
  Locale get locale => _locale;

  @override
  void initState() {
    super.initState();
    _locale = Locale(widget.defaultLanguageCode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,

      locale: _locale,

        debugShowCheckedModeBanner: false,
        routerConfig: ApplicationRouter().router);
  }

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
}

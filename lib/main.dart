import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'home/ui/home.dart';
import 'login/ui/login.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static Map<int, Color> colorCodesPrimary = {
    50: const Color(0xffef7d00).withOpacity(.1),
    100: const Color(0xffef7d00).withOpacity(.2),
    200: const Color(0xffef7d00).withOpacity(.3),
    300: const Color(0xffef7d00).withOpacity(.4),
    400: const Color(0xffef7d00).withOpacity(.5),
    500: const Color(0xffef7d00).withOpacity(.6),
    600: const Color(0xffef7d00).withOpacity(.7),
    700: const Color(0xffef7d00).withOpacity(.8),
    800: const Color(0xffef7d00).withOpacity(.9),
    900: const Color(0xffef7d00).withOpacity(1),
  };

  static Map<int, Color> colorCodesSecundary = {
    50: const Color(0xff321E3E).withOpacity(.1),
    100: const Color(0xff321E3E).withOpacity(.2),
    200: const Color(0xff321E3E).withOpacity(.3),
    300: const Color(0xff321E3E).withOpacity(.4),
    400: const Color(0xff321E3E).withOpacity(.5),
    500: const Color(0xff321E3E).withOpacity(.6),
    600: const Color(0xff321E3E).withOpacity(.7),
    700: const Color(0xff321E3E).withOpacity(.8),
    800: const Color(0xff321E3E).withOpacity(.9),
    900: const Color(0xff321E3E).withOpacity(1),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyDenox',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('pt', 'BR'), // English
      ],
      theme: ThemeData(
        backgroundColor: const Color(0xffF0F1C6),
        primarySwatch: MaterialColor(0xff47633E, colorCodesPrimary),
      ),
      initialRoute: "/splash",
      navigatorKey: navigatorKey,
      routes: <String, WidgetBuilder>{
        "/splash": (BuildContext context) => new Splash(),
        "/": (BuildContext context) => const LoginPage(),
        "/home": (BuildContext context) => const Home(),
      },
    ),
  }
}

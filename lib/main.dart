import 'package:bankly/pages/loginpage.dart';
import 'package:bankly/pages/mainpage.dart';
import 'package:bankly/pages/transactionpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black, // status bar color
    statusBarBrightness: Brightness.dark, // status bar icons' color
    systemNavigationBarColor: Colors.black, // navigation bar color
    systemNavigationBarIconBrightness: Brightness.light, // navigation bar icons' color
  ));
    final Map<String, WidgetBuilder> routes = {
      '/login': (BuildContext context) => LoginPage(),
      '/home': (BuildContext context) => HomePage(),
      '/transaction': (BuildContext context) => TransactionPage(),
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'bankly',
      initialRoute: '/login',
      routes: routes,
    );
  }
}
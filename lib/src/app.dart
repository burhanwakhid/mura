import 'package:flutter/material.dart';
import 'package:Mura/src/screens/home/home.dart';
// import 'package:Mura/src/splashscreen.dart';

class App extends StatelessWidget {
  final Map<String, WidgetBuilder> routes = {
    '/home': (context) => Home(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mura',
      theme: ThemeData(
        primaryColor: const Color(0xFF01579B),
        accentColor: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      routes: routes,
      home: Home(),
    );
  }
}
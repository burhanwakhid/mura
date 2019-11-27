import 'package:flutter/material.dart';
import 'package:mura/src/screens/home/home.dart';
import 'package:mura/src/splashscreen.dart';

class App extends StatelessWidget {
  final Map<String, WidgetBuilder> routes = {
    '/home': (context) => Home(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fagos',
      theme: ThemeData(
        primaryColor: const Color(0xFF01579B),
        accentColor: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      routes: routes,
      home: Splashscreen(),
    );
  }
}
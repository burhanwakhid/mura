import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Mura/src/app.dart';

Future main() async{
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp]
  );

  runApp(App());
}
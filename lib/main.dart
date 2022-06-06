import 'package:flutter/material.dart';
import 'package:flutter_login/helpers/constant.dart';
import 'package:flutter_login/pages/splash.dart';
import 'package:flutter_login/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login",
      theme:
          ThemeData(backgroundColor: Warna.biru, brightness: Brightness.light),
      home: const Splash(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

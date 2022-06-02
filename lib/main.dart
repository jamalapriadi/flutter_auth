import 'package:flutter/material.dart';
import 'package:flutter_login/pages/splash.dart';
import 'package:flutter_login/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login",
      home: Splash(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

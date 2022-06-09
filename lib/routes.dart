import 'package:flutter/material.dart';
import 'package:hsp_gate/pages/auth/login.dart';
import 'package:hsp_gate/pages/auth/password.dart';
import 'package:hsp_gate/pages/auth/register.dart';
import 'package:hsp_gate/pages/home.dart';
import 'package:hsp_gate/pages/merchant/merchant.dart';
import 'package:hsp_gate/pages/splash.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //jika ingin mengirim argument
    //final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const Login());
      case "/splash":
        return MaterialPageRoute(builder: (_) => const Splash());
      case "/merchant":
        return MaterialPageRoute(builder: (_) => const Merchant());
      case "/login":
        return MaterialPageRoute(builder: (_) => const Login());
      case "/register":
        return MaterialPageRoute(builder: (_) => const Register());
      case "/password":
        return MaterialPageRoute(builder: (_) => const Password());
      case "/home":
        return MaterialPageRoute(builder: (_) => const Home());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("Page Not Found")),
      );
    });
  }
}

import 'package:flutter/material.dart';

class LogoWidget extends StatefulWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  State<LogoWidget> createState() => _LogoWidgetState();
}

class _LogoWidgetState extends State<LogoWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          height: 176,
          alignment: Alignment.center,
          child: Image.asset(
            "assets/img/logo.png",
            fit: BoxFit.contain,
            width: 250,
          ),
        ),
      ),
    );
  }
}

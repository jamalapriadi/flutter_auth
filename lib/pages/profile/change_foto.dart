import 'package:flutter/material.dart';
import 'package:flutter_login/helpers/constant.dart';

class ChangeFoto extends StatefulWidget {
  const ChangeFoto({Key? key}) : super(key: key);

  @override
  State<ChangeFoto> createState() => _ChangeFotoState();
}

class _ChangeFotoState extends State<ChangeFoto> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Warna.hijau,
          title: const Text("Update Foto"),
        ),
        body: const Text("Change Foto Body"),
      ),
    );
  }
}

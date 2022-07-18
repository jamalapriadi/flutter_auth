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
          child: GestureDetector(
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (_) => imageDialog("assets/img/logo.png"));
            },
            child: InteractiveViewer(
              panEnabled: false, // Set it to false
              boundaryMargin: EdgeInsets.all(100),
              minScale: 0.5,
              maxScale: 2,
              child: Image.asset(
                "assets/img/logo.png",
                fit: BoxFit.contain,
                width: 250,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imageDialog(path) {
    return Dialog(
      // backgroundColor: Colors.transparent,
      // elevation: 0,
      child: InteractiveViewer(
        panEnabled: false, // Set it to false
        boundaryMargin: EdgeInsets.all(100),
        minScale: 0.5,
        maxScale: 2,
        child: Image.asset(
          '$path',
          fit: BoxFit.contain,
          width: 250,
        ),
      ),
    );
  }
}

class ImageDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage(
                  "assets/img/logo.png",
                ),
                fit: BoxFit.cover)),
      ),
    );
  }
}

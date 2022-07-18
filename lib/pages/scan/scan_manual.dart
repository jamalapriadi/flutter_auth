import 'package:flutter/material.dart';
import 'package:hsp_gate/components/button_widget.dart';
import 'package:hsp_gate/components/text_form_field_widget.dart';
import 'package:hsp_gate/helpers/constant.dart';
import 'package:hsp_gate/pages/home.dart';
import 'package:hsp_gate/pages/scan/cek_scan.dart';
import 'package:intl/intl.dart';

class ScanManual extends StatefulWidget {
  const ScanManual({Key? key}) : super(key: key);

  @override
  State<ScanManual> createState() => _ScanManualState();
}

class _ScanManualState extends State<ScanManual> {
  final formState = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  final FocusNode _nameControllerFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Warna.hijau,
            title: const Text("Check-in Member Manual"),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formState,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    _buildCariText(),
                    SizedBox(
                      height: 20,
                    ),
                    _buildButtonCari(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildButtonKembali()
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget _buildCariText() {
    return TextFormFieldWdiget(
        hintText: "Input Data Member",
        focusNode: _nameControllerFocus,
        textInputType: TextInputType.text,
        controller: _nameController,
        functionValidate: commonValidation,
        parametersValidate: "Please enter Username/Email",
        onSubmitField: () {},
        onFieldTab: () {},
        prefixIcon: const Icon(Icons.person));
  }

  Widget _buildButtonCari() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: elevatedButton(
          onPresses: () {
            if (formState.currentState!.validate()) {
              // var q = _nameController.text.trim();
              var q = DateFormat("yyyy-MM-dd").format(DateTime.now()) +
                  "?member=" +
                  _nameController.text.trim().toString() +
                  "&source=apps";

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CekScan(
                            q: q,
                          )));
            } else {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('Warning'),
                        content:
                            const Text('Silahkan isi data terlebih dahulu'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ));
            }
          },
          text: "Cari Data",
          winWidth: 14,
          height: 21,
          textSize: 18,
          color: Warna.hijau),
    );
  }

  Widget _buildButtonKembali() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: elevatedButton(
          onPresses: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const Home()));
          },
          text: "Kembali",
          winWidth: 14,
          height: 21,
          textSize: 18,
          color: Warna.kuning),
    );
  }
}

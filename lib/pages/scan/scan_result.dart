import 'package:flutter/material.dart';
import 'package:flutter_login/components/button_widget.dart';
import 'package:flutter_login/components/logo.dart';
import 'package:flutter_login/helpers/constant.dart';

// ignore: must_be_immutable
class ScanResult extends StatefulWidget {
  String? q;
  ScanResult({Key? key, this.q}) : super(key: key);

  @override
  State<ScanResult> createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult> {
  final scaffoldState = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  final formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: scaffoldState,
          backgroundColor: Warna.putih,
          appBar: AppBar(title: const Text("Scan Result")),
          body: Stack(
            children: [
              SingleChildScrollView(
                  child: Form(
                key: formState,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 5, right: 5, top: 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: Container(
                              height: 126,
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/img/user_icon.png",
                                fit: BoxFit.contain,
                                width: 210,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                CircleAvatar(
                                  backgroundColor: Warna.putih,
                                  child: const Icon(Icons.check),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Check-in Berhasil",
                                )
                              ],
                            ),
                          ),
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(Warna.putih),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Warna.hijau),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(color: Warna.hijau)))),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Informasih Check-In",
                                style: TextStyle(
                                    color: Warna.hitam,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Divider(
                              color: Warna.biru,
                              thickness: 3,
                              indent: 10,
                              endIndent: 10,
                            ),
                            Container(
                                child: ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: [
                                ListTile(
                                  leading:
                                      const Icon(Icons.location_on_outlined),
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Lokasi Check-In",
                                        style: TextStyle(
                                            color: Warna.abu,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text("Rekreasi Sari Ater")
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Warna.abumuda,
                                  thickness: 2,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                ListTile(
                                  leading: const Icon(Icons.person_sharp),
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Nama Lengkap",
                                          style: TextStyle(
                                              color: Warna.abu,
                                              fontWeight: FontWeight.bold)),
                                      const Text("Nama Member")
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Warna.abumuda,
                                  thickness: 2,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                ListTile(
                                  leading: const Icon(Icons.calendar_month),
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Tanggal & Waktu Scan",
                                          style: TextStyle(
                                              color: Warna.abu,
                                              fontWeight: FontWeight.bold)),
                                      const Text("02 Juni 2022, 11:38 Wib")
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Warna.abumuda,
                                  thickness: 2,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                              ],
                            ))
                          ]),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: elevatedButton(
                            onPresses: () {},
                            text: "Confirm",
                            winWidth: 14,
                            height: 21,
                            textSize: 18,
                            color: Warna.hijau),
                      )
                    ],
                  ),
                ),
              ))
            ],
          )),
    );
  }
}

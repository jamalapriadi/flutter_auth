import 'package:flutter/material.dart';
import 'package:flutter_login/components/logo.dart';
import 'package:flutter_login/helpers/constant.dart';

class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LogoWidget(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "History",
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
            endIndent: 180,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Hari ini",
                    style: TextStyle(
                        color: Warna.abu, fontWeight: FontWeight.bold),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Text(
                    "10 Member",
                    style: TextStyle(
                        color: Warna.hijau,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  flex: 1,
                )
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        tileColor: Warna.abumuda,
                        textColor: Warna.hitam,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            const Text("Nama Member"),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: const [
                                Expanded(
                                  child: Text("1111 2222 3333 4444"),
                                  flex: 3,
                                ),
                                Expanded(
                                  child: Text("14.30 Wib"),
                                  flex: 1,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        tileColor: Warna.abumuda,
                        textColor: Warna.hitam,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Nama Member"),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: const [
                                Expanded(
                                  child: Text("1111 2222 3333 4444"),
                                  flex: 3,
                                ),
                                Expanded(
                                  child: Text("17.00 Wib"),
                                  flex: 1,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

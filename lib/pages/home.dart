import 'package:flutter/material.dart';
import 'package:hsp_gate/cubit/profile/profile_cubit.dart';
import 'package:hsp_gate/helpers/constant.dart';
import 'package:hsp_gate/pages/scan/scan_qr.dart';
import 'tabs/tab_setting.dart' as settingtab;
import 'tabs/tab_home.dart' as hometab;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ProfileCubit profileCubit = ProfileCubit();

  int selectedIndex = 0;
  String nama = "Home";

  final List<Widget> _children = [
    const hometab.TabHome(),
    const settingtab.TabSetting()
  ];

  @override
  void initState() {
    super.initState();
  }

  void updateTabSelection(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Apakah anda yakin ingin kembali?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    // Navigator.pushReplacementNamed(context, "/login");
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Warna.putih,
          appBar: AppBar(
            backgroundColor: Warna.putih,
            elevation: 0,
            // leading: Padding(
            //   padding: const EdgeInsets.all(10),
            //   child: Image.asset('assets/img/logo.png'),
            // ),
            toolbarHeight: 60,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Warna.abu,
                ),
                tooltip: 'Logout',
                onPressed: () {
                  logout();
                },
              ),
            ],
          ),
          body: _children[selectedIndex],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const ScanQR()));
            },
            tooltip: "Scan QR",
            backgroundColor: Warna.biru,
            child: Container(
              margin: const EdgeInsets.all(15),
              child: const Icon(Icons.qr_code_scanner),
            ),
            elevation: 4,
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              height: 60,
              margin: const EdgeInsets.only(left: 42, right: 42),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        updateTabSelection(0, "Home");
                      },
                      iconSize: 27.0,
                      icon: Icon(
                        Icons.home,
                        color: selectedIndex == 0
                            ? Warna.putih
                            : Colors.grey.shade400,
                      )),
                  IconButton(
                      onPressed: () {
                        updateTabSelection(1, "Settings");
                      },
                      iconSize: 27.0,
                      icon: Icon(
                        Icons.settings,
                        color: selectedIndex == 1
                            ? Warna.putih
                            : Colors.grey.shade400,
                      ))
                ],
              ),
            ),
            shape: const CircularNotchedRectangle(),
            color: Warna.hijau,
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
        child:
            Text("Batal".toUpperCase(), style: const TextStyle(fontSize: 14)),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Warna.abu),
            backgroundColor: MaterialStateProperty.all<Color>(Warna.putih),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Warna.putih)))),
        onPressed: () {
          Navigator.pop(context, 'OK');
        });
    Widget continueButton = ElevatedButton(
        child:
            Text("Keluar".toUpperCase(), style: const TextStyle(fontSize: 14)),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Warna.putih),
            backgroundColor: MaterialStateProperty.all<Color>(Warna.biru),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Warna.biru)))),
        onPressed: () async {
          profileCubit.logout();
          Navigator.pushReplacementNamed(context, "/login");

          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => const Login()));
        });
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Logout"),
      content: const Text("Apakah anda yakin ingi keluar?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void logout() async {
    showAlertDialog(context);
  }
}

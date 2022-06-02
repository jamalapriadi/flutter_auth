import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/cubit/profile/profile_cubit.dart';
import 'package:flutter_login/cubit/profile/profile_state.dart';
import 'package:flutter_login/helpers/constant.dart';
import 'package:flutter_login/pages/scan/scan_qr.dart';
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
    profileCubit.me();
    super.initState();
  }

  void updateTabSelection(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _buildAppBar() {
    return BlocProvider<ProfileCubit>(
      create: (context) => profileCubit,
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is GetProfileState) {
              return Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome",
                      style: TextStyle(fontSize: 14, color: Warna.abu),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      state.meResponse.name.toString(),
                      style: TextStyle(color: Warna.abu, fontSize: 18),
                    ),
                  )
                ],
              );
            } else if (state is LoadingGetProfileState) {
              return Container(
                color: Colors.black.withOpacity(0.2),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
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
            title: _buildAppBar(),
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

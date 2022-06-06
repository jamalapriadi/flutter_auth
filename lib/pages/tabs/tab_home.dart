import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/components/button_widget.dart';
import 'package:flutter_login/components/logo.dart';
import 'package:flutter_login/cubit/merchant/merchant_cubit.dart';
import 'package:flutter_login/cubit/merchant/merchant_state.dart';
import 'package:flutter_login/cubit/profile/profile_cubit.dart';
import 'package:flutter_login/cubit/profile/profile_state.dart';
import 'package:flutter_login/helpers/constant.dart';
import 'package:flutter_login/models/auth/me/me_response.dart';
import 'package:flutter_login/pages/scan/scan_result.dart';

class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  ProfileCubit profileCubit = ProfileCubit();
  MerchantCubit merchantCubit = MerchantCubit();
  MeResponse meResponse = MeResponse();

  @override
  void initState() {
    profileCubit.getMe();
    merchantCubit.getMerchantById();
    super.initState();
  }

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
            child: _buildNamaUser(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: _buildMerchant(),
          ),
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
            height: 10,
          ),
          _buildButtonRegister()
        ],
      ),
    );
  }

  Widget _buildButtonRegister() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: elevatedButton(
          onPresses: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ScanResult(
                          q: 'MC-05302',
                        )));
          },
          text: "Register",
          winWidth: 14,
          height: 21,
          textSize: 18,
          color: Warna.abu),
    );
  }

  Widget _buildNamaUser() {
    return BlocProvider<ProfileCubit>(
      create: (context) => profileCubit,
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is GetProfileState) {
              return Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "User",
                          style: TextStyle(fontSize: 18, color: Warna.abu),
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          " : " +
                              state.meResponse.name.toString().toUpperCase(),
                          style: TextStyle(
                              color: Warna.abu,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildMerchant() {
    return BlocProvider<MerchantCubit>(
      create: (context) => merchantCubit,
      child: BlocListener<MerchantCubit, MerchantState>(
        listener: (context, state) {},
        child: BlocBuilder<MerchantCubit, MerchantState>(
          builder: (context, state) {
            if (state is GetMerchantByIdState) {
              return Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Location : ",
                          style: TextStyle(fontSize: 18, color: Warna.abu),
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          " : " + state.merchantResponse.nama.toString(),
                          style: TextStyle(
                              color: Warna.abu,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

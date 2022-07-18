import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hsp_gate/components/button_widget.dart';
import 'package:hsp_gate/components/loading_widget.dart';
import 'package:hsp_gate/components/logo.dart';
import 'package:hsp_gate/cubit/checkin/checkin_cubit.dart';
import 'package:hsp_gate/cubit/merchant/merchant_cubit.dart';
import 'package:hsp_gate/cubit/merchant/merchant_state.dart';
import 'package:hsp_gate/cubit/profile/profile_cubit.dart';
import 'package:hsp_gate/cubit/profile/profile_state.dart';
import 'package:hsp_gate/helpers/constant.dart';
import 'package:hsp_gate/models/auth/me/me_response.dart';
import 'package:hsp_gate/pages/all_user_checkin.dart';
import 'package:hsp_gate/pages/scan/cek_scan.dart';
import 'package:hsp_gate/pages/scan/scan_manual.dart';

import '../../cubit/checkin/checkin_state.dart';

class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  ProfileCubit profileCubit = ProfileCubit();
  MerchantCubit merchantCubit = MerchantCubit();
  MeResponse meResponse = MeResponse();
  CheckinCubit checkinCubit = CheckinCubit();

  @override
  void initState() {
    profileCubit.getMe();
    merchantCubit.getMerchantById();
    checkinCubit.getCheckinToday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.putih,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LogoWidget(),
            Container(
              height: 90,
              color: Warna.putih,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: _buildNamaUser(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: _buildMerchant(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Container(
              height: 70,
              color: Warna.putih,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "History",
                            style: TextStyle(
                                color: Warna.hitam,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Warna.hijau,
                            child: TextButton.icon(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const ScanManual()));
                                },
                                icon: Icon(
                                  Icons.search,
                                  color: Warna.putih,
                                ),
                                label: Text(
                                  "Cari Member",
                                  style: TextStyle(color: Warna.putih),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Warna.biru,
                    thickness: 3,
                    indent: 10,
                    endIndent: 180,
                  ),
                ],
              ),
            ),
            // _buildButtonLogin(),
            _buildListCheckinToday()
          ],
        ),
      ),
    );
  }

  Widget _buildListCheckinToday() {
    return BlocProvider<CheckinCubit>(
      create: (context) => checkinCubit,
      child: BlocListener<CheckinCubit, CheckinState>(
        listener: (context, state) {},
        child: BlocBuilder<CheckinCubit, CheckinState>(
          builder: (context, state) {
            if (state is GetListCheckinState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    color: Warna.putih,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Hari ini",
                                  style: TextStyle(
                                      color: Warna.abu,
                                      fontWeight: FontWeight.bold),
                                ),
                                flex: 2,
                              ),
                              Expanded(
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AllUserCheckin(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      state.checkinList.length.toString() +
                                          " Member",
                                      style: TextStyle(
                                          color: Warna.hijau,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )),
                                flex: 1,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.checkinList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
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
                                    Text(state.checkinList[index].namaMember
                                        .toString()),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(state
                                              .checkinList[index].memberId
                                              .toString()),
                                          flex: 3,
                                        ),
                                        Expanded(
                                          child: Text(state
                                                  .checkinList[index].jam
                                                  .toString() +
                                              " Wib"),
                                          flex: 2,
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
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  )
                ],
              );
            } else if (state is LoadingCheckinState) {
              return const LoadingWidget();
            } else {
              return Container(
                color: Warna.putih,
              );
            }
          },
        ),
      ),
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

  Widget _buildButtonLogin() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: elevatedButton(
          onPresses: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CekScan(
                  q: '2022-06-21?member=PCD-00649&source=apps',
                ),
              ),
            );
          },
          text: "Cek Result",
          winWidth: 14,
          height: 21,
          textSize: 18,
          color: Warna.hijau),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hsp_gate/components/button_widget.dart';
import 'package:hsp_gate/components/loading_widget.dart';
import 'package:hsp_gate/cubit/checkin/checkin_cubit.dart';
import 'package:hsp_gate/cubit/checkin/checkin_state.dart';
import 'package:hsp_gate/cubit/member/member_cubit.dart';
import 'package:hsp_gate/cubit/member/member_state.dart';
import 'package:hsp_gate/cubit/merchant/merchant_cubit.dart';
import 'package:hsp_gate/cubit/merchant/merchant_state.dart';
import 'package:hsp_gate/helpers/constant.dart';
import 'package:hsp_gate/models/merchant/merchant_response.dart';
import 'package:hsp_gate/pages/home.dart';

import '../../models/checkin/checkin_request.dart';

class CekScan extends StatefulWidget {
  String? q;

  CekScan({Key? key, this.q}) : super(key: key);

  @override
  State<CekScan> createState() => _CekScanState();
}

class _CekScanState extends State<CekScan> {
  final merchantCubit = MerchantCubit();
  final memberCubit = MemberCubit();
  final checkinCubit = CheckinCubit();

  final formState = GlobalKey<FormState>();

  MerchantResponse merchant = MerchantResponse();

  String? merchantId;
  String? userId;
  String? memberId;

  @override
  void initState() {
    merchantCubit.getMerchantById();
    memberCubit.scanMember(widget.q.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider<MemberCubit>(
          create: (context) => memberCubit,
          child: BlocListener<MemberCubit, MemberState>(
            listener: (context, state) {
              if (state is GetMemberState) {
                userId = state.memberResponse.userId.toString();
                memberId = state.memberResponse.memberId.toString();
                // if (state.memberResponse.success == true) {
                //   if (state.memberResponse.active == 'Y') {
                //     _buildActiveMember(state);
                //   } else {
                //     _buildNonActiveMember(state);
                //   }
                // } else {
                //   _buildUserNotFound();
                // }
              } else if (state is LoadingGetMemberState) {
                const LoadingWidget();
              }
            },
            child: Stack(
              children: [
                BlocBuilder<MemberCubit, MemberState>(
                  builder: (context, state) {
                    if (state is GetScanMemberState) {
                      if (state.scanMemberResponse.success == true) {
                        userId = state.scanMemberResponse.userId.toString();
                        memberId = state.scanMemberResponse.memberId.toString();

                        if (state.scanMemberResponse.active == 'Y') {
                          return _buildActiveMember(state.scanMemberResponse);
                        } else {
                          return _buildNonActiveMember(
                              state.scanMemberResponse);
                        }
                      } else {
                        return _buildUserNotFound(state.scanMemberResponse);
                      }
                    } else if (state is LoadingGetMemberState) {
                      return const Center(
                        child: LoadingWidget(),
                      );
                    } else {
                      return const LoadingWidget();
                    }
                  },
                )
              ],
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
        child: Image.network(
          '$path',
          fit: BoxFit.contain,
          width: 250,
        ),
      ),
    );
  }

  Widget _buildActiveMember(member) {
    return BlocProvider<CheckinCubit>(
      create: (context) => checkinCubit,
      child: BlocListener<CheckinCubit, CheckinState>(
        listener: (context, state) {
          if (state is SuccessCheckinState) {
            if (state.resp.success == true) {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('Success'),
                        content: Text(state.resp.message.toString()),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, "/home");
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ));
            } else {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('Warning'),
                        content: Text(state.resp.message.toString()),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ));
            }
          }
        },
        child: Stack(
          alignment: Alignment.center,
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
                            child: GestureDetector(
                              onTap: () async {
                                await showDialog(
                                    context: context,
                                    builder: (_) => imageDialog(
                                        member.photoUrl.toString()));
                              },
                              child: InteractiveViewer(
                                panEnabled: false, // Set it to false
                                boundaryMargin: EdgeInsets.all(100),
                                minScale: 0.5,
                                maxScale: 2,
                                child: Image.network(
                                  member.photoUrl.toString(),
                                  fit: BoxFit.contain,
                                  width: 210,
                                ),
                              ),
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
                          ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: [
                              _buildMerchant(),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Nama Lengkap",
                                        style: TextStyle(
                                            color: Warna.abu,
                                            fontWeight: FontWeight.bold)),
                                    Text(member.fullName.toString())
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Tanggal & Waktu Scan",
                                        style: TextStyle(
                                            color: Warna.abu,
                                            fontWeight: FontWeight.bold)),
                                    Text(member.tanggal.toString() +
                                        ", " +
                                        member.jam.toString() +
                                        " WIB")
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
                          )
                        ]),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: elevatedButton(
                          onPresses: () {
                            CheckinRequest request = CheckinRequest(
                                user: userId.toString(),
                                member: memberId.toString(),
                                merchant: merchant.id.toString().toString());

                            checkinCubit.checkIn(request);
                          },
                          text: "Confirm",
                          winWidth: 14,
                          height: 21,
                          textSize: 18,
                          color: Warna.hijau),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: elevatedButton(
                          onPresses: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const Home()));
                          },
                          text: "Kembali",
                          winWidth: 14,
                          height: 21,
                          textSize: 18,
                          color: Warna.abu),
                    )
                  ],
                ),
              ),
            )),
            BlocBuilder<CheckinCubit, CheckinState>(builder: (context, state) {
              if (state is LoadingCheckinState) {
                return const LoadingWidget();
              } else {
                return Container();
              }
            })
          ],
        ),
      ),
    );
  }

  Widget _buildNonActiveMember(member) {
    return Stack(
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
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
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
                  height: 20,
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
                            child: const Icon(Icons.block),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Check-in Gagal",
                          )
                        ],
                      ),
                    ),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Warna.putih),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Warna.merah),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(color: Warna.merah)))),
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
                      ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.person_sharp),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Nama Lengkap",
                                    style: TextStyle(
                                        color: Warna.abu,
                                        fontWeight: FontWeight.bold)),
                                Text(member.fullName.toString())
                              ],
                            ),
                          ),
                          ListTile(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Masa Berlaku kartu anda habis pada tanggal : " +
                                      member.validUntil.toString(),
                                  style: TextStyle(
                                      color: Warna.abu,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "hubungi tim Membership Sari Ater untuk informasi lebh lanjut :081234678678",
                                    style: TextStyle(
                                        color: Warna.abu,
                                        fontWeight: FontWeight.bold)),
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
                      )
                    ]),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: elevatedButton(
                      onPresses: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Home()));
                      },
                      text: "Kembali",
                      winWidth: 14,
                      height: 21,
                      textSize: 18,
                      color: Warna.biru),
                )
              ],
            ),
          ),
        ))
      ],
    );
  }

  Widget _buildUserNotFound(result) {
    return Stack(
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
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
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
                  height: 20,
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
                            child: const Icon(Icons.block),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Check-in Gagal",
                          )
                        ],
                      ),
                    ),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Warna.putih),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Warna.merah),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(color: Warna.merah)))),
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
                      ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.person_sharp),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(result.message.toString(),
                                    style: TextStyle(
                                        color: Warna.abu,
                                        fontWeight: FontWeight.bold)),
                                // Text(
                                //     "Member ID yang anda cari tidak ditemukan")
                                // Text(result.message.toString())
                              ],
                            ),
                          ),
                          ListTile(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "hubungi tim Membership Sari Ater untuk informasi lebh lanjut :081234678678",
                                    style: TextStyle(
                                        color: Warna.abu,
                                        fontWeight: FontWeight.bold)),
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
                      )
                    ]),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: elevatedButton(
                      onPresses: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Home()));
                      },
                      text: "Kembali",
                      winWidth: 14,
                      height: 21,
                      textSize: 18,
                      color: Warna.biru),
                )
              ],
            ),
          ),
        ))
      ],
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
              merchant = state.merchantResponse;
              merchantId = state.merchantResponse.id.toString();

              return ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Lokasi Check-in",
                        style: TextStyle(
                            color: Warna.abu, fontWeight: FontWeight.bold)),
                    Text(state.merchantResponse.nama.toString())
                  ],
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
}

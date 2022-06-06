import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/components/button_widget.dart';
import 'package:flutter_login/components/loading_widget.dart';
import 'package:flutter_login/components/logo.dart';
import 'package:flutter_login/cubit/merchant/merchant_cubit.dart';
import 'package:flutter_login/cubit/merchant/merchant_state.dart';
import 'package:flutter_login/cubit/profile/profile_cubit.dart';
import 'package:flutter_login/cubit/profile/profile_state.dart';
import 'package:flutter_login/helpers/constant.dart';
import 'package:flutter_login/models/auth/me/me_response.dart';
import 'package:flutter_login/pages/home.dart';
import 'package:flutter_login/repositories/merchant_repository.dart';

class Merchant extends StatefulWidget {
  const Merchant({Key? key}) : super(key: key);

  @override
  State<Merchant> createState() => _MerchantState();
}

class _MerchantState extends State<Merchant> {
  MerchantCubit merchantCubit = MerchantCubit();
  ProfileCubit profileCubit = ProfileCubit();

  final formStateMerchant = GlobalKey<FormState>();
  String? merId;

  @override
  void initState() {
    profileCubit.me();
    merchantCubit.getMerchant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: BlocProvider<MerchantCubit>(
        create: (context) => merchantCubit,
        child: BlocListener<MerchantCubit, MerchantState>(
          listener: (context, state) {
            if (state is SuccessSetMerchantState) {
              Navigator.pushReplacementNamed(context, "/home");
            }
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: formStateMerchant,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const LogoWidget(),
                            const SizedBox(
                              height: 40,
                            ),
                            Text(
                              "Pilih Lokasi",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Warna.abu),
                            ),
                            _buildSelectMerchant(),
                            const SizedBox(
                              height: 30,
                            ),
                            _buildButtonSetMerchant()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              BlocBuilder<MerchantCubit, MerchantState>(
                  builder: (context, state) {
                if (state is LoadingSetMerchantState) {
                  return const LoadingWidget();
                } else {
                  return Container();
                }
              })
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildSelectMerchant() {
    return BlocProvider<MerchantCubit>(
      create: (context) => merchantCubit,
      child: BlocListener<MerchantCubit, MerchantState>(
        listener: (context, state) {
          if (state is GetMerchantState) {}
        },
        child: BlocBuilder<MerchantCubit, MerchantState>(
          builder: (context, state) {
            if (state is GetMerchantState) {
              return DropdownButtonFormField(
                validator: (value) {
                  if (value == null) {
                    return "Pilih Lokasi Terlebih dahulu";
                  }

                  return null;
                },
                hint: const Text("Plih Lokasi"),
                value: merId,
                onChanged: (String? newValue) {
                  setState(() {
                    merId = newValue;
                  });
                },
                items: state.merchantResponse.map((item) {
                  return DropdownMenuItem(
                    child: Text(item.nama.toString()),
                    value: item.id.toString(),
                  );
                }).toList(),
              );
            } else if (state is LoadingMerchantState) {
              return const LoadingWidget();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildButtonSetMerchant() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: elevatedButton(
          onPresses: () {
            if (formStateMerchant.currentState!.validate()) {
              merchantCubit.setMerchant(merId.toString());
            } else {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('Warning'),
                        content:
                            const Text('Silahkan Pilih Lokasi Terlebih dahulu'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ));
            }
            // merchantCubit.setMerchant(merId.toString());
            // merchantRepository.setMerchant(merId.toString());
            // Navigator.pushReplacementNamed(context, "/home");
          },
          text: "Set Lokasi",
          winWidth: 14,
          height: 21,
          textSize: 18,
          color: Warna.hijau),
    );
  }
}

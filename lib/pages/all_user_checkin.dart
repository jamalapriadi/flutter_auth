import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/loading_widget.dart';
import '../cubit/checkin/checkin_cubit.dart';
import '../cubit/checkin/checkin_state.dart';
import '../helpers/constant.dart';

class AllUserCheckin extends StatefulWidget {
  const AllUserCheckin({Key? key}) : super(key: key);

  @override
  State<AllUserCheckin> createState() => _AllUserCheckinState();
}

class _AllUserCheckinState extends State<AllUserCheckin> {
  final scaffoldState = GlobalKey<FormState>();
  CheckinCubit checkinCubit = CheckinCubit();

  @override
  void initState() {
    checkinCubit.getCheckinToday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldState,
        backgroundColor: Warna.putih,
        appBar: AppBar(
          backgroundColor: Warna.hijau,
          title: const Text("List Checkin Hari ini"),
        ),
        body: SingleChildScrollView(
          child: _buildListCheckinToday(),
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
                                    onPressed: () {},
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
}

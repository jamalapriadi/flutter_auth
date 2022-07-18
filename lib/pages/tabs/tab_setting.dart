import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hsp_gate/components/loading_widget.dart';
import 'package:hsp_gate/cubit/profile/profile_cubit.dart';
import 'package:hsp_gate/cubit/profile/profile_state.dart';
import 'package:hsp_gate/models/auth/me/me_response.dart';
import 'package:hsp_gate/pages/profile/change_password.dart';
import 'package:hsp_gate/pages/profile/change_profile.dart';
import 'package:hsp_gate/pages/regulation.dart';

import '../../helpers/constant.dart';

class TabSetting extends StatefulWidget {
  const TabSetting({Key? key}) : super(key: key);

  // TabSetting({Key? key, this.me}) : super(key: key);

  @override
  State<TabSetting> createState() => _TabSettingState();
}

class _TabSettingState extends State<TabSetting> {
  final profileCubit = ProfileCubit();
  MeResponse? me;

  @override
  void initState() {
    profileCubit.getMe();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            BlocProvider<ProfileCubit>(
              create: (context) => profileCubit,
              child: BlocListener<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is GetProfileState) {}
                },
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is GetProfileState) {
                      me = state.meResponse;

                      return Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [Warna.hijau, Warna.hijau])),
                              child: SizedBox(
                                width: double.infinity,
                                height: 250.0,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () async {
                                          await showDialog(
                                              context: context,
                                              builder: (_) => imageDialog(state
                                                  .meResponse.profilePictureUrl
                                                  .toString()));
                                        },
                                        child: InteractiveViewer(
                                          panEnabled: false, // Set it to false
                                          boundaryMargin: EdgeInsets.all(100),
                                          minScale: 0.5,
                                          maxScale: 2,
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              state.meResponse.profilePictureUrl
                                                  .toString(),
                                            ),
                                            radius: 50.0,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        state.meResponse.name.toString(),
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          color: Warna.putih,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        state.meResponse.email.toString(),
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Warna.putih,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    } else if (state is LoadingGetProfileState) {
                      return const LoadingWidget();
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Card(
                child: ListTile(
                  trailing: const Icon(Icons.arrow_right),
                  title: const Text("REGULATION"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Regulation(),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Card(
                child: ListTile(
                  trailing: const Icon(Icons.arrow_right),
                  title: const Text("CHANGE PROFILE "),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeProfile(
                          me: me,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20, right: 20),
            //   child: Card(
            //     child: ListTile(
            //       trailing: const Icon(Icons.arrow_right),
            //       title: const Text("CHANGE PHOTO "),
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => const ChangeFoto(),
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 10.0,
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Card(
                child: ListTile(
                  trailing: const Icon(Icons.arrow_right),
                  title: const Text("CHANGE PASSWORD "),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangePassword(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

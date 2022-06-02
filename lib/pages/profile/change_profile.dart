import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/components/button_widget.dart';
import 'package:flutter_login/components/text_form_default_widget.dart';
import 'package:flutter_login/components/text_form_field_widget.dart';
import 'package:flutter_login/cubit/profile/profile_cubit.dart';
import 'package:flutter_login/cubit/profile/profile_state.dart';
import 'package:flutter_login/helpers/constant.dart';
import 'package:flutter_login/models/auth/me/me_response.dart';
import 'package:flutter_login/models/auth/me/profile/update_profile_request.dart';

import '../../components/loading_widget.dart';

// ignore: must_be_immutable
class ChangeProfile extends StatefulWidget {
  MeResponse? me;

  ChangeProfile({Key? key, this.me}) : super(key: key);

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  final formState = GlobalKey<FormState>();
  ProfileCubit profileCubit = ProfileCubit();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();

  @override
  void initState() {
    _email.text = widget.me!.email.toString();
    _name.text = widget.me!.name.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Warna.hijau,
          title: const Text("Update Profile"),
        ),
        body: BlocProvider<ProfileCubit>(
          create: (context) => profileCubit,
          child: BlocListener<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is DoUpdateProfileState) {
                  if (state.resp.success == true) {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Success'),
                              content: Text(state.resp.message.toString()),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
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
                children: [
                  Form(
                    key: formState,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            _buildEmail(),
                            const SizedBox(
                              height: 10,
                            ),
                            _buildName(),
                            const SizedBox(
                              height: 10,
                            ),
                            _buildButtonChangeProfile()
                          ],
                        ),
                      ),
                    ),
                  ),
                  BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                    if (state is LoadingUpdateProfileState) {
                      return const LoadingWidget();
                    } else {
                      return Container();
                    }
                  })
                ],
              )),
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return TextFormFieldWdiget(
        hintText: "Email",
        focusNode: _emailFocus,
        textInputType: TextInputType.text,
        controller: _email,
        functionValidate: commonValidation,
        parametersValidate: "Please enter Email",
        onSubmitField: () {
          changeFocus(context, _emailFocus, _nameFocus);
        },
        onFieldTab: () {},
        prefixIcon: const Icon(Icons.email));
  }

  Widget _buildName() {
    return TextFormDefaultWidget(
      hintText: "Name",
      focusNode: _nameFocus,
      textInputType: TextInputType.text,
      controller: _name,
      functionValidate: commonValidation,
      parametersValidate: "Please enter Full Name",
      onSubmitField: () {},
      onFieldTab: () {},
    );
  }

  Widget _buildButtonChangeProfile() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: elevatedButton(
          onPresses: () {
            if (formState.currentState!.validate()) {
              var email = _email.text.trim();
              var name = _name.text.trim();

              UpdateProfileRequest request =
                  UpdateProfileRequest(name: name, email: email);

              profileCubit.updateProfile(request);
            }
          },
          text: "Update Profile",
          winWidth: 14,
          height: 21,
          textSize: 18,
          color: Warna.hijau),
    );
  }
}

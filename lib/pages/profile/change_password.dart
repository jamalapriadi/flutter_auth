import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/components/button_widget.dart';
import 'package:flutter_login/components/loading_widget.dart';
import 'package:flutter_login/components/password_form_field_widget.dart';
import 'package:flutter_login/cubit/profile/profile_cubit.dart';
import 'package:flutter_login/cubit/profile/profile_state.dart';
import 'package:flutter_login/helpers/constant.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final formState = GlobalKey<FormState>();
  ProfileCubit profileCubit = ProfileCubit();

  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordConfirm = TextEditingController();

  final FocusNode _oldPasswordFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _passwordConfirmFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Warna.hijau,
            title: const Text("Update Password"),
          ),
          body: BlocProvider<ProfileCubit>(
            create: (context) => profileCubit,
            child: BlocListener<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is DoUpdatePasswordState) {
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
                              height: 20,
                            ),
                            _buildOldPassword(),
                            const SizedBox(height: 10),
                            _buildPassword(),
                            const SizedBox(
                              height: 10,
                            ),
                            _buildPasswordConfirm(),
                            const SizedBox(
                              height: 10,
                            ),
                            _buildButtonUpdateProfile()
                          ],
                        ),
                      ),
                    ),
                  ),
                  BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                    if (state is LoadingUpdatePasswordState) {
                      return const LoadingWidget();
                    } else {
                      return Container();
                    }
                  })
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildOldPassword() {
    return PasswordFormFieldWdiget(
        obscureText: true,
        hintText: "Old Password",
        focusNode: _oldPasswordFocus,
        textInputType: TextInputType.text,
        controller: _oldPassword,
        functionValidate: commonValidationPassword,
        parametersValidate: "Please enter Old Password",
        onSubmitField: () {},
        onFieldTab: () {},
        prefixIcon: const Icon(Icons.remove_red_eye));
  }

  Widget _buildPassword() {
    return PasswordFormFieldWdiget(
        obscureText: true,
        hintText: "New Password",
        focusNode: _passwordFocus,
        textInputType: TextInputType.text,
        controller: _password,
        functionValidate: commonValidationPassword,
        parametersValidate: "Please enter New Password",
        onSubmitField: () {},
        onFieldTab: () {},
        prefixIcon: const Icon(Icons.remove_red_eye));
  }

  Widget _buildPasswordConfirm() {
    return PasswordFormFieldWdiget(
        obscureText: true,
        hintText: "Password Confirmation",
        focusNode: _passwordConfirmFocus,
        textInputType: TextInputType.text,
        controller: _passwordConfirm,
        functionValidate: commonValidationPassword,
        parametersValidate: "Please enter Password Confirmation",
        onSubmitField: () {},
        onFieldTab: () {},
        prefixIcon: const Icon(Icons.remove_red_eye));
  }

  Widget _buildButtonUpdateProfile() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: elevatedButton(
          onPresses: () {
            if (formState.currentState!.validate()) {
              var current = _oldPassword.text.trim();
              var password = _password.text.trim();
              var passwordConfirm = _passwordConfirm.text.trim();

              profileCubit.updatePassword(current, password, passwordConfirm);
            }
          },
          text: "Change Password",
          winWidth: 14,
          height: 21,
          textSize: 18,
          color: Warna.hijau),
    );
  }
}

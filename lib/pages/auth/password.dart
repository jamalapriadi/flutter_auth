import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/components/button_widget.dart';
import 'package:flutter_login/components/loading_widget.dart';
import 'package:flutter_login/components/logo.dart';
import 'package:flutter_login/components/text_form_field_widget.dart';
import 'package:flutter_login/cubit/auth/auth_cubit.dart';
import 'package:flutter_login/cubit/auth/auth_state.dart';
import 'package:flutter_login/helpers/constant.dart';

class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final scaffoldState = GlobalKey<FormState>();
  final formState = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final FocusNode _nameControllerFocus = FocusNode();

  final authCubit = AuthCubit();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldState,
        resizeToAvoidBottomInset: false,
        backgroundColor: Warna.putih,
        body: BlocProvider<AuthCubit>(
          create: (context) => authCubit,
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is FailedPasswordState) {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Warning'),
                          content: Text(state.errorMessage),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ));
              } else if (state is SuccessPasswordState) {}
            },
            child: Stack(
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
                            height: 48,
                          ),
                          const LogoWidget(),
                          const SizedBox(
                            height: 20,
                          ),
                          _buildUsername(),
                          const SizedBox(
                            height: 10,
                          ),
                          _builSendLinkButton(),
                          const SizedBox(
                            height: 10,
                          ),
                          _builBackToLogin()
                        ],
                      ),
                    ),
                  ),
                ),
                BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                  if (state is InitialLoadingUpdatePasswordState) {
                    return const LoadingWidget();
                  } else {
                    return Container();
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUsername() {
    return TextFormFieldWdiget(
        hintText: "Username/Email",
        focusNode: _nameControllerFocus,
        textInputType: TextInputType.text,
        controller: _nameController,
        functionValidate: commonValidation,
        parametersValidate: "Please enter Username/Email",
        onSubmitField: () {},
        onFieldTab: () {},
        prefixIcon: const Icon(Icons.insert_emoticon));
  }

  Widget _builBackToLogin() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: elevatedButton(
          onPresses: () {
            Navigator.pushReplacementNamed(context, "/login");
          },
          text: "Login",
          winWidth: 14,
          height: 21,
          textSize: 18,
          color: Warna.abu),
    );
  }

  Widget _builSendLinkButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: elevatedButton(
          onPresses: () {},
          text: "Send Link",
          winWidth: 14,
          height: 21,
          textSize: 18,
          color: Warna.hijau),
    );
  }

  hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}

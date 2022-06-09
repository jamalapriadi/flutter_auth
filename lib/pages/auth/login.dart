import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/components/button_widget.dart';
import 'package:flutter_login/components/loading_widget.dart';
import 'package:flutter_login/components/logo.dart';
import 'package:flutter_login/components/password_form_field_widget.dart';
import 'package:flutter_login/components/text_form_field_widget.dart';
import 'package:flutter_login/cubit/auth/auth_cubit.dart';
import 'package:flutter_login/cubit/auth/auth_state.dart';
import 'package:flutter_login/helpers/constant.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final formState = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  final FocusNode _nameControllerFocus = FocusNode();
  final FocusNode _passwordControllerFocus = FocusNode();
  final authCubit = AuthCubit();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _formKey,
        resizeToAvoidBottomInset: false,
        body: BlocProvider<AuthCubit>(
          create: (context) => authCubit,
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is FailureAuthState) {
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
              } else if (state is SuccessAuthState) {
                if (state.loginResponse.success == true) {
                  // Navigator.pushReplacementNamed(context, "/home");
                  Navigator.pushReplacementNamed(context, "/merchant");
                } else {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Warning'),
                            content:
                                Text(state.loginResponse.message.toString()),
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
              children: <Widget>[
                SingleChildScrollView(
                  child: Form(
                    key: formState,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 60.0,
                          ),
                          const Center(
                            child: LogoWidget(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          _buildUsername(),
                          const SizedBox(
                            height: 10,
                          ),
                          _buildPassword(),
                          // _buildForgotPassword(),
                          const SizedBox(
                            height: 10,
                          ),
                          _buildButtonLogin(),
                          const SizedBox(height: 10),
                          // _buildButtonRegister()
                        ],
                      ),
                    ),
                  ),
                ),
                BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                  if (state is LoadingAuthState) {
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
        onSubmitField: () {
          changeFocus(context, _nameControllerFocus, _passwordControllerFocus);
        },
        onFieldTab: () {},
        prefixIcon: const Icon(Icons.insert_emoticon));
  }

  Widget _buildPassword() {
    return PasswordFormFieldWdiget(
        obscureText: true,
        hintText: "Password",
        focusNode: _passwordControllerFocus,
        textInputType: TextInputType.text,
        controller: _passwordController,
        functionValidate: commonValidationPassword,
        parametersValidate: "Please enter Password",
        onSubmitField: () {},
        onFieldTab: () {},
        prefixIcon: const Icon(Icons.remove_red_eye));
  }

  Widget _buildButtonLogin() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: elevatedButton(
          onPresses: () {
            if (formState.currentState!.validate()) {
              var username = _nameController.text.trim();
              var password = _passwordController.text.trim();

              authCubit.login(username, password);
            } else {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('Warning'),
                        content: const Text(
                            'Silahkan isi username dan password anda'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ));
            }
          },
          text: "Login",
          winWidth: 14,
          height: 21,
          textSize: 18,
          color: Warna.hijau),
    );
  }

  Widget _buildButtonRegister() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: elevatedButton(
          onPresses: () {
            Navigator.pushReplacementNamed(context, "/register");
          },
          text: "Register",
          winWidth: 14,
          height: 21,
          textSize: 18,
          color: Warna.abu),
    );
  }

  Widget _buildForgotPassword() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text(
          "Forgot Passoword?",
          style: TextStyle(color: Warna.hitam),
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/password");
        },
      ),
    );
  }

  hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}

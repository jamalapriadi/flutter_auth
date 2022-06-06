import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/components/button_widget.dart';
import 'package:flutter_login/components/loading_widget.dart';
import 'package:flutter_login/components/logo.dart';
import 'package:flutter_login/components/password_form_field_widget.dart';
import 'package:flutter_login/components/text_form_default_widget.dart';
import 'package:flutter_login/components/text_form_field_widget.dart';
import 'package:flutter_login/cubit/auth/auth_cubit.dart';
import 'package:flutter_login/cubit/auth/auth_state.dart';
import 'package:flutter_login/helpers/constant.dart';
import 'package:flutter_login/models/auth/register/register_request.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final scaffoldState = GlobalKey<FormState>();
  final formState = GlobalKey<FormState>();

  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordConfirm = TextEditingController();

  final authCubit = AuthCubit();

  final FocusNode _fullnameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _passwordConfirmFocus = FocusNode();

  void _clearText() {
    _fullname.clear();
    _email.clear();
    _phone.clear();
    _password.clear();
    _passwordConfirm.clear();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Apakah anda yakin ingin kembali?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/login");
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
            child: Scaffold(
          key: scaffoldState,
          resizeToAvoidBottomInset: false,
          backgroundColor: Warna.putih,
          body: BlocProvider<AuthCubit>(
            create: (context) => authCubit,
            child: BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is FailureRegisterState) {
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
                } else if (state is SuccessRegisterState) {
                  _clearText();
                }
              },
              child: Stack(
                children: [
                  SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: ListView(
                      padding: const EdgeInsets.all(14),
                      shrinkWrap: true,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      children: [
                        Form(
                          key: formState,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const Center(
                                  child: LogoWidget(),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                _buildFullnameWidget(),
                                const SizedBox(
                                  height: 10,
                                ),
                                _buildEmailWidget(),
                                const SizedBox(
                                  height: 10,
                                ),
                                _buildPhoneWidget(),
                                const SizedBox(
                                  height: 10,
                                ),
                                _buildPassword(),
                                const SizedBox(
                                  height: 10,
                                ),
                                _buildPasswordConfirm(),
                                const SizedBox(
                                  height: 10,
                                ),
                                _builRegisterButton(),
                                const SizedBox(
                                  height: 10,
                                ),
                                _builBackToLogin()
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                    if (state is LoadingRegisterState) {
                      return const LoadingWidget();
                    } else {
                      return Container();
                    }
                  })
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  Widget _buildFullnameWidget() {
    return TextFormDefaultWidget(
      hintText: "Fullname",
      focusNode: _fullnameFocus,
      textInputType: TextInputType.text,
      controller: _fullname,
      functionValidate: commonValidation,
      parametersValidate: "Please enter Full Name",
      onSubmitField: () {
        changeFocusDefault(context, _fullnameFocus, _emailFocus);
      },
      onFieldTab: () {},
    );
  }

  Widget _buildEmailWidget() {
    return TextFormFieldWdiget(
        hintText: "Email",
        focusNode: _emailFocus,
        textInputType: TextInputType.text,
        controller: _email,
        functionValidate: commonValidation,
        parametersValidate: "Please enter Email",
        onSubmitField: () {
          changeFocus(context, _emailFocus, _phoneFocus);
        },
        onFieldTab: () {},
        prefixIcon: const Icon(Icons.email));
  }

  Widget _buildPhoneWidget() {
    return TextFormFieldWdiget(
        hintText: "Phone",
        focusNode: _phoneFocus,
        textInputType: TextInputType.text,
        controller: _phone,
        functionValidate: commonValidation,
        parametersValidate: "Please enter Phone",
        onSubmitField: () {
          changeFocus(context, _phoneFocus, _passwordFocus);
        },
        onFieldTab: () {},
        prefixIcon: const Icon(Icons.phone));
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

  Widget _buildPassword() {
    return PasswordFormFieldWdiget(
        obscureText: true,
        hintText: "Password",
        focusNode: _passwordFocus,
        textInputType: TextInputType.text,
        controller: _password,
        functionValidate: commonValidationPassword,
        parametersValidate: "Please enter Password",
        onSubmitField: () {
          changeFocus(context, _passwordFocus, _passwordConfirmFocus);
        },
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

  Widget _builRegisterButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: elevatedButton(
          onPresses: () {
            if (formState.currentState!.validate()) {
              RegisterRequest request = RegisterRequest(
                  fullname: _fullname.text.trim(),
                  email: _email.text.trim(),
                  phone: _phone.text.trim(),
                  password: _password.text.trim(),
                  passwordConfirmation: _passwordConfirm.text.trim());

              authCubit.register(request);
            }
          },
          text: "Register",
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

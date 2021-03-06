import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hsp_gate/components/loading_widget.dart';
import 'package:hsp_gate/cubit/auth/auth_cubit.dart';
import 'package:hsp_gate/cubit/auth/auth_state.dart';
import 'package:hsp_gate/pages/auth/login.dart';
import 'package:hsp_gate/pages/merchant/merchant.dart';

class CheckAuth extends StatefulWidget {
  const CheckAuth({Key? key}) : super(key: key);

  @override
  State<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  final authCubit = AuthCubit();

  @override
  void initState() {
    authCubit.checkIfLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => authCubit,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is FailureAuthState) {
          } else if (state is SuccessAuthState) {}
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is FailureAuthState) {
              return const Login();
            } else if (state is CekLoginStatusState) {
              return const LoadingWidget();
            } else if (state is AvailableAuthState) {
              // return const Home();
              return const Merchant();
            } else {
              return const Login();
            }
          },
        ),
      ),
    );
  }
}

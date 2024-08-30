import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p88_admin/app/bloc/bloc/auth_bloc.dart';
import 'package:p88_admin/util/extension.dart';

class loginController {
  final formLoginKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordHide = true;

  AuthBloc? _authBloc;
  void init(AuthBloc bloc) {
    _authBloc = bloc;
  }

  void onDispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  void onLoginPressed() {
    debugPrint('email: ${emailController.text}, password: ${passwordController.text}');
    _authBloc?.add(AuthLoginEvent(email: emailController.text, password: passwordController.text));
    if(formLoginKey.currentState!.validate()) {
      // _authBloc?.add(AuthLoginEvent(email: emailController.text, password: passwordController.text));
    }
  }

  void onTapOutside(PointerDownEvent event) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
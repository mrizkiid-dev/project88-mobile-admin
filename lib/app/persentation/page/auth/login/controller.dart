import 'package:flutter/material.dart';
import 'package:p88_admin/app/bloc/bloc/auth_bloc.dart';
import 'package:p88_admin/util/color_item.dart';

class LoginController {
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

  SnackBar errorSnackbar(String message) {
    return SnackBar(
      backgroundColor: Colors.red,
      content: Text(message, style: TextStyle(color: ColorItem.primary),),
    );
  }

  // final snackBar = SnackBar(
  //   backgroundColor: Colors.red,
  //   content: Text('Yay! A SnackBar!', style: TextStyle(color: ColorItem.primary),),
  // );
}
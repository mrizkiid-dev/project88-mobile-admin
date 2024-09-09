import 'package:flutter/material.dart';
import 'package:p88_admin/app/bloc/auth_bloc/auth_bloc.dart';
import 'package:p88_admin/core/controller.dart';

class LoginController extends Controller {
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
    if(formLoginKey.currentState!.validate()) {
      _authBloc?.add(AuthLoginEvent(email: emailController.text, password: passwordController.text));
    }
  }

  void onTapOutside(PointerDownEvent event) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
  
  @override
  void didChangeDependencies(BuildContext context) {
  }
  
  @override
  void dispose() {
    _authBloc = null;
    emailController.dispose();
    passwordController.dispose();
  }
  
  @override
  void initState() {
  }

}
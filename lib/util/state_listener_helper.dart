import 'package:flutter/material.dart';
import 'package:p88_admin/app/bloc/auth_bloc/auth_bloc.dart';
import 'package:p88_admin/app/persentation/widget/loading/loading_overlay.dart';
import 'package:p88_admin/app/persentation/widget/snackbar.dart';

class StateListenerHelper {
  StateListenerHelper();

  void loading<T>(Object currentState, BuildContext context) {
    if(currentState is T) {
      LoadingOverlay().show(context);
    } 

    if(currentState is! T) {
      LoadingOverlay().hide();
    }
  }

  void showAuthErrorSnackbar(Object currentState, BuildContext context) {
    if(currentState is ErrorAuthState) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBarError().run(currentState.message));
    }
  }
}
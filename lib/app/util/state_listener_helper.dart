import 'package:flutter/material.dart';
import 'package:p88_admin/app/bloc/auth_bloc/auth_bloc.dart';
import 'package:p88_admin/app/persentation/widget/loading/loading_overlay.dart';
import 'package:p88_admin/app/persentation/widget/snackbar/error_snackbar.dart';
import 'package:p88_admin/core/di/get_it.dart';

class StateListenerHelper {
  StateListenerHelper();

  final scaffoldMessengerKey = injector<GlobalKey<ScaffoldMessengerState>>();

  void loading<T>(Object currentState, BuildContext context) {
    if(currentState is T) {
      LoadingOverlay().show(context);
    } 

    if(currentState is! T) {
      LoadingOverlay().hide();
    }
  }

  void showAuthErrorSnackbar<T>(Object currentState) {
    if(currentState is ErrorAuthState) {
      ShowErrorSnackbar().run(message: currentState.message);
    }
  }
}
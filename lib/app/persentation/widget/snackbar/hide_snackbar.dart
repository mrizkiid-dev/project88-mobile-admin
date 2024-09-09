import 'package:flutter/material.dart';
import 'package:p88_admin/core/di/get_it.dart';

class HideSnackbar {
  HideSnackbar();

  final scaffoldMessengerKey = injector<GlobalKey<ScaffoldMessengerState>>();

  void run() {
    scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
  }

}
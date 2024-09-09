import 'package:flutter/material.dart';
import 'package:p88_admin/core/di/get_it.dart';

class ShowSnackbar {
  ShowSnackbar();

  final scaffoldMessengerKey = injector<GlobalKey<ScaffoldMessengerState>>();

  void run({required SnackBar snackBar}) {
    scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

}
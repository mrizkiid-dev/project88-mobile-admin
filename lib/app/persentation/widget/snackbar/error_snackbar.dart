import 'package:flutter/material.dart';
import 'package:p88_admin/app/persentation/widget/snackbar/show_snackbar.dart';
import 'package:p88_admin/app/util/color_item.dart';


class ShowErrorSnackbar {
  ShowErrorSnackbar();
  
  void run({required String message}) {
    final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(message, style: TextStyle(color: ColorItem.primary),),
        behavior: SnackBarBehavior.floating,
    );

    ShowSnackbar().run(snackBar: snackBar);
  }
}
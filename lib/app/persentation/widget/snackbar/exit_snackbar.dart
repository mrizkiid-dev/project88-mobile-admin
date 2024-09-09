import 'package:flutter/material.dart';
import 'package:p88_admin/app/persentation/widget/snackbar/show_snackbar.dart';
import 'package:p88_admin/app/util/color_item.dart';

class ExitSnackbar {
  void run() {
    final snackBar = SnackBar(
      duration: Duration(milliseconds: 300),
      backgroundColor: ColorItem.tertiary,
      content: Text(
        'press again to exit',
        style: TextStyle(color: ColorItem.primary),
      ),
      behavior: SnackBarBehavior.floating,
    );

    ShowSnackbar().run(snackBar: snackBar);
  }
}

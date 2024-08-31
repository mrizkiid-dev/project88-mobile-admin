import 'package:flutter/material.dart';
import 'package:p88_admin/util/color_item.dart';


class SnackBarError {
  SnackBar run(String message) {
    return SnackBar(
      backgroundColor: Colors.red,
      content: Text(message, style: TextStyle(color: ColorItem.primary),),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:p88_admin/app/util/color_item.dart';

class MainLoading extends StatelessWidget {
  const MainLoading ({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorItem.bgBlackOpacity),
      child: Center(
          child: SizedBox(
        child: CircularProgressIndicator(
          strokeWidth: 8,
          color: ColorItem.tertiary,
        ),
        width: 90,
        height: 90,
      )),
    );
  }
}
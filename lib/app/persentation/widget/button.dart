import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p88_admin/app/util/color_item.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onPressed,
    required this.title,
    double width = 180,
    double height = 40,
  }): _width=width, _height=height;

  final VoidCallback onPressed;
  final String title;
  
  final double _width;
  final double _height; 

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size(_width, _height)),
        backgroundColor: WidgetStatePropertyAll(ColorItem.tertiary),
        elevation: WidgetStatePropertyAll(0),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7)),
          )
        ),
        foregroundColor: WidgetStatePropertyAll(ColorItem.primary),
        textStyle: WidgetStatePropertyAll(TextStyle(color: ColorItem.primary))
      ),
      child: Container(
        child: Text(
              title, 
              style: TextStyle(
                color: ColorItem.primary,
                fontSize: 17.sp,
                letterSpacing: 1.5.sp
              ),
              textAlign: TextAlign.center,
            ),
      ));
  }
}
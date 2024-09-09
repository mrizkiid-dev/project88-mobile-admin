import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p88_admin/app/util/color_item.dart';
import 'package:p88_admin/app/util/extension.dart';

class TextFormFieldPassword extends StatefulWidget {
  const TextFormFieldPassword(
      {super.key, required this.onTapOutside, required this.textController});

  final Function(PointerDownEvent event) onTapOutside;
  final TextEditingController textController;

  String? validator(String? value) {
    if (value != null && value.isEmpty) {
      return 'password can not be null';
    }
    if (value != null && value.isNotEmpty && !value.isValidPassword()) {
      return 'password is not valid';
    }
    return null;
  }

  @override
  State<TextFormFieldPassword> createState() => _TextFormFieldPasswordState();
}

class _TextFormFieldPasswordState extends State<TextFormFieldPassword> {
  bool isPasswordHide = true;
  void onTapHidePassword() {
    setState(() {
      isPasswordHide = !isPasswordHide;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('password rendered');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: Text(
            'Password',
            style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
          ),
        ),
        TextFormField(
            obscureText: isPasswordHide,
            onTapOutside: widget.onTapOutside,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                fillColor: ColorItem.tertiary,
                hintText: '*******',
                suffixIcon: IconButton(
                  icon: Icon(
                      isPasswordHide ? Icons.visibility_off : Icons.visibility),
                  onPressed: onTapHidePassword,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(7.r),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(7.r),
                ),
              ),
            controller: widget.textController,
            validator: widget.validator),
      ],
    );
  }
}
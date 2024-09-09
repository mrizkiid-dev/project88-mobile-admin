import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p88_admin/app/util/color_item.dart';
import 'package:p88_admin/app/util/extension.dart';

class TextFormFiledEmail extends StatefulWidget {
  const TextFormFiledEmail(
      {super.key, required this.onTapOutside, required this.textController});

  final Function(PointerDownEvent event) onTapOutside;
  final TextEditingController textController;

  String? validator(String? value) {
    if (value != null && value.isEmpty) {
      return 'email can not be null';
    }
    if (value != null && value.isNotEmpty && !value.isValidEmail()) {
      return 'email is not valid';
    }
    return null;
  }

  @override
  State<TextFormFiledEmail> createState() => _TextFormFiledEmailState();
}

class _TextFormFiledEmailState extends State<TextFormFiledEmail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: Text(
            'Email',
            style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
          ),
        ),
        TextFormField(
            onTapOutside: widget.onTapOutside,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              fillColor: ColorItem.tertiary,
              hintText: 'example@email.com',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1),
                borderRadius: BorderRadius.circular(7),
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
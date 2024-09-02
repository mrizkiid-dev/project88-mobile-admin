import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p88_admin/app/bloc/auth_bloc/auth_bloc.dart';
import 'package:p88_admin/app/persentation/widget/auth/auth_container_background.dart';
import 'package:p88_admin/app/persentation/widget/button.dart';
import 'package:p88_admin/util/color_item.dart';
import 'package:p88_admin/app/persentation/page/auth/login/controller.dart';
import 'package:p88_admin/util/extension.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LoginController();
    return AuthContainerBackground(
      widget: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginBox(loginController: controller),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginBox extends StatefulWidget {
  const LoginBox({
    super.key,
    required this.loginController
  });

  final LoginController loginController;

  @override
  State<LoginBox> createState() => _LoginBoxState();
}

class _LoginBoxState extends State<LoginBox> {
  @override
  Widget build(BuildContext context) {
    LoginController controller = widget.loginController;
    final authBloc = BlocProvider.of<AuthBloc>(context);
    controller.init(authBloc);
    return Form(
      key: controller.formLoginKey,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
        decoration: BoxDecoration(
            color: ColorItem.primary,
            border: Border.all(color: ColorItem.tertiary, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(20.r))),
        constraints: BoxConstraints(minWidth: double.infinity),
        child: Column(
          children: [
            Text(
              'Sign In To Project88',
              style: TextStyle(
                  fontSize: 33.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 60.h,
            ),
            TextFormFiledEmail(
                onTapOutside: controller.onTapOutside,
                textController: controller.emailController),
            SizedBox(
              height: 10,
            ),
            TextFormFieldPassword(
                onTapOutside: controller.onTapOutside,
                textController: controller.passwordController),
            SizedBox(
              height: 40,
            ),
            Button(
              onPressed: controller.onLoginPressed,
              title: 'login',
            )
          ],
        ),
      ),
    );
  }
}

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
                )),
            controller: widget.textController,
            validator: widget.validator),
      ],
    );
  }
}

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

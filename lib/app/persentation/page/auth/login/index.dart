import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p88_admin/app/bloc/auth_bloc/auth_bloc.dart';
import 'package:p88_admin/app/persentation/widget/auth/auth_container_background.dart';
import 'package:p88_admin/app/persentation/widget/auth/textformfield_email.dart';
import 'package:p88_admin/app/persentation/widget/auth/textformfield_password.dart';
import 'package:p88_admin/app/persentation/widget/button.dart';
import 'package:p88_admin/app/util/color_item.dart';
import 'package:p88_admin/app/persentation/page/auth/login/controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    
    super.dispose();
  }

  
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

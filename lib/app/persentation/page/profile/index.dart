import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p88_admin/app/bloc/auth_bloc/auth_bloc.dart';
import 'package:p88_admin/app/persentation/widget/appbar.dart';
import 'package:p88_admin/app/persentation/widget/auth/auth_container.dart';
import 'package:p88_admin/app/persentation/widget/button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => HomePageState();
}

class HomePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return AuthContainer(
      appBar: AppBarDefault(title: 'profile',),
      body: Center(
        child: Button(onPressed: (){
          authBloc.add(AuthLogoutEvent());
        }, title: 'sign out'),
      )
    );
  }
}
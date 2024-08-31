import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p88_admin/app/bloc/bloc/auth_bloc.dart';
import 'package:p88_admin/app/persentation/widget/auth/auth_container.dart';
import 'package:p88_admin/util/color_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AuthContainer(
      widget: 
        Container(
          decoration: BoxDecoration(
            color: ColorItem.primary
          ),
          child: ElevatedButton(onPressed: () => {
            context.read<AuthBloc>().add(AuthLogoutEvent())
          }, child: Text('logout')),
        ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: ColorItem.secondary,
  //       centerTitle: true,
  //       title: const Text('Home Page'),
  //     ),
  //     body: SizedBox.expand(
  //       child: Container(
  //         decoration: BoxDecoration(
  //           color: ColorItem.primary
  //         ),
  //         child: ElevatedButton(onPressed: () => {
  //           context.read<AuthBloc>().add(AuthLogoutEvent())
  //         }, child: Text('logout')),
  //       ),
  //     ),
  //   );
  // }
}
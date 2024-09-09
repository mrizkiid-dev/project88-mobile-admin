import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p88_admin/app/persentation/page/root_order/bloc/order_bloc.dart';
import 'package:p88_admin/app/persentation/page/root_order/controller.dart';
import 'package:p88_admin/app/persentation/widget/snackbar/error_snackbar.dart';
import 'package:p88_admin/app/util/state_listener_helper.dart';
import 'package:p88_admin/core/di/get_it.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => HomePageState();
}

class HomePageState extends State<OrderPage> {
  final controller = injector<OrderController>();

  @override
  void initState() {
    controller.initState();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    controller.didChangeDependencies(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        StateListenerHelper().loading<LoadingOrderState>(state, context);
        if(state is ErrorOrderState) {
          ShowErrorSnackbar().run(message: state.message);
        }
      },
      child: Center(
        child: Text('order'),
      ))
    );
  }
}
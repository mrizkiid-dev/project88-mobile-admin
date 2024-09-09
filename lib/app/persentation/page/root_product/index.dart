import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p88_admin/app/persentation/page/root_order/controller.dart';
import 'package:p88_admin/app/persentation/page/root_product/bloc/product_bloc.dart';
import 'package:p88_admin/app/persentation/page/root_product/controller.dart';
import 'package:p88_admin/app/persentation/widget/snackbar/error_snackbar.dart';
import 'package:p88_admin/app/util/state_listener_helper.dart';
import 'package:p88_admin/core/di/get_it.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => HomePageState();
}

class HomePageState extends State<ProductPage> {
  final controller = injector<ProductController>();

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
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          StateListenerHelper().loading<LoadingProductState>(state, context);
          if(state is ErrorProductState) {
            ShowErrorSnackbar().run(message: state.message);
          }
        },
        child: Center(child: Text('product'),),
      ),
    );
  }
}
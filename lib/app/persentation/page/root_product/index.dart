import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p88_admin/app/persentation/page/root_order/controller.dart';
import 'package:p88_admin/app/persentation/page/root_product/bloc/product_bloc.dart';
import 'package:p88_admin/app/persentation/page/root_product/controller.dart';
import 'package:p88_admin/app/persentation/widget/error/error_try_again.dart';
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
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          StateListenerHelper().loading<LoadingProductState>(state, context);
          if(state is ErrorProductState) {
            ShowErrorSnackbar().run(message: state.message);
          }
        },
        buildWhen: (previous, current) {
          if(current is ErrorProductState || current is SuccessProductState) {
            return true;
          }

          return false;
        },
        builder: (context, state) {
          if(state is ErrorProductState) {
            return ErrorTryAgain(onPressed: (){});
          }

          if(state is SuccessProductState) {
            return _mainPage();
          }

          return SizedBox();
        },
      ),
    );
  }

  Widget _mainPage() {
    return Center(
      child: Text('product')
    );
  }
}
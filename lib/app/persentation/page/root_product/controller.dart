import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p88_admin/app/persentation/page/root_product/bloc/product_bloc.dart';
import 'package:p88_admin/app/persentation/widget/loading/loading_overlay.dart';
import 'package:p88_admin/app/persentation/widget/snackbar/hide_snackbar.dart';
import 'package:p88_admin/core/controller.dart';

class ProductController extends Controller {
  ProductBloc? _productBloc;

  @override
  void didChangeDependencies(BuildContext context) {
    _productBloc = BlocProvider.of<ProductBloc>(context);
    _productBloc?.add(InitialProductEvent());
  }

  @override
  void dispose() {
    // HideSnackbar().run();
    _productBloc = null;
  }

  @override
  void initState() {
    
  }
  
}
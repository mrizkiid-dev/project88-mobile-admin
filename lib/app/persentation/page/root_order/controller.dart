import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p88_admin/app/persentation/page/root_order/bloc/order_bloc.dart';
import 'package:p88_admin/app/persentation/widget/loading/loading_overlay.dart';
import 'package:p88_admin/app/persentation/widget/snackbar/hide_snackbar.dart';
import 'package:p88_admin/core/controller.dart';

class OrderController extends Controller {

  OrderBloc? _orderBloc;

  @override
  void didChangeDependencies(BuildContext context) {
    _orderBloc = BlocProvider.of<OrderBloc>(context);
    _orderBloc?.add(InitialOrderEvent());
  }

  @override
  void dispose() {
    debugPrint('order dispose');
    _orderBloc = null;
  }

  @override
  void initState() {
    
  }
  
}
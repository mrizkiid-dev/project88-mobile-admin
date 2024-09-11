import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p88_admin/app/persentation/page/root_home/bloc/homepage_bloc.dart';
import 'package:p88_admin/app/persentation/widget/snackbar/hide_snackbar.dart';
import 'package:p88_admin/core/controller.dart';

class HomeController extends Controller {

  HomeBloc? _homeBloc;

  @override
  void didChangeDependencies(BuildContext context) {
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    
  }

  @override
  void dispose() {
    _homeBloc = null;
  }

  @override
  void initState() {
  }

  onTryAgain() {
    _homeBloc?.add(InitiaHomeEvent());
  }
  
  
}
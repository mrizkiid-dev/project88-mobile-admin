import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p88_admin/app/bloc/auth_bloc/auth_bloc.dart';
import 'package:p88_admin/app/persentation/page/root/bloc/root_bloc.dart';
import 'package:p88_admin/app/persentation/widget/auth/auth_container.dart';
import 'package:p88_admin/app/persentation/widget/grid_background.dart';
import 'package:p88_admin/app/persentation/widget/loading/loading_main.dart';
import 'package:p88_admin/app/persentation/widget/loading/loading_overlay.dart';
import 'package:p88_admin/app/persentation/widget/snackbar/error_snackbar.dart';
import 'package:p88_admin/app/util/state_listener_helper.dart';

class AuthContainerBackground extends StatefulWidget {
  const AuthContainerBackground({
    super.key,
    required Widget widget
  }):_widget=widget;

  final Widget _widget;

  @override
  State<AuthContainerBackground> createState() => _AuthContainerState();
}

class _AuthContainerState extends State<AuthContainerBackground> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: SizedBox.expand(
        child: CustomPaint(
          painter: CustomGrid(),
          child: BlocListener<AuthBloc, AuthState>(
            bloc: bloc,
            listenWhen: (previous, current) {
              return true;
            },
            listener: (context, state) {
              StateListenerHelper().showAuthErrorSnackbar(state);
              StateListenerHelper().loading<AuthLoadingState>(state, context);
            },
            child: widget._widget
          ),
          
        ),
        
      ),
    );
  }
}

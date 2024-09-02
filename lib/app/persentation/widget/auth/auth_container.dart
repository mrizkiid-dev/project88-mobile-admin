import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p88_admin/app/bloc/app_bloc/app_bloc.dart';
import 'package:p88_admin/app/bloc/auth_bloc/auth_bloc.dart';
import 'package:p88_admin/app/persentation/page/homepage/bloc/home_page_bloc.dart';
import 'package:p88_admin/app/persentation/widget/loading/loading_main.dart';
import 'package:p88_admin/app/persentation/widget/loading/loading_overlay.dart';
import 'package:p88_admin/app/persentation/widget/snackbar.dart';
import 'package:p88_admin/util/state_listener_helper.dart';

class AuthContainer extends StatefulWidget {
  const AuthContainer({
    super.key,
    required Widget widget,
    this.appBar
  }):_widget=widget;

  final Widget _widget;
  final PreferredSizeWidget? appBar;

  @override
  State<AuthContainer> createState() => _AuthContainerState();
}

class _AuthContainerState extends State<AuthContainer> {
  @override
  Widget build(BuildContext context) {
    Widget renderWidget = widget._widget;
    final bloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: widget.appBar,
      body: BlocListener<AuthBloc, AuthState>(
        bloc: bloc,
        listenWhen: (previous, current) {
          if(previous != current) {
            return true;
          }
          return false;
        },
        listener: (context, state) {
          StateListenerHelper().showAuthErrorSnackbar(state, context);
          StateListenerHelper().loading<AuthLoadingState>(state, context);
        },
        child: renderWidget 
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p88_admin/app/bloc/auth_bloc/auth_bloc.dart';
import 'package:p88_admin/app/persentation/widget/snackbar/exit_snackbar.dart';
import 'package:p88_admin/app/util/color_item.dart';
import 'package:p88_admin/app/util/state_listener_helper.dart';

class AuthContainer extends StatefulWidget {
  const AuthContainer({
    super.key,
    required Widget body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.appBar
  }):_widget=body;

  final Widget _widget;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

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
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButton: widget.floatingActionButton,
      bottomNavigationBar: widget.bottomNavigationBar,
      body: BlocListener<AuthBloc, AuthState>(
        bloc: bloc,
        listenWhen: (previous, current) {
          if(previous != current) {
            return true;
          }
          return false;
        },
        listener: (context, state) {
          StateListenerHelper().showAuthErrorSnackbar(state);
          StateListenerHelper().loading<AuthLoadingState>(state, context);
        },
        child: renderWidget 
      ),
    );
  }
}
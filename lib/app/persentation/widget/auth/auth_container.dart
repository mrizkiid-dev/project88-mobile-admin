import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p88_admin/app/bloc/bloc/auth_bloc.dart';
import 'package:p88_admin/app/persentation/widget/loading/loading_main.dart';
import 'package:p88_admin/app/persentation/widget/snackbar.dart';

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
    final authBloc = RepositoryProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: widget.appBar,
      body: BlocListener(
        bloc: authBloc,
        listenWhen: (previous, current) {
          if(previous != current) {
            return true;
          }
          return false;
        },
        listener: (context, state) {
          if(state is ErrorAuthState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBarError().run(state.message));
          }
        },
        child: Stack(
          children: [
            renderWidget,
            BlocBuilder<AuthBloc, AuthState>(
              bloc: authBloc,
              builder: (context, state) {
                if(state is AuthLoadingState) 
                  return const MainLoading();

                return SizedBox();
              },
            )
          ],
        ), 
      ),
    );
  }
}
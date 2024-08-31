import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p88_admin/app/bloc/bloc/auth_bloc.dart';
import 'package:p88_admin/app/persentation/widget/grid_background.dart';
import 'package:p88_admin/app/persentation/widget/loading/loading_main.dart';
import 'package:p88_admin/app/persentation/widget/snackbar.dart';

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
    final authBloc = RepositoryProvider.of<AuthBloc>(context);
    return Scaffold(
      body: SizedBox.expand(
        child: CustomPaint(
          painter: CustomGrid(),
          child: BlocListener(
            bloc: authBloc,
            listenWhen: (previous, current) {
              if(current is ErrorAuthState) {
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
                widget._widget,
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
          
        ),
        
      ),
    );
  }
}

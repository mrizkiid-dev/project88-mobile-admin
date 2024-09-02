import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:p88_admin/app/bloc/auth_bloc/auth_bloc.dart';
import 'package:p88_admin/app/persentation/page/auth/login/index.dart';
import 'package:p88_admin/app/persentation/page/errors/in_progress.dart';
import 'package:p88_admin/app/persentation/page/homepage/index.dart';
import 'package:p88_admin/core/router/util.dart';

class AppRoute {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: _rootNavigatorKey,
      initialLocation: Pages.LOGIN_PATH,
      routes: [
        GoRoute(
              path: Pages.LOGIN_PATH,
              name: Pages.LOGIN_NAME,
              builder: (context, state) => LoginPage(),
            ),

        GoRoute(
          path: Pages.HOMEPAGE_PATH,
          name: Pages.HOMEPAGE_NAME,
          builder: (context, state) => HomePage(),
        ),
      ],
      errorBuilder: (context, state) => const InProgressPage(),
      redirect: (context, state) {
        if(context.read<AuthBloc>().state is AuthenticatedState) {
          return Pages.HOMEPAGE_PATH;
        } 

        if(context.read<AuthBloc>().state is UnAuthenticatedState) {
          return Pages.LOGIN_PATH;
        }
      },
    );

  static GoRouter get router => _router;
  
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:p88_admin/app/bloc/auth_bloc/auth_bloc.dart';
import 'package:p88_admin/app/persentation/page/auth/login/index.dart';
import 'package:p88_admin/app/persentation/page/errors/in_progress.dart';
import 'package:p88_admin/app/persentation/page/notification/index.dart';
import 'package:p88_admin/app/persentation/page/root/index.dart';
import 'package:p88_admin/app/persentation/page/profile/index.dart';
import 'package:p88_admin/core/router/util.dart';

class AppRoute {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: _rootNavigatorKey,
      initialLocation: Pages.ROOT_PATH,
      routes: [
        GoRoute(
              path: Pages.LOGIN_PATH,
              name: Pages.LOGIN_NAME,
              builder: (context, state) => LoginPage(),
            ),

        GoRoute(
          path: Pages.ROOT_PATH,
          name: Pages.ROOT_NAME,
          builder: (context, state) => RootPage(),
        ),

        GoRoute(
          path: Pages.PROFIL_PATH,
          name: Pages.PROFIL_NAME,
          builder: (context, state) => ProfilePage(),
        ),

        GoRoute(
          path: Pages.NOTIFICATION_PATH,
          name: Pages.NOTIFICATION_NAME,
          builder: (context, state) => NotificationPage(),
        ),

      ],
      errorBuilder: (context, state) => const InProgressPage(),
      redirect: (context, state) {
        if(context.read<AuthBloc>().state is AuthenticatedState && (state.matchedLocation == Pages.LOGIN_PATH)) {
          return Pages.ROOT_PATH;
        } 

        if(context.read<AuthBloc>().state is UnAuthenticatedState) {
          return Pages.LOGIN_PATH;
        }

        return null;
      },
    );

  static GoRouter get router => _router;
  
}

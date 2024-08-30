import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  );

  static GoRouter get router => _router;
}

// class AppRoute {
//   static final _rootNavigatorKey = GlobalKey<NavigatorState>();

//   static final GoRouter _router = GoRouter(
//     debugLogDiagnostics: true,
//     navigatorKey: _rootNavigatorKey,
//     routes: [
//       GoRoute(
//         path: PAGES.home.screenPath,
//         name: PAGES.home.screenName,
//         builder: (context, state) =>
//             BlocProvider(
//               create: (context) => injector<AuthBloc>()..add(const IsLoggedInEvent()),
//               child: const HomeScreen(),
//             ),
//       ),
//       GoRoute(
//         path: PAGES.login.screenPath,
//         name: PAGES.login.screenName,
//         builder: (context, state) =>
//             BlocProvider(
//               create: (context) => injector<AuthBloc>(),
//               child: const LoginScreen(),
//             ),
//       ),
//     ],
//     errorBuilder: (context, state) => const NotFoundScreen(),
//   );

//   static GoRouter get router => _router;
// }
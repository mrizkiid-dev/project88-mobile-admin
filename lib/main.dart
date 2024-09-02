import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p88_admin/app/bloc/auth_bloc/auth_bloc.dart';
import 'package:p88_admin/app/persentation/page/homepage/bloc/home_page_bloc.dart';
import 'package:p88_admin/core/di/get_it.dart';
import 'package:p88_admin/app/persentation/page/errors/in_progress.dart';
import 'dart:io' show Platform;

import 'package:p88_admin/core/router/router.dart';
import 'package:p88_admin/util/bloc.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await setUpServiceLocator();
  Bloc.observer = const AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: false,
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: injector<AuthBloc>(),
          ),
          BlocProvider.value(
            value: injector<HomePageBloc>(),
          ),
        ],
        child: App(),
      ),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);
    return baseTheme.copyWith(
      textTheme: GoogleFonts.inconsolataTextTheme(baseTheme.textTheme),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    if (Platform.isAndroid) {
      return BlocListener<AuthBloc, AuthState>(
        bloc: authBloc,
        listenWhen: (previous, current) {
          if(previous != current) {
            return true;
          }
          return false;
        },
        listener: (context, state) {
          if(state is AuthenticatedState || state is UnAuthenticatedState) {
             AppRoute.router.refresh();
          }
        },
        child: MaterialApp.router(
          routerConfig: AppRoute.router,
          theme: _buildTheme(Brightness.light),
        ),
      );
    } 

    if (Platform.isIOS) {
      return BlocListener<AuthBloc, AuthState>(
        bloc: authBloc,
        listenWhen: (previous, current) {
          if(previous != current) {
            return true;
          }
          return false;
        },
        listener: (context, state) {
          if(state is AuthenticatedState || state is UnAuthenticatedState) {
             AppRoute.router.refresh();
          }
        },
        child: MaterialApp.router(
          routerConfig: AppRoute.router,
          theme: _buildTheme(Brightness.light),
        ),
      );
    }

    return InProgressPage(message: 'Still In Progress',);
  }
}




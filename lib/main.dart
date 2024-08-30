import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p88_admin/app/bloc/bloc/auth_bloc.dart';
import 'package:p88_admin/core/data/network/dio.dart';
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
  // NetworkInspector.initialize();
  await setUpServiceLocator();
  // set dio
  injector<DioConfig>().configureDio();
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
    if (Platform.isAndroid) {
      return BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) {
          if(previous != current) {
            return true;
          }
          return false;
        },
        listener: (context, state) {
          AppRoute.router.refresh();
        },
        child: MaterialApp.router(
          routerConfig: AppRoute.router,
          theme: _buildTheme(Brightness.light),
        ),
      );
    } 

    if (Platform.isIOS) {
      return BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) {
          if(previous != current) {
            return true;
          }
          return false;
        },
        listener: (context, state) {
          AppRoute.router.refresh();
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




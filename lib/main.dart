import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p88_admin/app/bloc/auth_bloc/auth_bloc.dart';
import 'package:p88_admin/app/persentation/page/root/bloc/root_bloc.dart';
import 'package:p88_admin/app/persentation/page/root_chat/bloc/chat_bloc.dart';
import 'package:p88_admin/app/persentation/page/root_home/bloc/homepage_bloc.dart';
import 'package:p88_admin/app/persentation/page/root_order/bloc/order_bloc.dart';
import 'package:p88_admin/app/persentation/page/root_product/bloc/product_bloc.dart';
import 'package:p88_admin/core/di/get_it.dart';
import 'package:p88_admin/app/persentation/page/errors/in_progress.dart';
import 'dart:io' show Platform;

import 'package:p88_admin/core/router/router.dart';
import 'package:p88_admin/app/util/bloc.dart';


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
            value: injector<AuthBloc>()..add(AuthenticatedCheckEvent()),
          ),
          BlocProvider.value(
            value: injector<RootPageBloc>(),
          ),
          BlocProvider.value(
            value: injector<HomeBloc>()
          ),
          BlocProvider.value(
            value: injector<ProductBloc>()
          ),
          BlocProvider.value(
            value: injector<OrderBloc>()
          ),
          BlocProvider.value(
            value: injector<ChatBloc>()
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
    final scaffoldMessengerKey = injector<GlobalKey<ScaffoldMessengerState>>();
    final authBloc = BlocProvider.of<AuthBloc>(context);
    if (Platform.isAndroid || Platform.isIOS) {
      return BlocListener<AuthBloc, AuthState>(

        bloc: authBloc,
        listenWhen: (previous, current) {
          if(previous != current) {
            return true;
          }
          return false;
        },
        listener: (context, state) {
          // StateListenerHelper().showAuthErrorSnackbar(state, context);
          // StateListenerHelper().loading<AuthLoadingState>(state, context);
          if(state is AuthenticatedState || state is UnAuthenticatedState) {
             AppRoute.router.refresh();
          }
        },
        child: MaterialApp.router(
          routerConfig: AppRoute.router,
          theme: _buildTheme(Brightness.light),
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: scaffoldMessengerKey,
        ),
      );
    } 

    return InProgressPage(message: 'Still In Progress',);
  }
}




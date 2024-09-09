import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:p88_admin/app/bloc/app_bloc/app_bloc.dart';
import 'package:p88_admin/app/bloc/auth_bloc/auth_bloc.dart';
import 'package:p88_admin/app/data/repository/auth_repository.dart';
import 'package:p88_admin/app/data/repository/user_repository.dart';
import 'package:p88_admin/app/data/source/local/auth_cache.dart';
import 'package:p88_admin/app/data/source/local/user_cache.dart';
import 'package:p88_admin/app/data/source/network/dio/auth.dart';
import 'package:p88_admin/app/data/source/network/dio/user.dart';
import 'package:p88_admin/app/domain/usecase/auth/check_authenticate.dart';
import 'package:p88_admin/app/domain/usecase/auth/login_usecase.dart';
import 'package:p88_admin/app/domain/usecase/auth/logout_usecase.dart';
import 'package:p88_admin/app/domain/usecase/user/get_user_usecase.dart';
import 'package:p88_admin/app/persentation/page/auth/login/controller.dart';
import 'package:p88_admin/app/persentation/page/root/bloc/root_bloc.dart';
import 'package:p88_admin/app/persentation/page/root/controller.dart';
import 'package:p88_admin/app/persentation/page/root_chat/bloc/chat_bloc.dart';
import 'package:p88_admin/app/persentation/page/root_chat/controller.dart';
import 'package:p88_admin/app/persentation/page/root_home/bloc/homepage_bloc.dart';
import 'package:p88_admin/app/persentation/page/root_home/controller.dart';
import 'package:p88_admin/app/persentation/page/root_order/bloc/order_bloc.dart';
import 'package:p88_admin/app/persentation/page/root_order/controller.dart';
import 'package:p88_admin/app/persentation/page/root_product/bloc/product_bloc.dart';
import 'package:p88_admin/app/persentation/page/root_product/controller.dart';
import 'package:p88_admin/core/data/network/dio.dart';
import 'package:p88_admin/core/di/instance_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

final injector = GetIt.instance;

setUpServiceLocator() async {

  _globalKey();
  await _infrastructure();
  _contoller();
  _dataSource();
  _repository();
  _usecase();
  _bloc();
}

_globalKey() {
  injector.registerSingleton<GlobalKey<ScaffoldMessengerState>>(GlobalKey<ScaffoldMessengerState>());
}

_infrastructure() async {
  //dio
  injector.registerFactory<Dio>(() => Dio());
  injector.registerFactory<DioConfig>(() => DioConfig.configure());
  injector.registerFactory<DioConfig>(() => DioConfig(dio: injector<Dio>()), instanceName: InstanceName.dioDefault);

  //shared preferences
  injector.registerLazySingletonAsync<SharedPreferences>(() async => await SharedPreferences.getInstance());
}

_contoller() {
  injector.registerLazySingleton<LoginController>(() => LoginController());
  injector.registerLazySingleton<RootController>(() => RootController());
  injector.registerLazySingleton<HomeController>(() => HomeController());
  injector.registerLazySingleton<ProductController>(() => ProductController());
  injector.registerLazySingleton<OrderController>(() => OrderController());
  injector.registerLazySingleton<ChatController>(() => ChatController());
}

_dataSource() {
  // auth
  injector.registerLazySingleton<AuthCache>(() => AuthCacheImpl());
  injector.registerLazySingleton<UserCache>(() => UserCacheImpl());
  injector.registerLazySingleton<AuthDio>(() => AuthDioImpl(dioConfig: injector<DioConfig>(), authCache: injector<AuthCache>(), userCache: injector<UserCache>()));

  // user
  injector.registerLazySingleton<UserDio>(() => UserDioImpl(dioConfig: injector<DioConfig>(), authCache: injector<AuthCache>()));
}

_repository() {
  // auth
  injector.registerLazySingleton<Authrepository>(() => AuthrepositoryImpl(authCache: injector<AuthCache>(), authDio: injector<AuthDio>()));

  // user
  injector.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(userDio: injector<UserDio>()));
}

_usecase() {
  // auth
  injector.registerLazySingleton<LoginUsecase>(() => LoginUsecase(authRepository: injector<Authrepository>()));
  injector.registerLazySingleton<CheckAuthenticateUseCase>(() => CheckAuthenticateUseCase(authRepository: injector<Authrepository>()));
  injector.registerLazySingleton<LogoutUsecase>(() => LogoutUsecase(authrepository: injector<Authrepository>()));

  // user
  injector.registerLazySingleton<GetUserUsecase>(() => GetUserUsecase(userRepository: injector<UserRepository>()));
}

_bloc() async {
  //appBloc
  injector.registerLazySingleton<AppBloc>(() => AppBloc());

  // auth
  injector.registerLazySingleton<AuthBloc>(() => AuthBloc(
    loginUsecase: injector<LoginUsecase>(), 
    checkAuthenticateUseCase: injector<CheckAuthenticateUseCase>(),
    logoutUsecase: injector<LogoutUsecase>()
  ));

  // rootPage
  injector.registerFactory<RootPageBloc>(() => RootPageBloc(authBloc: injector<AuthBloc>(), getUserUsecase: injector<GetUserUsecase>()));

  // subRootPage
  injector.registerFactory<HomeBloc>(() => HomeBloc(getUserUseCase: injector<GetUserUsecase>()));
  injector.registerFactory<ProductBloc>(() => ProductBloc());
  injector.registerFactory<OrderBloc>(() => OrderBloc());
  injector.registerFactory<ChatBloc>(() => ChatBloc());
}
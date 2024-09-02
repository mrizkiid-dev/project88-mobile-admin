import 'package:dio/dio.dart';
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
import 'package:p88_admin/app/persentation/page/homepage/bloc/home_page_bloc.dart';
import 'package:p88_admin/core/data/network/dio.dart';
import 'package:p88_admin/core/di/instance_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

final injector = GetIt.instance;

setUpServiceLocator() async {
  injector.registerFactory<Dio>(() => Dio());
  injector.registerFactory<DioConfig>(() => DioConfig.configure());
  injector.registerFactory<DioConfig>(() => DioConfig(dio: injector<Dio>()), instanceName: InstanceName.dioDefault);

  //shared preferences
  injector.registerLazySingletonAsync<SharedPreferences>(() async => await SharedPreferences.getInstance());

  //appBloc
  injector.registerLazySingleton<AppBloc>(() => AppBloc());

  //auth
  //// source
  injector.registerLazySingleton<AuthCache>(() => AuthCacheImpl());
  injector.registerLazySingleton<UserCache>(() => UserCacheImpl());
  injector.registerLazySingleton<AuthDio>(() => AuthDioImpl(dioConfig: injector<DioConfig>(), authCache: injector<AuthCache>(), userCache: injector<UserCache>()));
  //// repository
  injector.registerLazySingleton<Authrepository>(() => AuthrepositoryImpl(authCache: injector<AuthCache>(), authDio: injector<AuthDio>()));
  //// usecase
  injector.registerLazySingleton<LoginUsecase>(() => LoginUsecase(authRepository: injector<Authrepository>()));
  injector.registerLazySingleton<CheckAuthenticateUseCase>(() => CheckAuthenticateUseCase(authRepository: injector<Authrepository>()));
  injector.registerLazySingleton<LogoutUsecase>(() => LogoutUsecase(authrepository: injector<Authrepository>()));
  //// bloc auth
  injector.registerLazySingleton<AuthBloc>(() => AuthBloc(
    loginUsecase: injector<LoginUsecase>(), 
    checkAuthenticateUseCase: injector<CheckAuthenticateUseCase>(),
    logoutUsecase: injector<LogoutUsecase>()
  ));

  // HomePage
  //// source
  injector.registerLazySingleton<UserDio>(() => UserDioImpl(dioConfig: injector<DioConfig>(), authCache: injector<AuthCache>()));
  //// repository
  injector.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(userDio: injector<UserDio>()));
  //// usecase
  injector.registerLazySingleton<GetUserUsecase>(() => GetUserUsecase(userRepository: injector<UserRepository>()));
  //bloc home_page
  injector.registerFactory<HomePageBloc>(() => HomePageBloc(authBloc: injector<AuthBloc>(), getUserUsecase: injector<GetUserUsecase>()));



}
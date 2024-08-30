import 'package:get_it/get_it.dart';
import 'package:p88_admin/app/bloc/bloc/auth_bloc.dart';
import 'package:p88_admin/app/data/repository/AuthRepository.dart';
import 'package:p88_admin/app/data/source/local/auth_cache.dart';
import 'package:p88_admin/app/data/source/network/dio/auth.dart';
import 'package:p88_admin/app/domain/usecase/auth/check_authenticate.dart';
import 'package:p88_admin/app/domain/usecase/auth/login_usecase.dart';
import 'package:p88_admin/core/data/network/dio.dart';

final injector = GetIt.instance;

// setupServiceLocator() async {
//   serviceLocator.registerFactory<Constant>(() => Constant());
//   serviceLocator.registerFactory<Dio>(
//     () => NetworkClient(Dio(), constant: serviceLocator()).dio,
//   );

//   // News
//   serviceLocator.registerFactory<MainNewsBloc>(() => MainNewsBloc());
//   serviceLocator.registerLazySingleton<NewsApi>(() => NewsApi(
//       dio: serviceLocator(), apiKey: serviceLocator<Constant>().apiKey));
//   serviceLocator.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(
//       newsApi: serviceLocator(), apiKey: serviceLocator<Constant>().apiKey));
//   serviceLocator.registerLazySingleton<GetRecentNewsUseCase>(
//       () => GetRecentNewsUseCase(serviceLocator()));
// }

setUpServiceLocator() async {
  // serviceLocator.registerFactory<LoginBloc>(() => LoginBloc());
  injector.registerSingleton<DioConfig>(DioConfig());

  //auth
  injector.registerLazySingleton<AuthCache>(() => AuthCacheImpl());
  injector.registerLazySingleton<AuthDio>(() => AuthDioImpl(dioConfig: injector<DioConfig>()));
  //// repository
  injector.registerLazySingleton<Authrepository>(() => AuthrepositoryImpl(authCache: injector<AuthCache>(), authDio: injector<AuthDio>()));
  //// usecase
  injector.registerLazySingleton<LoginUsecase>(() => LoginUsecase(authRepository: injector<Authrepository>()));
  injector.registerLazySingleton<CheckAuthenticateUseCase>(() => CheckAuthenticateUseCase(authRepository: injector<Authrepository>()));
  //// bloc auth
  injector.registerFactory<AuthBloc>(() => AuthBloc(loginUsecase: injector<LoginUsecase>(), checkAuthenticateUseCase: injector<CheckAuthenticateUseCase>()));



}
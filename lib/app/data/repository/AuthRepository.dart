import 'package:dartz/dartz.dart';
import 'package:p88_admin/app/data/source/local/auth_cache.dart';
import 'package:p88_admin/app/data/source/network/dio/auth.dart';
import 'package:p88_admin/app/domain/entity/auth.dart';
import 'package:p88_admin/core/response/error/cache_failure.dart';
import 'package:p88_admin/core/response/error/network_failure.dart';

abstract class Authrepository {
  Future<void> saveToken(String? value);
  Future<String?> getToken();
  Future<Either<NetworkFailure, Auth>> login({required String email, required String password});
  Future<bool> logout();
}

class AuthrepositoryImpl extends Authrepository {
  AuthrepositoryImpl({
    required AuthCache authCache,
    required AuthDio authDio,
  }) : _authCache = authCache, _authDio = authDio;

  AuthCache _authCache;
  AuthDio _authDio;

  @override
  Future<String?> getToken()  {
    return _authCache.getToken();
  }

  @override
  Future<void> saveToken(String? value) async { 
    return _authCache.saveToken(value);
  }
  
  @override
  Future<Either<NetworkFailure, Auth>> login({required String email, required String password}) {
    return _authDio.login(email: email, password: password);
  }
  
  @override
  Future<bool> logout() {
    return _authDio.logout();
  }

}
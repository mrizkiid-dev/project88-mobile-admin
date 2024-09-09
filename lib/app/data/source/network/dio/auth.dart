import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:p88_admin/app/data/dto/auth_login_dto.dart';
import 'package:p88_admin/app/data/dto/user_dto.dart';
import 'package:p88_admin/app/data/source/local/auth_cache.dart';
import 'package:p88_admin/app/data/source/local/user_cache.dart';
import 'package:p88_admin/app/domain/entity/auth.dart';
import 'package:p88_admin/core/data/network/dio.dart';
import 'package:p88_admin/core/response/error/cache_failure.dart';
import 'package:p88_admin/core/response/error/network_failure.dart';
import 'package:p88_admin/core/response/error/unauthenticated.dart';
import 'package:p88_admin/app/util/exception.dart';
import 'package:p88_admin/app/util/type.dart';

abstract class AuthDio {
  Future<Auth> login({required String email, required String password});
  Future<bool> logout();
}

class AuthDioImpl extends AuthDio {
  AuthDioImpl({
    required DioConfig dioConfig,
    required AuthCache authCache,
    required UserCache userCache
  }): _dioConfig = dioConfig, dio = dioConfig.dio, 
  _authCache = authCache, _userCache = userCache;

  final DioConfig _dioConfig;
  final Dio dio;
  final AuthCache _authCache;
  final UserCache _userCache;

  @override
  Future<Auth> login({required String email, required String password}) async{
    try {
      Map<String, dynamic> body = {
        'email': email,
        'password': password,
        'device_name': 'vivo'
      };
      final response = await dio.post(
        '/v1/admin/mobile/login',
        data: body
      );

      final json = response.data as Json;
      final authDto = AuthLoginDto.mapperFromJson(json);

      if(!authDto.isAdmin) {
        throw NetworkFailure(type: EnumNetworkErrorType.forbidden);
      }

      final Auth auth = authDto.mapperToEntity();

      // cache user
      final user = auth.user;
      _userCache.saveUser(UserDto.mapperFromEntitytoJson(user));

      // cache token
      await _authCache.saveToken(auth.token);
      return authDto.mapperToEntity();
    }on CacheFailure {
      throw NetworkFailure(type: EnumNetworkErrorType.defaultMessage);
    }on DioException catch (e) {
      if(e.response!.statusCode == 401) {
        throw NetworkFailure(type: EnumNetworkErrorType.unAuthenticated);
      }
      throw NetworkFailure(type: EnumNetworkErrorType.defaultMessage);
    }on NetworkFailure catch (e) {
      throw e;
    } catch (e) {
      debugPrint('AuthDio failure = '+e.toString());
      throw e;
    }

  }
  
  @override
  Future<bool> logout() async{
    try {
      final token = await _authCache.getToken();
      if(token != null) {
        _dioConfig.interceptorsToken(token);
      } else {
        throw UnauthenticatedException(type: EnumUnauthenticatedType.defaultMessage);
      }

      await dio.post('/v1/logout');

      await _authCache.deleteToken();
      return true;
    } on DioException catch (e) {
      throw UtilException.checkUnAuthenticateException(trace: 'TestNetwork',dioException: e);
    }
     catch (e) {
      throw e;
    }
  }
  
}
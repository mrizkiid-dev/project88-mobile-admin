import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:p88_admin/app/data/dto/auth_login_dto.dart';
import 'package:p88_admin/app/data/dto/user_dto.dart';
import 'package:p88_admin/app/data/source/local/auth_cache.dart';
import 'package:p88_admin/app/data/source/local/user_cache.dart';
import 'package:p88_admin/app/domain/entity/auth.dart';
import 'package:p88_admin/app/domain/entity/user.dart';
import 'package:p88_admin/core/data/network/dio.dart';
import 'package:p88_admin/core/response/error/cache_failure.dart';
import 'package:p88_admin/core/response/error/network_failure.dart';
import 'package:p88_admin/core/response/error/unauthenticated.dart';
import 'package:p88_admin/util/exception.dart';
import 'package:p88_admin/util/type.dart';

abstract class AuthDio {
  Future<Either<NetworkFailure, Auth>> login({required String email, required String password});
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
  Future<Either<NetworkFailure, Auth>> login({required String email, required String password}) async{
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
        throw NetworkFailure(message: 'forbidden',statusCode: 403);
      }

      final Auth auth = authDto.mapperToEntity();

      // cache user
      final user = auth.user;
      _userCache.saveUser(UserDto.mapperFromEntitytoJson(user));

      // cache token
      await _authCache.saveToken(auth.token);
      return right(authDto.mapperToEntity());
    }on CacheFailure catch (e) {
      throw NetworkFailure(message: 'asdfs');
    }on DioException catch (e) {
      throw NetworkFailure(message: e.message ?? jsonEncode(e.response));
    }on NetworkFailure catch (e) {
      debugPrint('-- network failure = '+e.message);
      return left(e);
    } catch (e) {
      debugPrint('-- catch failure = '+e.toString());
      return left(NetworkFailure(message: e.toString()));
    }

  }
  
  @override
  Future<bool> logout() async{
    try {
      final token = await _authCache.getToken();
      if(token != null) {
        _dioConfig.interceptorsToken(token);
      } else {
        throw UnauthenticatedException(message: 'need to login');
      }

      final response = await dio.post('/v1/logout');
      if(response.statusCode != 200) {
        throw NetworkFailure(message: response.statusMessage.toString(), statusCode: response.statusCode);
      } 

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
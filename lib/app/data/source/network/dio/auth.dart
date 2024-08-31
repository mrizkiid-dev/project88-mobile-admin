import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:p88_admin/app/data/dto/auth_login_dto.dart';
import 'package:p88_admin/app/data/source/local/auth_cache.dart';
import 'package:p88_admin/app/domain/entity/auth.dart';
import 'package:p88_admin/core/data/network/dio.dart';
import 'package:p88_admin/core/response/error/network_failure.dart';
import 'package:p88_admin/core/response/error/unauthenticated.dart';
import 'package:p88_admin/util/type.dart';

abstract class AuthDio {
  Future<Either<NetworkFailure, Auth>> login({required String email, required String password});
  Future<bool> logout();
}

class AuthDioImpl extends AuthDio {
  AuthDioImpl({
    required DioConfig dioConfig,
    required AuthCache authCache,
  }): _dioConfig = dioConfig, dio = dioConfig.dio, _authCache = authCache
  ;

  final DioConfig _dioConfig;
  final Dio dio;
  final AuthCache _authCache;

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
      final authDto = AuthLoginDto.fromJson(json);

      if(!authDto.isAdmin) {
        throw NetworkFailure(message: 'forbidden',statusCode: 403);
      }

      debugPrint('AuthDioImpl = '+response.toString());
      debugPrint('AuthDioImpl response data = '+response.data.toString());
      return right(authDto.mapperToEntity());

    }on DioException catch (e) {
      throw NetworkFailure(message: e.message ?? jsonEncode(e.response));
    }on NetworkFailure catch (e) {
      return left(e);
    } catch (e) {
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
        throw UnauthenticatedError(message: 'need to login');
      }

      final response = await dio.post('/v1/logout');
      if(response.statusCode != 200) {
        throw NetworkFailure(message: response.statusMessage.toString(), statusCode: response.statusCode);
      } 
      return true;
    } catch (e) {
      throw e;
    }
  }
}
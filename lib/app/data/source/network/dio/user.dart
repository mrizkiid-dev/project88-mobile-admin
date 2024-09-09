import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:p88_admin/app/data/dto/user_dto.dart';
import 'package:p88_admin/app/data/source/local/auth_cache.dart';
import 'package:p88_admin/app/data/source/utils_source.dart';
import 'package:p88_admin/app/domain/entity/user.dart';
import 'package:p88_admin/core/data/network/dio.dart';
import 'package:p88_admin/core/response/error/network_failure.dart';
import 'package:p88_admin/app/util/type.dart';

abstract class UserDio {
  Future<User> getUser();
}

class UserDioImpl extends UserDio {
  UserDioImpl({
    required DioConfig dioConfig,
    required AuthCache authCache
  }): _dioConfig = dioConfig, _dio = dioConfig.dio, _authCache = authCache ;

  DioConfig _dioConfig;
  Dio _dio;
  AuthCache _authCache;

  @override
  Future<User> getUser() async{
    await UtilSource.setTokenOnDio(_dioConfig, _authCache);
    final response = await _dio.get('/v1/user');
    final resutlJson = response.data as Json;
    
    return UserDto.mapperFromJson(resutlJson).mapperToEntity();
  }
  
}
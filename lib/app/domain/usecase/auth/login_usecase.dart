import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:p88_admin/app/data/repository/auth_repository.dart';
import 'package:p88_admin/app/domain/entity/auth.dart';
import 'package:p88_admin/app/domain/usecase/contract/params.dart';
import 'package:p88_admin/app/domain/usecase/contract/use_case.dart';
import 'package:p88_admin/core/response/error/abstract_failure.dart';
import 'package:p88_admin/core/response/error/network_failure.dart';

class ParamLoginUsecase implements ParamsUseCase {
  ParamLoginUsecase({
    required this.email,
    required this.password
  });
  final String email;
  final String password;

  @override
  String toString() {
    return '{ email: ${email}, password: ${password}}';
  }
}

class LoginUsecase extends UseCaseFetch<ParamLoginUsecase, Auth> {
  LoginUsecase({
    required Authrepository authRepository
  }): _authrepository = authRepository;

  Authrepository _authrepository;
  
  @override
  Future<Either<NetworkFailure, Auth>> execute(ParamLoginUsecase params) async {
    final result = await _authrepository.login(email: params.email, password: params.password);       
    return result;
  }
}
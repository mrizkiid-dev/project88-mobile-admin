import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:p88_admin/app/data/repository/AuthRepository.dart';
import 'package:p88_admin/app/domain/entity/auth.dart';
import 'package:p88_admin/app/domain/usecase/use_case.dart';
import 'package:p88_admin/core/response/error/cache_failure.dart';

class GetAuthToken extends UseCaseWithoutParams<Future<String?>> {
  GetAuthToken(this._authRepository);

  Authrepository _authRepository;

  @override
  Future<String?> execute(){
    return _authRepository.getToken();
  }

}
import 'dart:async';

import 'package:p88_admin/app/data/repository/AuthRepository.dart';
import 'package:p88_admin/app/domain/usecase/use_case.dart';

class GetAuthToken extends UseCaseWithoutParams<Future<String?>> {
  GetAuthToken(this._authRepository);

  Authrepository _authRepository;

  @override
  Future<String?> execute(){
    return _authRepository.getToken();
  }

}
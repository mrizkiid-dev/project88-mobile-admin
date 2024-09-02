import 'dart:async';

import 'package:p88_admin/app/data/repository/auth_repository.dart';
import 'package:p88_admin/app/domain/usecase/contract/use_case.dart';

class GetAuthToken extends UseCaseWithoutParams<Future<String?>> {
  GetAuthToken(this._authRepository);

  Authrepository _authRepository;

  @override
  Future<String?> execute(){
    return _authRepository.getToken();
  }

}
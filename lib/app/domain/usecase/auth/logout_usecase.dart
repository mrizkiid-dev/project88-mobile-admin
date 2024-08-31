import 'package:p88_admin/app/data/repository/AuthRepository.dart';
import 'package:p88_admin/app/domain/usecase/use_case.dart';

class LogoutUsecase extends UseCaseWithoutParams<Future<bool>> {
  LogoutUsecase({
    required Authrepository authrepository
  }): _authrepository=authrepository;

  Authrepository _authrepository;
  @override
  Future<bool> execute() async {
    return await _authrepository.logout();
  }
  
}
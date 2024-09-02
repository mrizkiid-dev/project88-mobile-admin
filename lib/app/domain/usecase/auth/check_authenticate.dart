import 'package:p88_admin/app/data/repository/auth_repository.dart';
import 'package:p88_admin/app/domain/usecase/contract/use_case.dart';

class CheckAuthenticateUseCase extends UseCaseWithoutParams<Future<bool>> {
  CheckAuthenticateUseCase({
    required Authrepository authRepository
  }): _authrepository = authRepository;

  final Authrepository _authrepository;
  @override
  Future<bool> execute() async{
    try {
      final token = await _authrepository.getToken();
      if(token != null && token != '') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw e;
    }
  }
}
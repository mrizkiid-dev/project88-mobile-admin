import 'package:p88_admin/app/data/repository/user_repository.dart';
import 'package:p88_admin/app/domain/entity/user.dart';
import 'package:p88_admin/app/domain/usecase/contract/use_case.dart';

class GetUserUsecase extends UseCaseWithoutParams<Future<User>> {
  GetUserUsecase({
    required UserRepository userRepository
  }): _userRepository = userRepository;

  UserRepository _userRepository;
  
  @override
  Future<User> execute() {
    return _userRepository.getUser();
  }
  
}
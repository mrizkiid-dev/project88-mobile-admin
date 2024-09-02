import 'package:p88_admin/app/data/source/network/dio/user.dart';
import 'package:p88_admin/app/domain/entity/user.dart';

abstract class UserRepository implements UserDio {}

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl({
    required UserDio userDio
  }): _userDio = userDio;

  UserDio _userDio;

  @override
  Future<User> getUser() async{
    return _userDio.getUser();
  }
  
}

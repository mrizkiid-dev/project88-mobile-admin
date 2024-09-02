import 'dart:convert';

import 'package:p88_admin/app/data/dto/user_dto.dart';
import 'package:p88_admin/app/domain/entity/user.dart';
import 'package:p88_admin/core/di/get_it.dart';
import 'package:p88_admin/core/response/error/cache_failure.dart';
import 'package:p88_admin/util/type.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserCache {
  Future<void> saveUser(String user);
  Future<User> getUser();
}

class UserCacheImpl extends UserCache {
  UserCacheImpl();

  // token name
  final String _userKey = 'user-key';

  @override
  Future<User> getUser() async{
    final prefs = await injector<SharedPreferences>();
    final user = await prefs.getString(_userKey);
    if(user != null) {
      final userJson = jsonDecode(user) as Json ;
      return UserDto.mapperFromJson(userJson).mapperToEntity();
    }
    throw CacheFailure(message: 'user not found');
  }

  @override
  Future<void> saveUser(String user) async{
    try {
      final prefs = await injector<SharedPreferences>();
      await prefs.setString(_userKey, user);
    } catch (e) {
      throw CacheFailure(message: 'save user failed - '+e.toString());
    }
  }

}
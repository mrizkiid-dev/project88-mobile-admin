import 'package:dartz/dartz.dart';
import 'package:p88_admin/app/data/dto/auth_login_dto.dart';
import 'package:p88_admin/app/domain/entity/auth.dart';
import 'package:p88_admin/core/response/error/cache_failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthCache {
  void saveToken(String? value);
  Future<String?> getToken();
  void deleteToken();
}

class AuthCacheImpl extends AuthCache{

  String _token = 'Token';

  @override
  Future<String?> getToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = await prefs.getString(_token);
      if (token != null) {
        return token;
      } else {
        throw 'token not found';
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  void saveToken(String? value) async{
    try {
      if(value != null && value != '') {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(_token, value);
      } else {
        throw 'error token shouldnt empty string nor null';
      }
    } catch (e) {
      throw e;
    }
  }
  
  @override
  void deleteToken() {
    // TODO: implement deleteToken
  }

  
}
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthCache {
  Future<void> saveToken(String? value);
  Future<String?> getToken();
  Future<void> deleteToken();
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
  Future<void> saveToken(String? value) async{
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
  Future<void> deleteToken() async{
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_token);
    } catch (e) {
      
    }
  }

  
}
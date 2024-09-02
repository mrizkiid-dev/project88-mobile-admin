import 'package:p88_admin/app/domain/entity/enitity.dart';
import 'package:p88_admin/app/domain/entity/user.dart';

class Auth {
  Auth({
    required this.token,
    required this.user
  });

  String token;
  User user;
  // int? id;
  // String? name;
  // String? email;
  
  @override
  List<Object?> get props => [token];

}
import 'package:equatable/equatable.dart';

class Auth with EquatableMixin {
  Auth({
    required this.token,
    this.id,
    this.name,
    this.email
  });

  String token;
  int? id;
  String? name;
  String? email;
  
  @override
  List<Object?> get props => [token, id, name, email];

}
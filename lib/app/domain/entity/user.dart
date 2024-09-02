import 'package:p88_admin/app/domain/entity/enitity.dart';

class User extends Entity {
  User({
    this.id,
    required this.name,
    required this.email,
    this.uuid
  });

  int? id;
  String name;
  String email;
  String? uuid;
  
  @override
  List<Object?> get props => [id, name, email, uuid];

  @override
  String toString() {
    return '{ id = ${id}, name = ${name}, email = ${email}, uuid = ${uuid} }';
  }
}
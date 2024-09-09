import 'dart:convert';

import 'package:p88_admin/app/data/dto/contract/abstract_dto.dart';
import 'package:p88_admin/app/domain/entity/auth.dart';
import 'package:p88_admin/app/domain/entity/user.dart';
import 'package:p88_admin/app/util/type.dart';

class AuthLoginDto extends DTO<Auth> {
  AuthLoginDto({
    required this.token,
    required this.id,
    required this.name,
    required this.email,
    this.isAdmin = false,
  });

  String token;
  int? id;
  String name;
  String email;
  bool isAdmin;
  
  @override
  Auth mapperToEntity() {
    return Auth(
      token: token,
      user: User(
        id: id, 
        name: name, 
        email: email
      ),
    );
  }

  factory AuthLoginDto.mapperFromEntity(Auth entity) {
    return AuthLoginDto(
      token: entity.token,
      id: entity.user.id,
      name: entity.user.name,
      email: entity.user.email
    );
  }
  
  @override
  String mapperToJson() {
    final json = {
      "name": this.name,
      "email": this.email
    };
    return jsonEncode(json);
  }

  factory AuthLoginDto.mapperFromJson(Json json) {
    if (json["success"] is bool &&
        json["user"] is Json &&
        json["authorization"] is Json) {
      
      final user = json["user"] as Json;
      final authorization = json["authorization"] as Json;

      if (user["name"] is String &&
          user["email"] is String &&
          user["is_admin"] is bool &&
          authorization["token"] is String &&
          authorization["type"] is String) {
        return AuthLoginDto(
          token: authorization["token"],
          id: user["id"],
          name: user["name"],
          email: user["email"],
          isAdmin: user["is_admin"]
        );
      }
    }
    
    throw const FormatException("Failed to load AuthLoginDto method mapperFromJson.");
  }
  

}


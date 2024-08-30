import 'dart:convert';

import 'package:p88_admin/app/domain/entity/auth.dart';
import 'package:p88_admin/util/type.dart';

class AuthLoginDto {
  AuthLoginDto({
    required this.token,
    this.id,
    this.name,
    this.email,
  });

  String token;
  int? id;
  String? name;
  String? email;

  Auth mapperToEntity() {
    return Auth(
      token: this.token,
      id: this.id,
      name: this.name,
      email: this.email
    );
  }

  factory AuthLoginDto.mapperFromEntity(Auth auth) {
    return AuthLoginDto(
      token: auth.token,
      id: auth.id,
      name: auth.name,
      email: auth.email
    );
  }

  factory AuthLoginDto.fromJson(Json json) {
    if (json['success'] is bool &&
        json['user'] is Json &&
        json['authorization'] is Json) {
      
      final user = json['user'] as Json;
      final authorization = json['authorization'] as Json;

      if (user['name'] is String &&
          user['email'] is String &&
          authorization['token'] is String &&
          authorization['type'] is String) {
        return AuthLoginDto(
          token: authorization['token'],
          name: user['name'],
          email: user['email'],
        );
      }
    }
    
    throw const FormatException('Failed to load AuthLoginDto.');
  }

  String toJson(AuthLoginDto dto) {
    final json = {
      'token': dto.token,
      'user': {
        'id': dto.id,
        'name': dto.name,
        'email': dto.email
      }
    };
    return jsonEncode(json);
  }
}


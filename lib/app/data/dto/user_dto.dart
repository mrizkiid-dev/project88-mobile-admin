import 'dart:convert';
import 'package:p88_admin/app/data/dto/contract/abstract_dto.dart';
import 'package:p88_admin/app/domain/entity/enitity.dart';
import 'package:p88_admin/app/domain/entity/user.dart';
import 'package:p88_admin/util/type.dart';

class UserDto extends DTO<User> {
  UserDto({
    this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.uuid,
  });

  final int? id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String? createdAt;
  final String? updatedAt;
  final String? uuid;


  factory UserDto.mapperFromJson(Json json) {
     if (json["user"] is Json) {
      final user = json["user"] as Json;

      if (
          user["id"] is int &&
          user["name"] is String &&
          user["email"] is String
          // user["is_admin"] is bool &&
          // user["email_verified_at"] is String? &&
          // user["created_at"] is String? &&
          // user["updated_at"] is String? &&
          // user["uuid"] is String?
        )
           {
        return UserDto(
          id: user["id"],
          name: user["name"],
          email: user["email"],
          emailVerifiedAt: user["email_verified_at"],
          createdAt: user["created_at"],
          updatedAt: user["udpated_at"],
          uuid: user['uuid']
        );
      }
    }
    
    throw const FormatException("Failed to load UserDto method mapperFromJson.");
  }
  
  factory UserDto.mapperFromEntity(User entity) {
    return UserDto(
      id: entity.id, 
      name: entity.name, 
      email: entity.email
    );
  }

  static String mapperFromEntitytoJson(User entity) {
    Json json = {
      "id": entity.id,
      "name": entity.name,
      "email": entity.email,
      "uuid": entity.uuid
    };

    return jsonEncode(json);
  }
  
  @override
  User mapperToEntity() {
    return User(
      id: this.id, 
      name: this.name, 
      email: this.email
    );
  }
  
  @override
  String mapperToJson() {
    Json json = {
      "id": this.id,
      "name": this.name,
      "email": this.email,
      "email_verified_at": this.emailVerifiedAt,
      "created_at": this.createdAt,
      "updated_at": this.updatedAt,
      "uuid": this.uuid
    };
    return jsonEncode(json);
  }
}
///
/// [Entity] is entity class 
/// Example:
/// ```dart
/// class AuthLoginDto extends DTO<AuthLoginDto, Auth> {}
/// ```
abstract class DTO<Entity>{
  String mapperToJson();
  Entity mapperToEntity();
  // String mapperFromEntitytoJson(Entity entity);
}
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String token;

  UserModel({required this.userId, required this.username, required this.email, required this.token});
}

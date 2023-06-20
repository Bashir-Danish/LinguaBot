import 'package:hive/hive.dart';

part 'message_model.g.dart';

@HiveType(typeId: 1)
class Message {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String message;

  @HiveField(2)
  final bool isUser;



  Message({required this.userId, required this.message, required this.isUser});
}

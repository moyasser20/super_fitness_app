import 'package:hive/hive.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

part 'chat_session.g.dart';

@HiveType(typeId: 0)
class ChatSession extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  List<Map<String, dynamic>>? messagesJson;

  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  DateTime updatedAt;

  ChatSession({
    required this.id,
    required this.title,
    required this.messagesJson,
    required this.createdAt,
    required this.updatedAt,
  });

  List<types.Message> get messages =>
      messagesJson?.map((json) => types.Message.fromJson(json as Map<String, dynamic>)).toList() ?? [];

  set messages(List<types.Message> msgs) {
    messagesJson = msgs.map((msg) => msg.toJson()).toList();
  }
}
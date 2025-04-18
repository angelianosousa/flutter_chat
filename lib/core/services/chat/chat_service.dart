import 'package:my_chat/core/models/chat_message.dart';
import 'package:my_chat/core/models/chat_user.dart';
import 'package:my_chat/core/services/chat/chat_mock_service.dart';

abstract class ChatService {
  Stream<List<ChatMessage>> messagesStream();
  Future<ChatMessage> save(String text, ChatUser user);

  factory ChatService() {
    return ChatMockService();
  }
}

import 'dart:async';
import 'dart:math';

import 'package:my_chat/core/models/chat_message.dart';
import 'package:my_chat/core/models/chat_user.dart';
import 'package:my_chat/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _messages = [
    ChatMessage(
      id: '1',
      text: 'Olá bom dia!',
      userId: '123',
      userName: 'Alana',
      userImageUrl: 'assets/images/user.jpg',
      createdAt: DateTime.now(),
    ),
    ChatMessage(
      id: '2',
      text: 'Bom dia. Teremos reunião hoje ?',
      userId: '456',
      userName: 'Ana',
      userImageUrl: 'assets/images/user.jpg',
      createdAt: DateTime.now(),
    ),
    ChatMessage(
      id: '3',
      text: 'Vamos sim, pode ser agora!',
      userId: '123',
      userName: 'Alana',
      userImageUrl: 'assets/images/user.jpg',
      createdAt: DateTime.now(),
    )
  ];

  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _messagesStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_messages);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _messagesStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
      createdAt: DateTime.now(),
    );

    _messages.add(newMessage);

    _controller?.add(_messages.reversed.toList());

    return newMessage;
  }
}

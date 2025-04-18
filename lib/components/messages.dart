import 'package:flutter/material.dart';
import 'package:my_chat/components/message_bubble.dart';
import 'package:my_chat/core/models/chat_message.dart';
import 'package:my_chat/core/services/auth/auth_service.dart';
import 'package:my_chat/core/services/chat/chat_service.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;

    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messagesStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Sem mensagens'));
        } else {
          final messages = snapshot.data!;

          return ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder:
              (ctx, index) => MessageBubble(
                key: ValueKey(messages[index].id),
                message: messages[index],
                belongsToCurrentUser: messages[index].userId == currentUser!.id,
              )
          );
        }
      },
    );
  }
}

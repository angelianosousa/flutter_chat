import 'package:flutter/material.dart';
import 'package:my_chat/core/services/auth/auth_service.dart';
import 'package:my_chat/core/services/chat/chat_service.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  // String _message = '';
  final _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;

    if (user != null) {
      await ChatService().save(_messageController.text, user);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: TextField(
              controller: _messageController,
              onChanged: (msg) => setState(() => _messageController.text = msg),
              onSubmitted: (_) {
                if (_messageController.text.trim().isNotEmpty) {
                  _sendMessage();
                }
              },
              decoration: InputDecoration(
                labelText: 'Enviar mensagem...',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        IconButton(onPressed: null, icon: Icon(Icons.attachment_sharp)),
        IconButton(
          onPressed: _messageController.text.trim().isEmpty ? null : _sendMessage,
          icon: Icon(Icons.send),
        ),
      ],
    );
  }
}

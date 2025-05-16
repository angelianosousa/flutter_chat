import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_chat/core/models/chat_message.dart';

class MessageBubble extends StatelessWidget {
  static final _defaultUserImage = 'assets/images/user.jpg';
  final ChatMessage message;
  final bool belongsToCurrentUser;

  const MessageBubble({
    required this.message,
    required this.belongsToCurrentUser,
    super.key,
  });

  Widget _showUserImage(String? imageUrl) {    
    ImageProvider? provider;
    final uri = Uri.parse(imageUrl!);

    if (uri.path.contains(_defaultUserImage)) {
      provider = AssetImage(_defaultUserImage);
    } else if (uri.scheme.contains('http')) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(
      backgroundColor: Colors.amber,
      backgroundImage: provider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              belongsToCurrentUser
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            Container(
              width: 180,
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: belongsToCurrentUser ? Radius.circular(15) : Radius.zero,
                  bottomRight: belongsToCurrentUser ? Radius.zero : Radius.circular(15)
                ),
                color:
                    belongsToCurrentUser
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade300,
              ),
              child: Column(
                crossAxisAlignment: belongsToCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.userName,
                    style: TextStyle(
                      color: belongsToCurrentUser ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    message.text,
                    textAlign: belongsToCurrentUser ? TextAlign.end : TextAlign.start,
                    style: TextStyle(
                      color: belongsToCurrentUser ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          left: belongsToCurrentUser ? 150 : null,
          right: belongsToCurrentUser ? null : 150,
          child: _showUserImage(message.userImageUrl),
        ),
      ],
    );
  }
}

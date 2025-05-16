// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_chat/components/messages.dart';
import 'package:my_chat/components/new_messages.dart';
import 'package:my_chat/components/notification_bell.dart';
// import 'package:my_chat/core/models/chat_notification.dart';
import 'package:my_chat/core/services/auth/auth_service.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Text('My Chat'),
          SizedBox(width: 10),
          Icon(Icons.chat_rounded),
        ],),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 10),
                      Text('Sair'),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == 'logout') AuthService().signOut();
              },
              icon: Icon(Icons.more_vert, color: Colors.white),
            ),
          ),
          NotificationBell('5'),
        ],
      ),
      body: SafeArea(
        child: Column(children: [Expanded(child: Messages()), NewMessages()]),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     Provider.of<ChatNotificationService>(context, listen: false).add(
      //       ChatNotification(
      //         title: 'Teste notificação',
      //         body: Random().nextDouble().toString(),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}

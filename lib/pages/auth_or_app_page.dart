import 'package:flutter/material.dart';
import 'package:my_chat/core/models/chat_user.dart';
import 'package:my_chat/core/services/auth/auth_service.dart';
import 'package:my_chat/pages/auth_page.dart';
import 'package:my_chat/pages/chat_page.dart';
import 'package:my_chat/pages/loading_page.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ChatUser?>(
        stream: AuthService().userChanges,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingPage();
          } else {
            return snapshot.hasData ? ChatPage() : AuthPage();
          }
        },
      ),
    );
  }
}

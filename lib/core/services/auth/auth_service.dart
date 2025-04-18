import 'dart:io';

import 'package:my_chat/core/models/chat_user.dart';
import 'package:my_chat/core/services/auth/auth_mock_service.dart';

abstract class AuthService {
  ChatUser? get currentUser;

  Stream<ChatUser?> get userChanges;

  Future<void> signUp(String name, String email, String password, File? image);
  Future<void> signIn(String email, String password);
  Future<void> signOut();

  factory AuthService() {
    return AuthMockService();
  }
}

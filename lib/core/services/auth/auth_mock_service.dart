import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:my_chat/core/models/chat_user.dart';
import 'package:my_chat/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  static final ChatUser _defaultUser = ChatUser(
    id: '123',
    name: 'Alana',
    email: 'alana@gmail.com',
    imageUrl: 'assets/images/user.jpg',
  );

  static final Map<String, ChatUser> _users = {};
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    // _currentUser = null;
    // controller.add(_currentUser);
    _updateUser(_defaultUser);
  });

  @override
  ChatUser? get currentUser {
    return _currentUser;
  }

  @override
  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  @override
  Future<void> signUp(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final newUser = ChatUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageUrl: image?.path ?? 'assets/images/user.jpg',
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  @override
  Future<void> signIn(String email, String password) async {
    _updateUser(_users[email]);
  }

  @override
  Future<void> signOut() async {
    _updateUser(null);
  }

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}

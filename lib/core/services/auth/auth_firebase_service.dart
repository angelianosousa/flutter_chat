import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_chat/core/models/chat_user.dart';
import 'package:my_chat/core/services/auth/auth_service.dart';

class AuthFirebaseService implements AuthService {
  static ChatUser? _currentUser;
  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();

    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toChatUser(user);

      controller.add(_currentUser);
    }
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
    final signup = await Firebase.initializeApp(
      name: 'userSignup',
      options: Firebase.app().options,
    );

    final auth = FirebaseAuth.instanceFor(app: signup);

    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user != null) {
      // 1. Upload da foto do usuário
      // final imageName = credential.user!.uid;
      // final imageUrl  = await _uploadUserImage(image, imageName);

      // 2. Atualiza as informações do usuário
      await credential.user?.updateDisplayName(name);
      // credential.user?.updatePhotoURL(imageUrl);

      // 2.5 faz o login do usuário
      await signIn(email, password);

      // 3. Salvar banco de dados
      _currentUser = _toChatUser(credential.user!);
      await _saveChatUser(_currentUser!);
    }

    await signup.delete();
  }

  @override
  Future<void> signIn(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
  }

  // Não é gratuito!
  // Future<String?> _uploadUserImage(File? image, String imageName) async {
  //   if (image == null) return null;

  //   final storage = FirebaseStorage.instance;
  //   final imageRef = storage.ref().child('user_photos').child(imageName);
  //   await imageRef.putFile(image).whenComplete(() {});

  //   return await imageRef.getDownloadURL();
  // }

  Future<void> _saveChatUser(ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('chat_users').doc(user.id);

    return docRef.set({
      'name': user.name,
      'email': user.email,
      'imageUrl': user.imageUrl,
    });
  }

  static ChatUser _toChatUser(User user, [String? imageUrl]) {
    return ChatUser(
      id: user.uid,
      name: user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      imageUrl: imageUrl ?? user.photoURL ?? 'assets/images/user.jpg',
    );
  }
}

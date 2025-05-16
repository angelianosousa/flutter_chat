import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_chat/core/models/chat_message.dart';
import 'package:my_chat/core/models/chat_user.dart';
import 'package:my_chat/core/services/chat/chat_service.dart';

class ChatFirebaseService implements ChatService {
  @override
  Stream<List<ChatMessage>> messagesStream() {
    final store = FirebaseFirestore.instance;
    final snapshots =
        store
            .collection('chat')
            .withConverter(
              fromFirestore: _fromFirestore,
              toFirestore: _toFirestore,
            )
            .orderBy('createdAt', descending: true)
            .snapshots();

    return Stream<List<ChatMessage>>.multi((controller) {
      snapshots.listen((snap) {
        List<ChatMessage> listMessages =
            snap.docs.map((doc) {
              return doc.data();
            }).toList();

        controller.add(listMessages);
      });
    });
  }

  @override
  Future<ChatMessage?> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;

    final msg = ChatMessage(
      id: '',
      text: text,
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
      createdAt: DateTime.now(),
    );

    final docRef = await store
        .collection('chat')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .add(msg);

    final doc = await docRef.get();
    return doc.data()!;
  }

  Map<String, dynamic> _toFirestore(ChatMessage message, SetOptions? options) {
    return {
      'text': message.text,
      'userId': message.userId,
      'userName': message.userName,
      'userImageUrl': message.userImageUrl,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  // Map<String, dynamic> => ChatMessage
  // Convert firebase data into a object
  ChatMessage _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    return ChatMessage(
      id: doc.id,
      text: doc['text'],
      userId: doc['userId'],
      userName: doc['userName'],
      userImageUrl: doc['userImageUrl'],
      createdAt: DateTime.parse(doc['createdAt']),
    );
  }
}

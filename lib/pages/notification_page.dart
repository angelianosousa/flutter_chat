import 'package:flutter/material.dart';
import 'package:my_chat/core/services/notification/push_notification_service.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = Provider.of<ChatNotificationService>(context);
    final items = notifications.items;

    return Scaffold(
      appBar: AppBar(title: Text('Notificações')),
      body: ListView.builder(
        itemCount: notifications.itemsCount,
        itemBuilder: (ctx, i) {
          return notifications.itemsCount > 0
              ? ListTile(
                title: Text(
                  items[i].title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(items[i].body),
                onTap: () {
                  notifications.remove(i);
                },
              )
              : Center(child: Text('Sem notificações'));
        },
      ),
    );
  }
}

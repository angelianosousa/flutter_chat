import 'package:flutter/material.dart';
import 'package:my_chat/core/services/notification/push_notification_service.dart';
import 'package:my_chat/pages/notification_page.dart';
import 'package:provider/provider.dart';

class NotificationBell extends StatelessWidget {
  final String quantityNotification;
  const NotificationBell(this.quantityNotification, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => NotificationPage()));
        }, icon: Icon(Icons.notifications)),
        Positioned(
          right: 10,
          bottom: 10,
          width: 15,
          child: CircleAvatar(
            backgroundColor: Colors.amber,
            child: Text(
              '${Provider.of<ChatNotificationService>(context).itemsCount}',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

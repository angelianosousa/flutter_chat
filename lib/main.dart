import 'package:flutter/material.dart';
import 'package:my_chat/core/services/notification/push_notification_service.dart';
import 'package:my_chat/pages/auth_or_app_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatNotificationService()),
      ],
      child: MaterialApp(
        title: 'My Chat',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.cyan.shade700,
            centerTitle: true,
            elevation: 15,
            foregroundColor: Colors.white,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan.shade700),
          primaryColor: Colors.cyan.shade700,
        ),
        home: const AuthOrAppPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

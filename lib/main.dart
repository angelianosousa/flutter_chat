import 'package:flutter/material.dart';
import 'package:my_chat/pages/auth_page.dart';
// import 'package:my_chat/pages/loading_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Chat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      ),
      home: const AuthPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

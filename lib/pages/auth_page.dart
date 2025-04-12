import 'package:flutter/material.dart';
import 'package:my_chat/components/auth_form.dart';
import 'package:my_chat/models/auth_data.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  void _handleSubmit(AuthData formData) {
    setState(() => _isLoading = true);
    print('AuthPage...');
    print(formData.email);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: AuthForm(onSubmit: _handleSubmit),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
              child: Center(
                child: CircularProgressIndicator()
              ),
            )
        ],
      ),
    );
  }
}

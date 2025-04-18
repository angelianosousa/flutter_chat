import 'package:flutter/material.dart';
import 'package:my_chat/components/auth_form.dart';
import 'package:my_chat/core/models/auth_data.dart';
import 'package:my_chat/core/services/auth/auth_service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthData formData) async {
    try {
      setState(() => _isLoading = true);
      if (formData.isSignin) {
        await AuthService().signIn(formData.email, formData.password);
      } else {
        await AuthService().signUp(
          formData.name,
          formData.email,
          formData.password,
          formData.avatar, 
        );
      }
    } catch (error) {
    } finally {
      setState(() => _isLoading = false);
    }
    // print('AuthPage...');
    // print(formData.email);
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
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}

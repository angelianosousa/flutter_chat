import 'package:flutter/material.dart';
import 'package:my_chat/models/auth_data.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthData) onSubmit;

  const AuthForm({super.key, required this.onSubmit});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _authData = AuthData();

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    widget.onSubmit(_authData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              if (_authData.isSignup)
                TextFormField(
                  key: ValueKey('name'),
                  initialValue: _authData.name,
                  onChanged: (name) => _authData.name = name,
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (formName) {
                    final name = formName ?? '';

                    if (name.trim().length < 5) {
                      return 'Nome deve ter pelo menos 5 caracteres';
                    }
                    return null;
                  },
                ),
              SizedBox(height: 10),
              TextFormField(
                key: ValueKey('email'),
                initialValue: _authData.email,
                onChanged: (email) => _authData.email = email,
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: (formEmail) {
                  final email = formEmail ?? '';

                  if (email.trim().isEmpty || !email.contains('@')) {
                    return 'Informe um e-mail válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                key: ValueKey('password'),
                initialValue: _authData.password,
                onChanged: (password) => _authData.password = password,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Senha'),
                validator: (formPass) {
                  final password = formPass ?? '';

                  if (password.trim().isEmpty || password.length > 6) {
                    return 'Senha deve ter pelo menos 6 caracteres';
                  }

                  return null;
                },
              ),
              SizedBox(height: 10),
              if (_authData.isSignup)
                TextFormField(
                  key: ValueKey('confirmPassword'),
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Confirmar senha'),
                  validator: (formConfirmPass) {
                    final confirmPass = formConfirmPass ?? '';

                    if (confirmPass != _authData.password) {
                      return 'As senhas estão diferentes';
                    }

                    return null;
                  },
                ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 10,
                ),
                onPressed: _submit,
                child: Text(_authData.isSignin ? 'Entrar' : 'Registrar'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  setState(() => _authData.toggleAuthMode());
                },
                child: Text(_authData.isSignin ? 'Criar conta' : 'Fazer login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

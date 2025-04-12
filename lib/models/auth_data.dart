import 'dart:io';

enum AuthMode { SignIn, SignUp }

class AuthData {
  String name = '';
  String email = '';
  String password = '';
  File? avatar;
  AuthMode _authMode = AuthMode.SignIn;

  bool get isSignin {
    return _authMode == AuthMode.SignIn;
  }

  bool get isSignup {
    return _authMode == AuthMode.SignUp;
  }

  void toggleAuthMode() {
    _authMode = isSignin ? AuthMode.SignUp : AuthMode.SignIn;
  }
}

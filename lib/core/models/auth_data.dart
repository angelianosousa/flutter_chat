import 'dart:io';

enum AuthMode { signIn, signUp }

class AuthData {
  String name = '';
  String email = '';
  String password = '';
  File? avatar;
  AuthMode _authMode = AuthMode.signIn;

  bool get isSignin {
    return _authMode == AuthMode.signIn;
  }

  bool get isSignup {
    return _authMode == AuthMode.signUp;
  }

  bool get hasAvatar {
    return avatar != null;
  }

  void toggleAuthMode() {
    _authMode = isSignin ? AuthMode.signUp : AuthMode.signIn;
  }
}

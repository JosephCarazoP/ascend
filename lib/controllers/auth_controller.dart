import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../services/auth_service.dart';
import '../services/user_service.dart';

class AuthController {
  AuthController({
    required AuthService authService,
    required UserService userService,
  }) : _authService = authService,
       _userService = userService;

  final AuthService _authService;
  final UserService _userService;

  Future<void> login(String email, String password) async {
    await _authService.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<void> register(String email, String password) async {
    final normalizedEmail = email.trim();
    final credential = await _createOrRecoverAuthUser(
      email: normalizedEmail,
      password: password,
    );
    final firebaseUser = credential.user;

    if (firebaseUser == null) {
      throw StateError('No se pudo crear el usuario.');
    }

    await _userService.ensureUserProfile(
      userId: firebaseUser.uid,
      email: firebaseUser.email ?? normalizedEmail,
      displayName: firebaseUser.displayName,
    );
  }

  Future<void> logout() {
    return _authService.signOut();
  }

  Future<void> resetPassword(String email) {
    return _authService.sendPasswordResetEmail(email.trim());
  }

  Future<firebase_auth.UserCredential> _createOrRecoverAuthUser({
    required String email,
    required String password,
  }) async {
    try {
      return await _authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (error) {
      if (error.code != 'email-already-in-use') {
        rethrow;
      }

      return _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    }
  }
}

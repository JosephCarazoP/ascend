import '../models/user.dart';
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

  Future<void> register(String email, String password, String rol) async {
    final credential = await _authService.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final firebaseUser = credential.user;

    if (firebaseUser == null) {
      throw StateError('No se pudo crear el usuario.');
    }

    final now = DateTime.now();
    final user = AppUser(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? email.trim(),
      role: _normalizeRole(rol),
      planType: 'basic',
      createdAt: now,
      updatedAt: now,
    );

    await _userService.saveUser(user);
  }

  Future<void> logout() {
    return _authService.signOut();
  }

  Future<void> resetPassword(String email) {
    return _authService.sendPasswordResetEmail(email.trim());
  }

  String _normalizeRole(String role) {
    if (role == 'admin' || role == 'coach' || role == 'usuario') {
      return role;
    }

    return 'usuario';
  }
}

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/navigation_controller.dart';
import '../controllers/role_controller.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import '../views/auth/login_screen.dart';

class RouteGuard extends StatelessWidget {
  const RouteGuard({
    super.key,
    required this.requiredRole,
    required this.child,
  });

  final String requiredRole;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();

    return StreamBuilder<firebase_auth.User?>(
      stream: authService.authStateChanges,
      builder: (context, authSnapshot) {
        if (authSnapshot.connectionState == ConnectionState.waiting) {
          return const _GuardLoading();
        }

        final firebaseUser = authSnapshot.data;

        if (firebaseUser == null) {
          return const LoginScreen();
        }

        return StreamBuilder<AppUser?>(
          stream: context.read<UserService>().watchUser(firebaseUser.uid),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const _GuardLoading();
            }

            final user = userSnapshot.data;

            if (user == null) {
              return const _UnauthorizedScreen(
                message: 'No se encontró el perfil del usuario.',
              );
            }

            final roleController = context.read<RoleController>();

            if (roleController.roleCanAccess(user.role, requiredRole)) {
              return child;
            }

            return _UnauthorizedScreen(
              message: 'No tienes acceso a esta sección.',
              destinationRoute: context
                  .read<NavigationController>()
                  .routeForUser(user),
            );
          },
        );
      },
    );
  }
}

class _GuardLoading extends StatelessWidget {
  const _GuardLoading();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class _UnauthorizedScreen extends StatelessWidget {
  const _UnauthorizedScreen({required this.message, this.destinationRoute});

  final String message;
  final String? destinationRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acceso restringido')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock_outline, size: 48),
              const SizedBox(height: 16),
              Text(message, textAlign: TextAlign.center),
              if (destinationRoute != null) ...[
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      destinationRoute!,
                      (route) => false,
                    );
                  },
                  child: const Text('Ir a mi inicio'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

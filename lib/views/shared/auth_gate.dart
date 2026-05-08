import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/navigation_controller.dart';
import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../../services/user_service.dart';
import '../auth/login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<firebase_auth.User?>(
      stream: context.read<AuthService>().authStateChanges,
      builder: (context, authSnapshot) {
        if (authSnapshot.connectionState == ConnectionState.waiting) {
          return const _LoadingScreen();
        }

        final firebaseUser = authSnapshot.data;

        if (firebaseUser == null) {
          return const LoginScreen();
        }

        return StreamBuilder<AppUser?>(
          stream: context.read<UserService>().watchUser(firebaseUser.uid),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const _LoadingScreen();
            }

            final appUser = userSnapshot.data;

            if (appUser == null) {
              return _ProfileRecoveryScreen(firebaseUser: firebaseUser);
            }

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!context.mounted) {
                return;
              }

              final route = context.read<NavigationController>().routeForUser(
                appUser,
              );
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(route, (route) => false);
            });

            return const _LoadingScreen();
          },
        );
      },
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class _ProfileRecoveryScreen extends StatefulWidget {
  const _ProfileRecoveryScreen({required this.firebaseUser});

  final firebase_auth.User firebaseUser;

  @override
  State<_ProfileRecoveryScreen> createState() => _ProfileRecoveryScreenState();
}

class _ProfileRecoveryScreenState extends State<_ProfileRecoveryScreen> {
  late Future<AppUser> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = _createProfile();
  }

  Future<AppUser> _createProfile() {
    return context.read<UserService>().ensureUserProfile(
      userId: widget.firebaseUser.uid,
      email: widget.firebaseUser.email ?? '',
      displayName: widget.firebaseUser.displayName,
    );
  }

  void _retry() {
    setState(() {
      _profileFuture = _createProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppUser>(
      future: _profileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const _LoadingScreen();
        }

        if (!snapshot.hasError) {
          return const _LoadingScreen();
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Perfil pendiente')),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person_add_alt_outlined,
                      size: 48,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No se pudo terminar tu perfil en Firestore.',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Intenta de nuevo. Si continúa, revisa que las reglas de Firestore estén publicadas.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: _retry,
                      child: const Text('Reintentar'),
                    ),
                    TextButton(
                      onPressed: () async {
                        await context.read<AuthService>().signOut();
                      },
                      child: const Text('Cerrar sesión'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

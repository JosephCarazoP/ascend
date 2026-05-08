import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../../services/user_service.dart';
import '../shared/theme_toggle_button.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.read<AuthService>().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ascend'),
        actions: [
          const ThemeToggleButton(),
          IconButton(
            tooltip: 'Cerrar sesión',
            onPressed: () async {
              await context.read<AuthService>().signOut();

              if (context.mounted) {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/', (route) => false);
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: firebaseUser == null
          ? const Center(child: Text('No hay sesión activa.'))
          : StreamBuilder<AppUser?>(
              stream: context.read<UserService>().watchUser(firebaseUser.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final user = snapshot.data;

                if (user == null) {
                  return const Center(child: Text('Perfil no encontrado.'));
                }

                return _UserHomeContent(firebaseUser: firebaseUser, user: user);
              },
            ),
    );
  }
}

class _UserHomeContent extends StatelessWidget {
  const _UserHomeContent({required this.firebaseUser, required this.user});

  final firebase_auth.User firebaseUser;
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final email = user.email.isEmpty ? firebaseUser.email ?? '' : user.email;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Mi perfil', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: Text(email),
            subtitle: Text('Rol: ${user.role} - Plan: ${user.planType}'),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.assignment_outlined),
            title: const Text('Solicitud de rutina'),
            subtitle: Text(
              user.coachId == null || user.coachId!.isEmpty
                  ? 'Pendiente de asignación de coach'
                  : 'Coach asignado: ${user.coachId}',
            ),
          ),
        ),
      ],
    );
  }
}

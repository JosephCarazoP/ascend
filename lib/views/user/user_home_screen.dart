import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/navigation_controller.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    final coachAssigned = user.coachId != null && user.coachId!.isNotEmpty;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Inicio', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: colorScheme.secondary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.account_circle_outlined,
                        color: colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        email,
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(label: Text('Rol: ${user.role}')),
                    Chip(label: Text('Plan: ${user.planType}')),
                    Chip(
                      avatar: Icon(
                        coachAssigned
                            ? Icons.check_circle_outline
                            : Icons.schedule_outlined,
                        size: 18,
                        color: coachAssigned
                            ? colorScheme.secondary
                            : colorScheme.onSurface,
                      ),
                      label: Text(
                        coachAssigned ? 'Coach asignado' : 'Sin coach',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        _ActionCard(
          icon: Icons.assignment_outlined,
          title: 'Solicitud de rutina',
          subtitle: coachAssigned
              ? 'Enviar una nueva solicitud'
              : 'Pendiente de asignación de coach',
          enabled: coachAssigned,
          onTap: () {
            Navigator.of(
              context,
            ).pushNamed(NavigationController.requestRoutineRoute);
          },
        ),
        const SizedBox(height: 8),
        _ActionCard(
          icon: Icons.history_outlined,
          title: 'Mis solicitudes',
          subtitle: 'Revisa el estado de tus solicitudes',
          onTap: () {
            Navigator.of(
              context,
            ).pushNamed(NavigationController.userRoutineRequestsRoute);
          },
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.enabled = true,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: ListTile(
        enabled: enabled,
        leading: Icon(
          icon,
          color: enabled ? colorScheme.secondary : colorScheme.onSurface,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: enabled ? onTap : null,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../../services/user_service.dart';
import '../shared/theme_toggle_button.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel Admin'),
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
      body: StreamBuilder<List<AppUser>>(
        stream: context.read<UserService>().watchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('No se pudieron cargar los usuarios.'),
            );
          }

          final users = snapshot.data ?? const [];
          final coaches = users.where((user) => user.role == 'coach').toList();

          if (users.isEmpty) {
            return const Center(child: Text('No hay usuarios registrados.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: users.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final user = users[index];
              final canAssignCoach =
                  user.role == 'usuario' || user.role == 'user';

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.email,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Chip(label: Text('Rol: ${_roleLabel(user.role)}')),
                          Chip(label: Text('Plan: ${user.planType}')),
                          if (user.coachId != null && user.coachId!.isNotEmpty)
                            Chip(label: Text('Coach: ${user.coachId}')),
                        ],
                      ),
                      if (canAssignCoach) ...[
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          value: _coachValue(user.coachId, coaches),
                          decoration: const InputDecoration(
                            labelText: 'Coach asignado',
                            border: OutlineInputBorder(),
                          ),
                          items: [
                            const DropdownMenuItem<String>(
                              value: '',
                              child: Text('Sin coach'),
                            ),
                            ...coaches.map(
                              (coach) => DropdownMenuItem<String>(
                                value: coach.id,
                                child: Text(coach.email),
                              ),
                            ),
                          ],
                          onChanged: (coachId) async {
                            await context.read<UserService>().assignCoachToUser(
                              userId: user.id,
                              coachId: coachId == null || coachId.isEmpty
                                  ? null
                                  : coachId,
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _roleLabel(String role) {
    switch (role) {
      case 'admin':
        return 'Admin';
      case 'coach':
        return 'Coach';
      default:
        return 'Usuario';
    }
  }

  String _coachValue(String? coachId, List<AppUser> coaches) {
    if (coachId == null || coachId.isEmpty) {
      return '';
    }

    return coaches.any((coach) => coach.id == coachId) ? coachId : '';
  }
}

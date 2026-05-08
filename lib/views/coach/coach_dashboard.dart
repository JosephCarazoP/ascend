import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../../services/user_service.dart';
import '../shared/theme_toggle_button.dart';

class CoachDashboard extends StatelessWidget {
  const CoachDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final coachId = context.read<AuthService>().currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel Coach'),
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
      body: coachId == null
          ? const Center(child: Text('No hay sesión activa.'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Clientes asignados',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                StreamBuilder<List<AppUser>>(
                  stream: context.read<UserService>().watchClientsForCoach(
                    coachId,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Text('No se pudieron cargar los clientes.');
                    }

                    final clients = snapshot.data ?? const [];

                    if (clients.isEmpty) {
                      return const Text(
                        'Todavía no tienes clientes asignados.',
                      );
                    }

                    return Column(
                      children: clients
                          .map(
                            (client) => Card(
                              child: ListTile(
                                leading: const Icon(Icons.person_outline),
                                title: Text(client.email),
                                subtitle: Text('Plan: ${client.planType}'),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
                const SizedBox(height: 24),
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.assignment_outlined),
                    title: Text('Solicitudes de rutina'),
                    subtitle: Text('Disponible en la etapa 3'),
                  ),
                ),
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.fitness_center_outlined),
                    title: Text('Rutinas'),
                    subtitle: Text('Disponible en la etapa 4'),
                  ),
                ),
              ],
            ),
    );
  }
}

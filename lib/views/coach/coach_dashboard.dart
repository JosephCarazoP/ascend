import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/navigation_controller.dart';
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
                  'Panel Coach',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.assignment_outlined,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    title: const Text('Solicitudes de rutina'),
                    subtitle: const Text('Revisar solicitudes de clientes'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        NavigationController.coachRoutineRequestsRoute,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.fitness_center_outlined),
                    title: Text('Rutinas'),
                    subtitle: Text('Disponible en la etapa 4'),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Clientes asignados',
                  style: Theme.of(context).textTheme.titleLarge,
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
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Todavía no tienes clientes asignados.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      );
                    }

                    return Column(
                      children: clients
                          .map(
                            (client) => Card(
                              child: ListTile(
                                leading: Icon(
                                  Icons.person_outline,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                                title: Text(client.email),
                                subtitle: Text('Plan: ${client.planType}'),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ],
            ),
    );
  }
}

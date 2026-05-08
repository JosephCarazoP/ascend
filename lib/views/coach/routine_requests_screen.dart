import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/navigation_controller.dart';
import '../../controllers/routine_request_controller.dart';
import '../../models/routine_request.dart';
import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../../services/user_service.dart';
import '../../utils/date_formatter.dart';
import '../shared/status_chip.dart';
import '../shared/theme_toggle_button.dart';

class RoutineRequestsScreen extends StatelessWidget {
  const RoutineRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final coachId = context.read<AuthService>().currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes'),
        actions: const [ThemeToggleButton()],
      ),
      body: coachId == null
          ? const Center(child: Text('No hay sesión activa.'))
          : StreamBuilder<AppUser?>(
              stream: context.read<UserService>().watchUser(coachId),
              builder: (context, currentUserSnapshot) {
                if (currentUserSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final currentUser = currentUserSnapshot.data;
                final isAdmin = currentUser?.role == 'admin';

                return StreamBuilder<List<AppUser>>(
                  stream: isAdmin
                      ? context.read<UserService>().watchUsers()
                      : context.read<UserService>().watchClientsForCoach(
                          coachId,
                        ),
                  builder: (context, clientsSnapshot) {
                    if (clientsSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final clients = clientsSnapshot.data ?? const [];
                    final clientsById = {
                      for (final client in clients) client.id: client,
                    };

                    return StreamBuilder<List<RoutineRequest>>(
                      stream: isAdmin
                          ? context
                                .read<RoutineRequestController>()
                                .getAllRequests()
                          : context
                                .read<RoutineRequestController>()
                                .getRequestsByCoach(coachId),
                      builder: (context, requestsSnapshot) {
                        if (requestsSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (requestsSnapshot.hasError) {
                          return const Center(
                            child: Text(
                              'No se pudieron cargar las solicitudes.',
                            ),
                          );
                        }

                        final requests = requestsSnapshot.data ?? const [];

                        if (requests.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(24),
                              child: Text('No hay solicitudes asignadas.'),
                            ),
                          );
                        }

                        return ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: requests.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final request = requests[index];
                            final client = clientsById[request.userId];

                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.assignment_outlined),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            request.goal,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleMedium,
                                          ),
                                        ),
                                        StatusChip(status: request.status),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(client?.email ?? request.userId),
                                    Text(
                                      '${request.experienceLevel} - '
                                      '${formatShortDate(request.createdAt)}',
                                    ),
                                    const SizedBox(height: 12),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton.icon(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                            NavigationController
                                                .coachRoutineRequestDetailRoute,
                                            arguments: request,
                                          );
                                        },
                                        icon: const Icon(Icons.chevron_right),
                                        label: const Text('Ver detalle'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
      bottomNavigationBar: coachId == null
          ? null
          : Padding(
              padding: const EdgeInsets.all(16),
              child: _RequestStatusLegend(),
            ),
    );
  }
}

class _RequestStatusLegend extends StatelessWidget {
  const _RequestStatusLegend();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        StatusChip(status: 'pending'),
        StatusChip(status: 'reviewed'),
        StatusChip(status: 'assigned'),
        StatusChip(status: 'rejected'),
      ],
    );
  }
}

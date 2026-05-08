import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/routine_request_controller.dart';
import '../../models/routine_request.dart';
import '../../services/auth_service.dart';
import '../../utils/date_formatter.dart';
import '../shared/status_chip.dart';
import '../shared/theme_toggle_button.dart';

class MyRoutineRequestsScreen extends StatelessWidget {
  const MyRoutineRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = context.read<AuthService>().currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis solicitudes'),
        actions: const [ThemeToggleButton()],
      ),
      body: userId == null
          ? const Center(child: Text('No hay sesión activa.'))
          : StreamBuilder<List<RoutineRequest>>(
              stream: context
                  .read<RoutineRequestController>()
                  .getRequestsByUser(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('No se pudieron cargar tus solicitudes.'),
                  );
                }

                final requests = snapshot.data ?? const [];

                if (requests.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text('Todavía no has enviado solicitudes.'),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: requests.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final request = requests[index];

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
                            Text('Coach: ${request.coachId}'),
                            Text(
                              'Fecha: ${formatShortDate(request.createdAt)}',
                            ),
                            if (_routineText(request).isNotEmpty)
                              Text(_routineText(request)),
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

  String _routineText(RoutineRequest request) {
    final routineId = request.assignedRoutineId;

    if (routineId == null || routineId.isEmpty) {
      return '';
    }

    return 'Rutina: $routineId';
  }
}

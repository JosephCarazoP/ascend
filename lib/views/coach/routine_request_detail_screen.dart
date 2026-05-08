import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/routine_request_controller.dart';
import '../../models/routine_request.dart';
import '../../utils/date_formatter.dart';
import '../shared/status_chip.dart';
import '../shared/theme_toggle_button.dart';

class RoutineRequestDetailScreen extends StatefulWidget {
  const RoutineRequestDetailScreen({super.key, required this.request});

  final RoutineRequest request;

  @override
  State<RoutineRequestDetailScreen> createState() =>
      _RoutineRequestDetailScreenState();
}

class _RoutineRequestDetailScreenState
    extends State<RoutineRequestDetailScreen> {
  late RoutineRequest _request;
  late final TextEditingController _notesController;
  late final TextEditingController _routineIdController;

  @override
  void initState() {
    super.initState();
    _request = widget.request;
    _notesController = TextEditingController(text: _request.coachNotes ?? '');
    _routineIdController = TextEditingController(
      text: _request.assignedRoutineId ?? '',
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    _routineIdController.dispose();
    super.dispose();
  }

  Future<void> _updateStatus(String status) async {
    try {
      await context.read<RoutineRequestController>().updateRequestStatus(
        _request.id,
        status,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _request = _request.copyWith(
          status: status,
          reviewedAt: DateTime.now(),
        );
      });
    } catch (_) {
      _showError();
    }
  }

  Future<void> _saveNotes() async {
    try {
      await context.read<RoutineRequestController>().addCoachNotes(
        _request.id,
        _notesController.text.trim(),
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _request = _request.copyWith(coachNotes: _notesController.text.trim());
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Notas guardadas.')));
    } catch (_) {
      _showError();
    }
  }

  Future<void> _assignRoutine() async {
    final routineId = _routineIdController.text.trim();

    if (routineId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa un ID de rutina existente.')),
      );
      return;
    }

    try {
      await context.read<RoutineRequestController>().assignRoutineToRequest(
        _request.id,
        routineId,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _request = _request.copyWith(
          status: 'assigned',
          assignedRoutineId: routineId,
          reviewedAt: DateTime.now(),
        );
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Rutina asociada.')));
    } catch (_) {
      _showError();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RoutineRequestController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle solicitud'),
        actions: const [ThemeToggleButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _request.goal,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              StatusChip(status: _request.status),
            ],
          ),
          const SizedBox(height: 12),
          _InfoCard(
            children: [
              _InfoRow(label: 'Usuario', value: _request.userId),
              _InfoRow(label: 'Coach', value: _request.coachId),
              _InfoRow(
                label: 'Fecha',
                value: formatShortDate(_request.createdAt),
              ),
              _InfoRow(
                label: 'Revisada',
                value: formatShortDate(_request.reviewedAt),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _InfoCard(
            children: [
              _InfoRow(label: 'Nivel', value: _request.experienceLevel),
              _InfoRow(
                label: 'Dias',
                value: '${_request.trainingDaysAvailable} por semana',
              ),
              _InfoRow(label: 'Lugar', value: _request.trainingPlace),
              _InfoRow(
                label: 'Equipo',
                value: _request.equipment.isEmpty
                    ? 'Sin equipo registrado'
                    : _request.equipment.join(', '),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _InfoCard(
            children: [
              _InfoRow(
                label: 'Limitaciones',
                value: _request.limitations ?? 'Sin limitaciones registradas',
              ),
              _InfoRow(
                label: 'Lesiones/notas',
                value: _request.injuriesOrNotes ?? 'Sin notas registradas',
              ),
              ..._request.answers.entries.map(
                (entry) => _InfoRow(
                  label: _answerLabel(entry.key),
                  value: entry.value.toString().trim().isEmpty
                      ? 'Sin respuesta'
                      : entry.value.toString(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _notesController,
            minLines: 3,
            maxLines: 6,
            decoration: const InputDecoration(
              labelText: 'Notas del coach',
              prefixIcon: Icon(Icons.edit_note_outlined),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: controller.isLoading ? null : _saveNotes,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Guardar notas'),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: controller.isLoading
                    ? null
                    : () => _updateStatus('reviewed'),
                icon: const Icon(Icons.visibility_outlined),
                label: const Text('Marcar revisada'),
              ),
              OutlinedButton.icon(
                onPressed: controller.isLoading
                    ? null
                    : () => _updateStatus('rejected'),
                icon: const Icon(Icons.cancel_outlined),
                label: const Text('Rechazar'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _routineIdController,
            decoration: const InputDecoration(
              labelText: 'ID de rutina existente',
              prefixIcon: Icon(Icons.fitness_center_outlined),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: controller.isLoading ? null : _assignRoutine,
            icon: const Icon(Icons.link_outlined),
            label: const Text('Asociar rutina'),
          ),
          const SizedBox(height: 12),
          const OutlinedButton(
            onPressed: null,
            child: Text('Crear rutina disponible en etapa 4'),
          ),
        ],
      ),
    );
  }

  String _answerLabel(String key) {
    switch (key) {
      case 'preferredSchedule':
        return 'Horario preferido';
      case 'sessionDuration':
        return 'Duracion';
      case 'extraNotes':
        return 'Preguntas adicionales';
      default:
        return key;
    }
  }

  void _showError() {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No se pudo actualizar la solicitud.')),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: children),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 112,
            child: Text(label, style: Theme.of(context).textTheme.labelLarge),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

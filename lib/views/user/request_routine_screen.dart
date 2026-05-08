import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/routine_request_controller.dart';
import '../../models/routine_request.dart';
import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../../services/user_service.dart';
import '../shared/theme_toggle_button.dart';

class RequestRoutineScreen extends StatefulWidget {
  const RequestRoutineScreen({super.key});

  @override
  State<RequestRoutineScreen> createState() => _RequestRoutineScreenState();
}

class _RequestRoutineScreenState extends State<RequestRoutineScreen> {
  final _formKey = GlobalKey<FormState>();
  final _limitationsController = TextEditingController();
  final _injuriesController = TextEditingController();
  final _preferredScheduleController = TextEditingController();
  final _sessionDurationController = TextEditingController();
  final _extraNotesController = TextEditingController();

  String _goal = 'Ganar masa muscular';
  String _experienceLevel = 'Principiante';
  int _trainingDaysAvailable = 3;
  String _trainingPlace = 'Gimnasio';
  final Set<String> _equipment = {'Maquinas'};
  String? _successMessage;

  static const List<String> _equipmentOptions = [
    'Peso corporal',
    'Mancuernas',
    'Barra',
    'Maquinas',
    'Bandas',
    'Cardio',
  ];

  @override
  void dispose() {
    _limitationsController.dispose();
    _injuriesController.dispose();
    _preferredScheduleController.dispose();
    _sessionDurationController.dispose();
    _extraNotesController.dispose();
    super.dispose();
  }

  Future<void> _submit(AppUser user) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_equipment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona al menos un equipo.')),
      );
      return;
    }

    final coachId = user.coachId;

    if (coachId == null || coachId.isEmpty) {
      setState(() {
        _successMessage = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Necesitas un coach asignado.')),
      );
      return;
    }

    final request = RoutineRequest(
      id: '',
      userId: user.id,
      coachId: coachId,
      status: 'pending',
      goal: _goal,
      experienceLevel: _experienceLevel,
      trainingDaysAvailable: _trainingDaysAvailable,
      trainingPlace: _trainingPlace,
      equipment: _equipment.toList()..sort(),
      limitations: _optionalText(_limitationsController.text),
      injuriesOrNotes: _optionalText(_injuriesController.text),
      answers: {
        'preferredSchedule': _preferredScheduleController.text.trim(),
        'sessionDuration': _sessionDurationController.text.trim(),
        'extraNotes': _extraNotesController.text.trim(),
      },
      createdAt: DateTime.now(),
    );

    try {
      await context.read<RoutineRequestController>().createRequest(request);

      if (!mounted) {
        return;
      }

      _formKey.currentState!.reset();
      _limitationsController.clear();
      _injuriesController.clear();
      _preferredScheduleController.clear();
      _sessionDurationController.clear();
      _extraNotesController.clear();

      setState(() {
        _goal = 'Ganar masa muscular';
        _experienceLevel = 'Principiante';
        _trainingDaysAvailable = 3;
        _trainingPlace = 'Gimnasio';
        _equipment
          ..clear()
          ..add('Maquinas');
        _successMessage = 'Solicitud enviada al coach.';
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo enviar la solicitud.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.read<AuthService>().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitar rutina'),
        actions: const [ThemeToggleButton()],
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

                return _RequestForm(
                  user: user,
                  formKey: _formKey,
                  goal: _goal,
                  experienceLevel: _experienceLevel,
                  trainingDaysAvailable: _trainingDaysAvailable,
                  trainingPlace: _trainingPlace,
                  equipment: _equipment,
                  equipmentOptions: _equipmentOptions,
                  limitationsController: _limitationsController,
                  injuriesController: _injuriesController,
                  preferredScheduleController: _preferredScheduleController,
                  sessionDurationController: _sessionDurationController,
                  extraNotesController: _extraNotesController,
                  successMessage: _successMessage,
                  onGoalChanged: (value) => setState(() => _goal = value),
                  onExperienceChanged: (value) =>
                      setState(() => _experienceLevel = value),
                  onDaysChanged: (value) =>
                      setState(() => _trainingDaysAvailable = value),
                  onPlaceChanged: (value) =>
                      setState(() => _trainingPlace = value),
                  onEquipmentChanged: _toggleEquipment,
                  onSubmit: () => _submit(user),
                );
              },
            ),
    );
  }

  void _toggleEquipment(String equipment, bool selected) {
    setState(() {
      if (selected) {
        _equipment.add(equipment);
      } else {
        _equipment.remove(equipment);
      }
    });
  }

  String? _optionalText(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}

class _RequestForm extends StatelessWidget {
  const _RequestForm({
    required this.user,
    required this.formKey,
    required this.goal,
    required this.experienceLevel,
    required this.trainingDaysAvailable,
    required this.trainingPlace,
    required this.equipment,
    required this.equipmentOptions,
    required this.limitationsController,
    required this.injuriesController,
    required this.preferredScheduleController,
    required this.sessionDurationController,
    required this.extraNotesController,
    required this.onGoalChanged,
    required this.onExperienceChanged,
    required this.onDaysChanged,
    required this.onPlaceChanged,
    required this.onEquipmentChanged,
    required this.onSubmit,
    this.successMessage,
  });

  final AppUser user;
  final GlobalKey<FormState> formKey;
  final String goal;
  final String experienceLevel;
  final int trainingDaysAvailable;
  final String trainingPlace;
  final Set<String> equipment;
  final List<String> equipmentOptions;
  final TextEditingController limitationsController;
  final TextEditingController injuriesController;
  final TextEditingController preferredScheduleController;
  final TextEditingController sessionDurationController;
  final TextEditingController extraNotesController;
  final ValueChanged<String> onGoalChanged;
  final ValueChanged<String> onExperienceChanged;
  final ValueChanged<int> onDaysChanged;
  final ValueChanged<String> onPlaceChanged;
  final void Function(String equipment, bool selected) onEquipmentChanged;
  final VoidCallback onSubmit;
  final String? successMessage;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RoutineRequestController>();
    final hasCoach = user.coachId != null && user.coachId!.isNotEmpty;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Cuéntale a tu coach qué necesitas',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        if (!hasCoach)
          const Card(
            child: ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Aún no tienes coach asignado'),
              subtitle: Text(
                'Un admin debe asignarte un coach antes de enviar.',
              ),
            ),
          ),
        if (successMessage != null) ...[
          Card(
            child: ListTile(
              leading: Icon(
                Icons.check_circle_outline,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: Text(successMessage!),
            ),
          ),
          const SizedBox(height: 12),
        ],
        Form(
          key: formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: goal,
                decoration: const InputDecoration(
                  labelText: 'Objetivo principal',
                  prefixIcon: Icon(Icons.flag_outlined),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Ganar masa muscular',
                    child: Text('Ganar masa muscular'),
                  ),
                  DropdownMenuItem(
                    value: 'Perder grasa',
                    child: Text('Perder grasa'),
                  ),
                  DropdownMenuItem(value: 'Fuerza', child: Text('Fuerza')),
                  DropdownMenuItem(
                    value: 'Salud general',
                    child: Text('Salud general'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    onGoalChanged(value);
                  }
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: experienceLevel,
                decoration: const InputDecoration(
                  labelText: 'Nivel de experiencia',
                  prefixIcon: Icon(Icons.trending_up_outlined),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Principiante',
                    child: Text('Principiante'),
                  ),
                  DropdownMenuItem(
                    value: 'Intermedio',
                    child: Text('Intermedio'),
                  ),
                  DropdownMenuItem(value: 'Avanzado', child: Text('Avanzado')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    onExperienceChanged(value);
                  }
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<int>(
                value: trainingDaysAvailable,
                decoration: const InputDecoration(
                  labelText: 'Días disponibles por semana',
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                ),
                items: List.generate(
                  7,
                  (index) => DropdownMenuItem(
                    value: index + 1,
                    child: Text('${index + 1}'),
                  ),
                ),
                onChanged: (value) {
                  if (value != null) {
                    onDaysChanged(value);
                  }
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: trainingPlace,
                decoration: const InputDecoration(
                  labelText: 'Lugar de entrenamiento',
                  prefixIcon: Icon(Icons.place_outlined),
                ),
                items: const [
                  DropdownMenuItem(value: 'Casa', child: Text('Casa')),
                  DropdownMenuItem(value: 'Gimnasio', child: Text('Gimnasio')),
                  DropdownMenuItem(value: 'Ambos', child: Text('Ambos')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    onPlaceChanged(value);
                  }
                },
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Equipo disponible',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 8),
              ...equipmentOptions.map(
                (option) => CheckboxListTile(
                  value: equipment.contains(option),
                  onChanged: (value) =>
                      onEquipmentChanged(option, value ?? false),
                  title: Text(option),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: limitationsController,
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Limitaciones',
                  prefixIcon: Icon(Icons.block_outlined),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: injuriesController,
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Lesiones o notas',
                  prefixIcon: Icon(Icons.medical_information_outlined),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: preferredScheduleController,
                decoration: const InputDecoration(
                  labelText: 'Horario preferido',
                  prefixIcon: Icon(Icons.schedule_outlined),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: sessionDurationController,
                decoration: const InputDecoration(
                  labelText: 'Duración ideal por sesión',
                  prefixIcon: Icon(Icons.timer_outlined),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: extraNotesController,
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Preguntas adicionales',
                  prefixIcon: Icon(Icons.notes_outlined),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: hasCoach && !controller.isLoading ? onSubmit : null,
                icon: controller.isLoading
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send_outlined),
                label: const Text('Enviar solicitud'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

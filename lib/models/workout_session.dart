import '../utils/json_converters.dart';
import 'exercise_log.dart';

class WorkoutSession {
  const WorkoutSession({
    required this.id,
    required this.userId,
    required this.routineId,
    this.logs = const [],
    this.startedAt,
    this.finishedAt,
    this.notes,
  });

  final String id;
  final String userId;
  final String routineId;
  final List<ExerciseLog> logs;
  final DateTime? startedAt;
  final DateTime? finishedAt;
  final String? notes;

  factory WorkoutSession.fromJson(Map<String, dynamic> json) {
    return WorkoutSession(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      routineId: json['routineId'] as String? ?? '',
      logs: mapListFromJson(json['logs']).map(ExerciseLog.fromJson).toList(),
      startedAt: dateTimeFromJson(json['startedAt']),
      finishedAt: dateTimeFromJson(json['finishedAt']),
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'routineId': routineId,
      'logs': logs.map((log) => log.toJson()).toList(),
      'startedAt': startedAt,
      'finishedAt': finishedAt,
      'notes': notes,
    };
  }

  WorkoutSession copyWith({
    String? id,
    String? userId,
    String? routineId,
    List<ExerciseLog>? logs,
    DateTime? startedAt,
    DateTime? finishedAt,
    String? notes,
  }) {
    return WorkoutSession(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      routineId: routineId ?? this.routineId,
      logs: logs ?? this.logs,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      notes: notes ?? this.notes,
    );
  }
}

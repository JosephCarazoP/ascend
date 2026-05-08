import '../utils/json_converters.dart';

class ExerciseLog {
  const ExerciseLog({
    required this.exerciseId,
    required this.sets,
    required this.reps,
    this.weight,
    this.notes,
    this.completedAt,
  });

  final String exerciseId;
  final int sets;
  final int reps;
  final double? weight;
  final String? notes;
  final DateTime? completedAt;

  factory ExerciseLog.fromJson(Map<String, dynamic> json) {
    return ExerciseLog(
      exerciseId: json['exerciseId'] as String? ?? '',
      sets: json['sets'] as int? ?? 0,
      reps: json['reps'] as int? ?? 0,
      weight: doubleFromJson(json['weight']),
      notes: json['notes'] as String?,
      completedAt: dateTimeFromJson(json['completedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'sets': sets,
      'reps': reps,
      'weight': weight,
      'notes': notes,
      'completedAt': completedAt,
    };
  }

  ExerciseLog copyWith({
    String? exerciseId,
    int? sets,
    int? reps,
    double? weight,
    String? notes,
    DateTime? completedAt,
  }) {
    return ExerciseLog(
      exerciseId: exerciseId ?? this.exerciseId,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      notes: notes ?? this.notes,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}

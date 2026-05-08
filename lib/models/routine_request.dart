import '../utils/json_converters.dart';

class RoutineRequest {
  const RoutineRequest({
    required this.id,
    required this.userId,
    required this.coachId,
    required this.status,
    required this.goal,
    required this.experienceLevel,
    required this.trainingDaysAvailable,
    required this.trainingPlace,
    this.equipment = const [],
    this.limitations,
    this.injuriesOrNotes,
    this.answers = const {},
    this.createdAt,
    this.reviewedAt,
    this.assignedRoutineId,
    this.coachNotes,
  });

  final String id;
  final String userId;
  final String coachId;
  final String status;
  final String goal;
  final String experienceLevel;
  final int trainingDaysAvailable;
  final String trainingPlace;
  final List<String> equipment;
  final String? limitations;
  final String? injuriesOrNotes;
  final Map<String, dynamic> answers;
  final DateTime? createdAt;
  final DateTime? reviewedAt;
  final String? assignedRoutineId;
  final String? coachNotes;

  factory RoutineRequest.fromJson(Map<String, dynamic> json) {
    return RoutineRequest(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      coachId: json['coachId'] as String? ?? '',
      status: json['status'] as String? ?? 'pending',
      goal: json['goal'] as String? ?? '',
      experienceLevel: json['experienceLevel'] as String? ?? '',
      trainingDaysAvailable: json['trainingDaysAvailable'] as int? ?? 0,
      trainingPlace: json['trainingPlace'] as String? ?? '',
      equipment: stringListFromJson(json['equipment']),
      limitations: json['limitations'] as String?,
      injuriesOrNotes: json['injuriesOrNotes'] as String?,
      answers: dynamicMapFromJson(json['answers']),
      createdAt: dateTimeFromJson(json['createdAt']),
      reviewedAt: dateTimeFromJson(json['reviewedAt']),
      assignedRoutineId: json['assignedRoutineId'] as String?,
      coachNotes: json['coachNotes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'coachId': coachId,
      'status': status,
      'goal': goal,
      'experienceLevel': experienceLevel,
      'trainingDaysAvailable': trainingDaysAvailable,
      'trainingPlace': trainingPlace,
      'equipment': equipment,
      'limitations': limitations,
      'injuriesOrNotes': injuriesOrNotes,
      'answers': answers,
      'createdAt': createdAt,
      'reviewedAt': reviewedAt,
      'assignedRoutineId': assignedRoutineId,
      'coachNotes': coachNotes,
    };
  }

  RoutineRequest copyWith({
    String? id,
    String? userId,
    String? coachId,
    String? status,
    String? goal,
    String? experienceLevel,
    int? trainingDaysAvailable,
    String? trainingPlace,
    List<String>? equipment,
    String? limitations,
    String? injuriesOrNotes,
    Map<String, dynamic>? answers,
    DateTime? createdAt,
    DateTime? reviewedAt,
    String? assignedRoutineId,
    String? coachNotes,
  }) {
    return RoutineRequest(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      coachId: coachId ?? this.coachId,
      status: status ?? this.status,
      goal: goal ?? this.goal,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      trainingDaysAvailable:
          trainingDaysAvailable ?? this.trainingDaysAvailable,
      trainingPlace: trainingPlace ?? this.trainingPlace,
      equipment: equipment ?? this.equipment,
      limitations: limitations ?? this.limitations,
      injuriesOrNotes: injuriesOrNotes ?? this.injuriesOrNotes,
      answers: answers ?? this.answers,
      createdAt: createdAt ?? this.createdAt,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      assignedRoutineId: assignedRoutineId ?? this.assignedRoutineId,
      coachNotes: coachNotes ?? this.coachNotes,
    );
  }
}

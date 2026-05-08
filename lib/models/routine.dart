import '../utils/json_converters.dart';

class Routine {
  const Routine({
    required this.id,
    required this.name,
    required this.coachId,
    this.userId,
    this.description,
    this.exerciseIds = const [],
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String name;
  final String coachId;
  final String? userId;
  final String? description;
  final List<String> exerciseIds;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Routine.fromJson(Map<String, dynamic> json) {
    return Routine(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      coachId: json['coachId'] as String? ?? '',
      userId: json['userId'] as String?,
      description: json['description'] as String?,
      exerciseIds: stringListFromJson(json['exerciseIds']),
      createdAt: dateTimeFromJson(json['createdAt']),
      updatedAt: dateTimeFromJson(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'coachId': coachId,
      'userId': userId,
      'description': description,
      'exerciseIds': exerciseIds,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  Routine copyWith({
    String? id,
    String? name,
    String? coachId,
    String? userId,
    String? description,
    List<String>? exerciseIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Routine(
      id: id ?? this.id,
      name: name ?? this.name,
      coachId: coachId ?? this.coachId,
      userId: userId ?? this.userId,
      description: description ?? this.description,
      exerciseIds: exerciseIds ?? this.exerciseIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

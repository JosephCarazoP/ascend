import '../utils/json_converters.dart';

class Exercise {
  const Exercise({
    required this.id,
    required this.name,
    required this.muscleGroup,
    this.description,
    this.equipment,
    this.videoUrl,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String name;
  final String muscleGroup;
  final String? description;
  final String? equipment;
  final String? videoUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      muscleGroup: json['muscleGroup'] as String? ?? '',
      description: json['description'] as String?,
      equipment: json['equipment'] as String?,
      videoUrl: json['videoUrl'] as String?,
      createdAt: dateTimeFromJson(json['createdAt']),
      updatedAt: dateTimeFromJson(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'muscleGroup': muscleGroup,
      'description': description,
      'equipment': equipment,
      'videoUrl': videoUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  Exercise copyWith({
    String? id,
    String? name,
    String? muscleGroup,
    String? description,
    String? equipment,
    String? videoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      description: description ?? this.description,
      equipment: equipment ?? this.equipment,
      videoUrl: videoUrl ?? this.videoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

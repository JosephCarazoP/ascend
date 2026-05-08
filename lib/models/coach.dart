import '../utils/json_converters.dart';

class Coach {
  const Coach({
    required this.id,
    required this.userId,
    this.bio,
    this.specialty,
    this.clientIds = const [],
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String userId;
  final String? bio;
  final String? specialty;
  final List<String> clientIds;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      bio: json['bio'] as String?,
      specialty: json['specialty'] as String?,
      clientIds: stringListFromJson(json['clientIds']),
      createdAt: dateTimeFromJson(json['createdAt']),
      updatedAt: dateTimeFromJson(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'bio': bio,
      'specialty': specialty,
      'clientIds': clientIds,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  Coach copyWith({
    String? id,
    String? userId,
    String? bio,
    String? specialty,
    List<String>? clientIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Coach(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      bio: bio ?? this.bio,
      specialty: specialty ?? this.specialty,
      clientIds: clientIds ?? this.clientIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

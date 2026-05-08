import '../utils/json_converters.dart';

class AppUser {
  const AppUser({
    required this.id,
    required this.email,
    required this.role,
    required this.planType,
    this.displayName,
    this.coachId,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String email;
  final String role;
  final String planType;
  final String? displayName;
  final String? coachId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      role: json['role'] as String? ?? 'usuario',
      planType: json['planType'] as String? ?? 'basic',
      displayName: json['displayName'] as String?,
      coachId: json['coachId'] as String?,
      createdAt: dateTimeFromJson(json['createdAt']),
      updatedAt: dateTimeFromJson(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'role': role,
      'planType': planType,
      'displayName': displayName,
      'coachId': coachId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  AppUser copyWith({
    String? id,
    String? email,
    String? role,
    String? planType,
    String? displayName,
    String? coachId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      role: role ?? this.role,
      planType: planType ?? this.planType,
      displayName: displayName ?? this.displayName,
      coachId: coachId ?? this.coachId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

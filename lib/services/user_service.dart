import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserService {
  UserService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');

  Future<AppUser?> getUser(String userId) async {
    final doc = await _users.doc(userId).get();
    final data = doc.data();

    if (!doc.exists || data == null) {
      return null;
    }

    return AppUser.fromJson({...data, 'id': doc.id});
  }

  Future<void> saveUser(AppUser user) {
    return _users.doc(user.id).set(user.toJson(), SetOptions(merge: true));
  }

  Future<AppUser> ensureUserProfile({
    required String userId,
    required String email,
    String? displayName,
  }) async {
    final existingUser = await getUser(userId);

    if (existingUser != null) {
      return existingUser;
    }

    final now = DateTime.now();
    final user = AppUser(
      id: userId,
      email: email,
      role: 'usuario',
      planType: 'basic',
      displayName: displayName,
      createdAt: now,
      updatedAt: now,
    );

    await saveUser(user);
    return user;
  }

  Future<void> updateUser(AppUser user) {
    return _users.doc(user.id).update(user.toJson());
  }

  Stream<AppUser?> watchUser(String userId) {
    return _users.doc(userId).snapshots().map((doc) {
      final data = doc.data();

      if (!doc.exists || data == null) {
        return null;
      }

      return AppUser.fromJson({...data, 'id': doc.id});
    });
  }

  Stream<List<AppUser>> watchUsers() {
    return _users.snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => AppUser.fromJson({...doc.data(), 'id': doc.id}))
          .toList(),
    );
  }

  Stream<List<AppUser>> watchClientsForCoach(String coachId) {
    return _users
        .where('coachId', isEqualTo: coachId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => AppUser.fromJson({...doc.data(), 'id': doc.id}))
              .toList(),
        );
  }

  Future<void> assignCoachToUser({
    required String userId,
    required String? coachId,
  }) {
    return _users.doc(userId).update({
      'coachId': coachId,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateUserRole({required String userId, required String role}) {
    final normalizedRole = _normalizeRole(role);
    final data = <String, dynamic>{
      'role': normalizedRole,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    if (normalizedRole != 'usuario') {
      data['coachId'] = null;
    }

    return _users.doc(userId).update(data);
  }

  String _normalizeRole(String role) {
    if (role == 'admin' || role == 'coach') {
      return role;
    }

    return 'usuario';
  }
}

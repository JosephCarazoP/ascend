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
}

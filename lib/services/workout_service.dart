import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/workout_session.dart';

class WorkoutService {
  WorkoutService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _sessions =>
      _firestore.collection('workout_sessions');

  Future<WorkoutSession?> getSession(String sessionId) async {
    final doc = await _sessions.doc(sessionId).get();
    final data = doc.data();

    if (!doc.exists || data == null) {
      return null;
    }

    return WorkoutSession.fromJson({...data, 'id': doc.id});
  }

  Stream<List<WorkoutSession>> watchUserSessions(String userId) {
    return _sessions
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => WorkoutSession.fromJson({...doc.data(), 'id': doc.id}),
              )
              .toList(),
        );
  }

  Future<void> saveSession(WorkoutSession session) {
    return _sessions.doc(session.id).set(session.toJson());
  }
}

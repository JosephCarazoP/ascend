import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/routine.dart';

class RoutineService {
  RoutineService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _routines =>
      _firestore.collection('routines');

  Future<Routine?> getRoutine(String routineId) async {
    final doc = await _routines.doc(routineId).get();
    final data = doc.data();

    if (!doc.exists || data == null) {
      return null;
    }

    return Routine.fromJson({...data, 'id': doc.id});
  }

  Stream<List<Routine>> watchUserRoutines(String userId) {
    return _routines
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Routine.fromJson({...doc.data(), 'id': doc.id}))
              .toList(),
        );
  }

  Future<void> saveRoutine(Routine routine) {
    return _routines.doc(routine.id).set(routine.toJson());
  }
}

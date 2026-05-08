import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/routine_request.dart';

class RoutineRequestService {
  RoutineRequestService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _requests =>
      _firestore.collection('routine_requests');

  Future<void> createRequest(RoutineRequest request) async {
    final doc = request.id.isEmpty
        ? _requests.doc()
        : _requests.doc(request.id);
    final requestWithId = request.copyWith(id: doc.id);

    await doc.set(requestWithId.toJson());
  }

  Future<RoutineRequest?> getRequest(String requestId) async {
    final doc = await _requests.doc(requestId).get();
    final data = doc.data();

    if (!doc.exists || data == null) {
      return null;
    }

    return RoutineRequest.fromJson({...data, 'id': doc.id});
  }

  Stream<List<RoutineRequest>> getRequestsByUser(String userId) {
    return _requests
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(_mapSnapshot);
  }

  Stream<List<RoutineRequest>> getRequestsByCoach(String coachId) {
    return _requests
        .where('coachId', isEqualTo: coachId)
        .snapshots()
        .map(_mapSnapshot);
  }

  Stream<List<RoutineRequest>> getAllRequests() {
    return _requests.snapshots().map(_mapSnapshot);
  }

  Future<void> updateRequestStatus(String requestId, String status) {
    return _requests.doc(requestId).update({
      'status': status,
      if (status == 'reviewed' || status == 'assigned' || status == 'rejected')
        'reviewedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> assignRoutineToRequest(String requestId, String routineId) {
    return _requests.doc(requestId).update({
      'status': 'assigned',
      'assignedRoutineId': routineId,
      'reviewedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> addCoachNotes(String requestId, String notes) {
    return _requests.doc(requestId).update({'coachNotes': notes});
  }

  List<RoutineRequest> _mapSnapshot(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    final requests = snapshot.docs
        .map((doc) => RoutineRequest.fromJson({...doc.data(), 'id': doc.id}))
        .toList();

    requests.sort((a, b) {
      final aDate = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bDate = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      return bDate.compareTo(aDate);
    });

    return requests;
  }
}

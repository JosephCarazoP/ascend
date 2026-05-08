import 'package:flutter/material.dart';

import '../models/routine_request.dart';
import '../services/routine_request_service.dart';

class RoutineRequestController extends ChangeNotifier {
  RoutineRequestController({
    required RoutineRequestService routineRequestService,
  }) : _routineRequestService = routineRequestService;

  final RoutineRequestService _routineRequestService;

  bool _isLoading = false;
  String? _error;
  List<RoutineRequest> _requests = const [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<RoutineRequest> get requests => _requests;

  Stream<List<RoutineRequest>> getRequestsByUser(String userId) {
    return _routineRequestService.getRequestsByUser(userId);
  }

  Stream<List<RoutineRequest>> getRequestsByCoach(String coachId) {
    return _routineRequestService.getRequestsByCoach(coachId);
  }

  Stream<List<RoutineRequest>> getAllRequests() {
    return _routineRequestService.getAllRequests();
  }

  Future<RoutineRequest?> getRequest(String requestId) {
    return _routineRequestService.getRequest(requestId);
  }

  Future<void> createRequest(RoutineRequest request) {
    return _run(() => _routineRequestService.createRequest(request));
  }

  Future<void> loadRequestsByUser(String userId) async {
    await _run(() async {
      _requests = await _routineRequestService.getRequestsByUser(userId).first;
    });
  }

  Future<void> loadRequestsByCoach(String coachId) async {
    await _run(() async {
      _requests = await _routineRequestService
          .getRequestsByCoach(coachId)
          .first;
    });
  }

  Future<void> updateRequestStatus(String requestId, String status) {
    return _run(
      () => _routineRequestService.updateRequestStatus(requestId, status),
    );
  }

  Future<void> assignRoutineToRequest(String requestId, String routineId) {
    return _run(
      () => _routineRequestService.assignRoutineToRequest(requestId, routineId),
    );
  }

  Future<void> addCoachNotes(String requestId, String notes) {
    return _run(() => _routineRequestService.addCoachNotes(requestId, notes));
  }

  Future<void> _run(Future<void> Function() action) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await action();
    } catch (error) {
      _error = error.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

import 'package:flutter_test/flutter_test.dart';

import 'package:ascend/controllers/navigation_controller.dart';
import 'package:ascend/controllers/role_controller.dart';
import 'package:ascend/models/routine_request.dart';
import 'package:ascend/models/user.dart';
import 'package:ascend/services/user_service.dart';

void main() {
  test('AppUser serializes basic role data', () {
    const user = AppUser(
      id: 'u1',
      email: 'user@example.com',
      role: 'usuario',
      planType: 'basic',
    );

    final copy = AppUser.fromJson(user.toJson());

    expect(copy.id, 'u1');
    expect(copy.email, 'user@example.com');
    expect(copy.role, 'usuario');
    expect(copy.planType, 'basic');
  });

  test('role hierarchy keeps admin above coach and usuario', () {
    final controller = RoleController(userService: _UnusedUserService());

    expect(controller.roleCanAccess('admin', 'coach'), isTrue);
    expect(controller.roleCanAccess('admin', 'usuario'), isTrue);
    expect(controller.roleCanAccess('coach', 'usuario'), isTrue);
    expect(controller.roleCanAccess('usuario', 'coach'), isFalse);
  });

  test('navigation maps roles to protected dashboard routes', () {
    final controller = NavigationController();

    expect(controller.routeForRole('admin'), '/admin/dashboard');
    expect(controller.routeForRole('coach'), '/coach/dashboard');
    expect(controller.routeForRole('usuario'), '/user/home');
  });

  test('RoutineRequest serializes phase 3 fields', () {
    final request = RoutineRequest(
      id: 'r1',
      userId: 'u1',
      coachId: 'c1',
      status: 'pending',
      goal: 'Fuerza',
      experienceLevel: 'Intermedio',
      trainingDaysAvailable: 4,
      trainingPlace: 'Gimnasio',
      equipment: const ['Barra'],
      answers: const {'sessionDuration': '60 min'},
      createdAt: DateTime(2026, 5, 8),
    );

    final copy = RoutineRequest.fromJson(request.toJson());

    expect(copy.id, 'r1');
    expect(copy.userId, 'u1');
    expect(copy.coachId, 'c1');
    expect(copy.status, 'pending');
    expect(copy.trainingDaysAvailable, 4);
    expect(copy.equipment, ['Barra']);
    expect(copy.answers['sessionDuration'], '60 min');
  });

  test('navigation exposes routine request routes', () {
    expect(NavigationController.requestRoutineRoute, '/user/request-routine');
    expect(
      NavigationController.userRoutineRequestsRoute,
      '/user/routine-requests',
    );
    expect(
      NavigationController.coachRoutineRequestsRoute,
      '/coach/routine-requests',
    );
  });
}

class _UnusedUserService implements UserService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

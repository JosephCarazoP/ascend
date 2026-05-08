import 'package:flutter_test/flutter_test.dart';

import 'package:ascend/controllers/navigation_controller.dart';
import 'package:ascend/controllers/role_controller.dart';
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
}

class _UnusedUserService implements UserService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

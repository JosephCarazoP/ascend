import '../services/user_service.dart';

class RoleController {
  RoleController({required UserService userService})
    : _userService = userService;

  final UserService _userService;

  static const Set<String> _adminActions = {
    'view_users',
    'view_roles',
    'assign_coach',
    'manage_users',
    'manage_routine_requests',
  };

  static const Set<String> _coachActions = {
    'view_clients',
    'view_routine_requests',
    'view_future_routines',
  };

  static const Set<String> _usuarioActions = {
    'view_profile',
    'request_routine',
    'view_routine_requests',
    'view_assigned_routines',
  };

  static const Set<String> _subscriptionActions = {
    'start_routine',
    'use_timer',
    'log_progress',
    'save_progress',
  };

  Future<String> checkRole(String userId) async {
    final user = await _userService.getUser(userId);
    return normalizeRole(user?.role);
  }

  Future<bool> isAdmin(String userId) async {
    return await checkRole(userId) == 'admin';
  }

  Future<bool> isCoach(String userId) async {
    final role = await checkRole(userId);
    return role == 'admin' || role == 'coach';
  }

  Future<bool> isUsuario(String userId) async {
    final role = await checkRole(userId);
    return role == 'admin' || role == 'coach' || role == 'usuario';
  }

  Future<bool> hasPermission(String userId, String action) async {
    final user = await _userService.getUser(userId);

    if (user == null) {
      return false;
    }

    if (await requiresSubscription(userId, action) &&
        user.planType != 'pro' &&
        normalizeRole(user.role) == 'usuario') {
      return false;
    }

    return roleHasPermission(user.role, action);
  }

  Future<bool> requiresSubscription(String userId, String action) async {
    final user = await _userService.getUser(userId);

    if (user == null) {
      return false;
    }

    return normalizeRole(user.role) == 'usuario' &&
        _subscriptionActions.contains(action);
  }

  bool roleCanAccess(String userRole, String requiredRole) {
    return _roleLevel(normalizeRole(userRole)) >= _roleLevel(requiredRole);
  }

  bool roleHasPermission(String userRole, String action) {
    final role = normalizeRole(userRole);

    if (role == 'admin') {
      return _adminActions.contains(action) ||
          _coachActions.contains(action) ||
          _usuarioActions.contains(action) ||
          _subscriptionActions.contains(action);
    }

    if (role == 'coach') {
      return _coachActions.contains(action) ||
          _usuarioActions.contains(action) ||
          _subscriptionActions.contains(action);
    }

    return _usuarioActions.contains(action) ||
        _subscriptionActions.contains(action);
  }

  String normalizeRole(String? role) {
    if (role == 'admin' || role == 'coach') {
      return role!;
    }

    return 'usuario';
  }

  int _roleLevel(String role) {
    switch (normalizeRole(role)) {
      case 'admin':
        return 3;
      case 'coach':
        return 2;
      default:
        return 1;
    }
  }
}

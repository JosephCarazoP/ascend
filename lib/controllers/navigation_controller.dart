import '../models/user.dart';

class NavigationController {
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgot-password';
  static const String adminDashboardRoute = '/admin/dashboard';
  static const String coachDashboardRoute = '/coach/dashboard';
  static const String coachRoutineRequestsRoute = '/coach/routine-requests';
  static const String coachRoutineRequestDetailRoute =
      '/coach/routine-request-detail';
  static const String userHomeRoute = '/user/home';
  static const String requestRoutineRoute = '/user/request-routine';
  static const String userRoutineRequestsRoute = '/user/routine-requests';

  String routeForRole(String role) {
    switch (role) {
      case 'admin':
        return adminDashboardRoute;
      case 'coach':
        return coachDashboardRoute;
      default:
        return userHomeRoute;
    }
  }

  String routeForUser(AppUser user) {
    return routeForRole(user.role);
  }
}

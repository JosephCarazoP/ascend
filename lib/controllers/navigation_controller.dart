import '../models/user.dart';

class NavigationController {
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgot-password';
  static const String adminDashboardRoute = '/admin/dashboard';
  static const String coachDashboardRoute = '/coach/dashboard';
  static const String userHomeRoute = '/user/home';

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

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/auth_controller.dart';
import 'controllers/navigation_controller.dart';
import 'controllers/role_controller.dart';
import 'controllers/routine_request_controller.dart';
import 'controllers/theme_controller.dart';
import 'firebase_options.dart';
import 'models/routine_request.dart';
import 'services/auth_service.dart';
import 'services/routine_request_service.dart';
import 'services/user_service.dart';
import 'utils/app_theme.dart';
import 'utils/route_guard.dart';
import 'views/admin/admin_dashboard.dart';
import 'views/auth/forgot_password_screen.dart';
import 'views/auth/login_screen.dart';
import 'views/auth/register_screen.dart';
import 'views/coach/coach_dashboard.dart';
import 'views/coach/routine_request_detail_screen.dart';
import 'views/coach/routine_requests_screen.dart';
import 'views/shared/auth_gate.dart';
import 'views/user/my_routine_requests_screen.dart';
import 'views/user/request_routine_screen.dart';
import 'views/user/user_home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const AscendApp());
}

class AscendApp extends StatelessWidget {
  const AscendApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<UserService>(create: (_) => UserService()),
        Provider<RoutineRequestService>(create: (_) => RoutineRequestService()),
        Provider<AuthController>(
          create: (context) => AuthController(
            authService: context.read<AuthService>(),
            userService: context.read<UserService>(),
          ),
        ),
        Provider<RoleController>(
          create: (context) =>
              RoleController(userService: context.read<UserService>()),
        ),
        Provider<NavigationController>(create: (_) => NavigationController()),
        ChangeNotifierProvider<ThemeController>(
          create: (_) => ThemeController(),
        ),
        ChangeNotifierProvider<RoutineRequestController>(
          create: (context) => RoutineRequestController(
            routineRequestService: context.read<RoutineRequestService>(),
          ),
        ),
      ],
      child: Consumer<ThemeController>(
        builder: (context, themeController, _) {
          return MaterialApp(
            title: 'Ascend',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeController.themeMode,
            initialRoute: '/',
            routes: {
              '/': (_) => const AuthGate(),
              '/login': (_) => const LoginScreen(),
              '/register': (_) => const RegisterScreen(),
              '/forgot-password': (_) => const ForgotPasswordScreen(),
              '/admin/dashboard': (_) => const RouteGuard(
                requiredRole: 'admin',
                child: AdminDashboard(),
              ),
              '/coach/dashboard': (_) => const RouteGuard(
                requiredRole: 'coach',
                child: CoachDashboard(),
              ),
              '/coach/routine-requests': (_) => const RouteGuard(
                requiredRole: 'coach',
                child: RoutineRequestsScreen(),
              ),
              '/coach/routine-request-detail': (context) {
                final request = ModalRoute.of(context)?.settings.arguments;

                if (request is! RoutineRequest) {
                  return const _InvalidRouteScreen();
                }

                return RouteGuard(
                  requiredRole: 'coach',
                  child: RoutineRequestDetailScreen(request: request),
                );
              },
              '/user/home': (_) => const RouteGuard(
                requiredRole: 'usuario',
                child: UserHomeScreen(),
              ),
              '/user/request-routine': (_) => const RouteGuard(
                requiredRole: 'usuario',
                child: RequestRoutineScreen(),
              ),
              '/user/routine-requests': (_) => const RouteGuard(
                requiredRole: 'usuario',
                child: MyRoutineRequestsScreen(),
              ),
            },
          );
        },
      ),
    );
  }
}

class _InvalidRouteScreen extends StatelessWidget {
  const _InvalidRouteScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ruta inválida')),
      body: const Center(child: Text('No se encontró la solicitud.')),
    );
  }
}

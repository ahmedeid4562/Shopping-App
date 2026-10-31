import 'package:flutter/material.dart';

import 'package:shopping_app/features/presentation/view/screens/login_screen.dart';
import 'package:shopping_app/features/presentation/view/screens/signup_screen.dart';
import 'package:shopping_app/features/presentation/view/screens/main_screen.dart';
import 'package:shopping_app/features/presentation/view/admin/screens/admin_dashboard_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String admin = '/admin';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      case home:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      case admin:
        return MaterialPageRoute(builder: (_) => const AdminDashboardScreen());

      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}

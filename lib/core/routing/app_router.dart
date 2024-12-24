import 'package:flutter/material.dart';
import 'package:instagram_app/core/routing/routes.dart';

import '../../features/auth/login/presentation/views/login_view.dart';
import '../../features/auth/sign_up/presentation/views/sign_up_view.dart';
import '../../features/home/presentation/views/home_view.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginView: // here
        return MaterialPageRoute(
          builder: (_) => const LoginView(),
        );
      case Routes.homeView: // and here
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
        );
      case Routes.signUpView: // and here
        return MaterialPageRoute(
          builder: (_) => const SignUpView(),
        );
      default:
        return null;
    }
  }
}

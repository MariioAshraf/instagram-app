import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/core/routing/routes.dart';

import '../../features/auth/login/presentation/views/login_view.dart';
import '../../features/auth/sign_up/presentation/views/sign_up_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/post/domain/use_cases/post_use_case.dart';
import '../../features/post/presentation/manager/post_cubit.dart';
import '../../features/post/presentation/views/create_post_view.dart';
import '../di/dependency_injection.dart';

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
      case Routes.createPostView: // and here
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) => PostCubit(getIt.get<PostUseCase>()),
              child: const CreatePostView()),
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

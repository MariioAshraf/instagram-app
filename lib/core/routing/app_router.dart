import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/constants.dart';
import 'package:instagram_app/core/routing/routes.dart';
import 'package:instagram_app/features/profile/presentation/views/edit_profile_view.dart';
import 'package:instagram_app/features/story/presentation/views/display_offline_story_view.dart';
import 'package:instagram_app/features/story/presentation/views/story_preview_view.dart';
import '../../features/auth/login/presentation/views/login_view.dart';
import '../../features/auth/sign_up/presentation/views/sign_up_view.dart';
import '../../features/home/presentation/manager/bottom_nav_cubit.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/post/domain/use_cases/post_use_case.dart';
import '../../features/post/presentation/manager/post_cubit.dart';
import '../../features/post/presentation/views/create_post_view.dart';
import '../../features/profile/data/repos/profile_repo_impl.dart';
import '../../features/profile/domain/use_cases/profile_use_case.dart';
import '../../features/profile/presentation/manager/profile_cubit.dart';
import '../../features/story/data/models/story_model.dart';
import '../di/dependency_injection.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginView:
        return MaterialPageRoute(
          builder: (_) => const LoginView(),
        );
      case Routes.homeView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => BottomNavCubit(),
            child: const HomeView(),
          ),
        );
      case Routes.createPostView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => PostCubit(
              getIt.get<PostUseCase>(),
            ),
            child: const CreatePostView(),
          ),
        );
      case Routes.signUpView:
        return MaterialPageRoute(
          builder: (_) => const SignUpView(),
        );
      case Routes.displayOfflineStoriesView:
        return MaterialPageRoute(builder: (_) {
          final args = settings.arguments as Map<String, dynamic>;
          final List<StoryModel> stories = args[kStoriesCollection];
          final bool isMyStory = args[kIsMyStory];
          return DisplayOfflineStoriesStoryView(
            stories: stories,
            isMyStory: isMyStory,
          );
        });
      case Routes.storyPreviewView:
        return MaterialPageRoute(
          builder: (_) => const StoryPreviewView(),
        );
      case Routes.editProfileView:
        return MaterialPageRoute(
          builder: (_) => const EditProfileView(),
        );
      default:
        return null;
    }
  }
}

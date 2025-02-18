import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:instagram_app/core/routing/app_router.dart';
import 'package:instagram_app/features/auth/login/presentation/manager/login_cubit.dart';
import 'package:instagram_app/features/profile/data/repos/profile_repo_impl.dart';
import 'package:instagram_app/features/profile/domain/use_cases/profile_use_case.dart';
import 'package:instagram_app/features/story/data/repos/story_repo_impl.dart';
import 'package:instagram_app/features/story/presentation/manager/story_cubit/story_cubit.dart';
import 'constants.dart';
import 'core/di/dependency_injection.dart';
import 'core/utils/bloc_observer.dart';
import 'core/routing/routes.dart';
import 'core/utils/supabase_initialization.dart';
import 'features/auth/login/domain/use_cases/login_use_case.dart';
import 'features/profile/presentation/manager/profile_cubit.dart';
import 'features/story/data/models/story_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await supabaseInitialization();
  await Hive.initFlutter();
  Hive.registerAdapter(StoryModelAdapter());
  Hive.registerAdapter(MediaTypeAdapter());
  await Hive.openBox<StoryModel>(kStories);
  setupServiceLocator();
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(getIt.get<LoginUseCase>()),
          ),
          BlocProvider(
            create: (context) => ProfileCubit(
              getIt.get<ProfileRepoImpl>(),
              getIt.get<ProfileUseCase>(),
            ),
          ),
          BlocProvider(
            create: (context) => StoryCubit(getIt.get<StoryRepoImpl>()),
          ),
        ],
        child: MaterialApp(
          initialRoute: Routes.loginView,
          onGenerateRoute: AppRouter().generateRoute,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

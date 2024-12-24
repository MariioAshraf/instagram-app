import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/core/routing/app_router.dart';
import 'core/di/dependency_injection.dart';
import 'core/utils/bloc_observer.dart';
import 'core/routing/routes.dart';
import 'core/utils/supabase_initialization.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupServiceLocator();
  Bloc.observer = AppBlocObserver();
  await supabaseInitialization();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        initialRoute: Routes.loginView,
        onGenerateRoute: AppRouter().generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

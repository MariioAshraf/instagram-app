import 'package:get_it/get_it.dart';
import 'package:instagram_app/features/auth/login/data/domain/user_cases/login_use_case.dart';
import 'package:instagram_app/features/auth/login/data/repos/login_repo_impl.dart';
import 'package:instagram_app/features/auth/sign_up/data/repos/sign_up_repo_impl.dart';
import 'package:instagram_app/features/auth/sign_up/domain/use_cases/sign_up_use_case.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // sign up repo dependencies
  getIt.registerSingleton<SignUpRepoImpl>(SignUpRepoImpl());
  getIt
      .registerSingleton<SignUpUseCase>(SignUpUseCase(getIt<SignUpRepoImpl>()));
  // login repo dependencies
  getIt.registerSingleton<LoginRepoImpl>(LoginRepoImpl());
  getIt.registerSingleton<LoginUseCase>(LoginUseCase(getIt<LoginRepoImpl>()));
}

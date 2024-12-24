import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/core/di/dependency_injection.dart';
import 'package:instagram_app/features/auth/login/presentation/views/widgets/login_view_body.dart';
import '../../domain/user_cases/login_use_case.dart';
import '../manager/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => LoginCubit(getIt.get<LoginUseCase>()),
          child: const LoginViewBody(),
        ),
      ),
    );
  }
}

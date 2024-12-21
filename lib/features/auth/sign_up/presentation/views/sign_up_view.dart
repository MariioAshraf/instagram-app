import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/core/di/dependency_injection.dart';
import 'package:instagram_app/features/auth/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:instagram_app/features/auth/sign_up/presentation/views/widgets/sign_up_view_body.dart';

import '../manager/sign_up_cubit.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => SignUpCubit(getIt.get<SignUpUseCase>()),
      child: const SafeArea(child: SignUpViewBody()),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/auth/login/presentation/manager/login_cubit.dart';
import 'package:instagram_app/features/profile/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) =>
            current is GetUserSuccess || current is GetUserLoading,
        builder: (context, state) {
          return const ProfileViewBody();
        },
      ),
    );
  }
}

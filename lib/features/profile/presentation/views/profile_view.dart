import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/home/presentation/manager/home_cubit.dart';
import 'package:instagram_app/features/profile/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  final String dueToRebuildIssue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return ProfileViewBody(
            dueToRebuildIssue: dueToRebuildIssue,
          );
        },
      ),
    );
  }
}

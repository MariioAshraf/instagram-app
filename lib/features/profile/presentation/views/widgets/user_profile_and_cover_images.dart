import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/home/presentation/manager/home_cubit.dart';
import 'package:instagram_app/features/profile/presentation/views/widgets/profile_image_bloc_consumer.dart';
import 'package:instagram_app/features/story/presentation/manager/story_cubit/story_cubit.dart';
import 'cover_image_bloc_consumer.dart';

class UserProfileAndCoverImages extends StatelessWidget {
  const UserProfileAndCoverImages({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final bool hasStories = StoryCubit.get(context).myStories.isNotEmpty;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is GetUserSuccess,
      builder: (context, state) {
        return SizedBox(
          height: size.height * 0.32,
          width: size.width,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              CoverImageBlocConsumer(
                height: height,
              ),
              ProfileImageBlocConsumer(
                hasStories: hasStories,
              ),
            ],
          ),
        );
      },
    );
  }
}

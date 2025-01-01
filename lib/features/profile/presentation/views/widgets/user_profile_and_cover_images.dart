import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/features/auth/login/presentation/manager/login_cubit.dart';
import 'package:instagram_app/features/profile/presentation/views/widgets/profile_image_bloc_consumer.dart';
import '../../../../../core/widgets/build_user_cover_image.dart';

class UserProfileAndCoverImages extends StatelessWidget {
  const UserProfileAndCoverImages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return SizedBox(
          height: size.height * 0.32,
          width: size.width,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              buildUserCoverImage(
                context,
              ),
              ProfileImageBlocConsumer(
                radius: 68.r,
              ),
            ],
          ),
        );
      },
    );
  }
}

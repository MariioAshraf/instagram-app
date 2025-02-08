import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';

import '../../../../../core/theming/app_styles.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../auth/login/presentation/manager/login_cubit.dart';
import '../../manager/post_cubit.dart';

class CreatePostTopBar extends StatefulWidget {
  const CreatePostTopBar({
    super.key,
  });

  @override
  State<CreatePostTopBar> createState() => _CreatePostTopBarState();
}

class _CreatePostTopBarState extends State<CreatePostTopBar> {
  @override
  Widget build(BuildContext context) {
    UserModel userModel = LoginCubit.get(context).userModel;
    PostCubit postCubit = PostCubit.get(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
        horizontalSpacing(20),
        Text(
          'Create Post',
          style: AppTextStyles.font18DarkBlueBold,
        ),
        horizontalSpacing(20),
        BlocBuilder<PostCubit, PostState>(
          buildWhen: (previous, current) =>
              current is CanNotUploadPost ||
              current is CanUploadPost ||
              current is PostFilesPickedSuccess,
          builder: (context, state) {
            return Container(
              width: 40.w,
              height: 40.h,
              alignment: Alignment.center,
              child: state is CanNotUploadPost
                  ? Text(
                      'Post',
                      style: AppTextStyles.font13GreyRegular.copyWith(
                        fontSize: 21,
                      ),
                    )
                  : _createPostTextButton(postCubit, userModel),
            );
          },
        )
      ],
    );
  }

  TextButton _createPostTextButton(PostCubit postCubit, UserModel userModel) {
    return TextButton(
        style: ButtonStyle(
          overlayColor: const WidgetStatePropertyAll(Colors.black12),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.zero,
          ),
        ),
        onPressed: () {
          postCubit.createPost(
            userModel,
          );

          // postCubit.getAllPosts();
        },
        child: Text(
          'Post',
          style: AppTextStyles.font13BlueRegular.copyWith(fontSize: 21),
        ));
  }
}

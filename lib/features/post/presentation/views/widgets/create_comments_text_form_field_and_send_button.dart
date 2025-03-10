import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/core/widgets/app_text_form_field.dart';
import 'package:instagram_app/features/post/presentation/manager/comment_cubit/comment_cubit.dart';
import '../../../../../core/theming/app_styles.dart';
import 'create_comment_bloc_consumer.dart';

class CreateCommentsTextFormFieldAndSendButton extends StatelessWidget {
  const CreateCommentsTextFormFieldAndSendButton(
      {super.key, required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context) {
    final CommentCubit commentCubit = CommentCubit.get(context);
    return Positioned(
      right: 0,
      left: 0,
      bottom: 0,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          height: 60.h,
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 1.3.w,
                color: Colors.transparent,
              ),
            ),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: AppTextFormField(
                    onChanged: (value) {
                      if (value!.length < 2) {
                        commentCubit.checkCommentStatus();
                      }
                    },
                    controller: commentCubit.commentController,
                    hintStyle: AppTextStyles.font14GreyRegular,
                    backGroundColor: Colors.grey.shade100,
                    hintText: 'Write a comment...'),
              ),
              CreateCommentBlocConsumer(
                postId: postId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

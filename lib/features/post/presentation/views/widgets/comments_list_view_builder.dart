import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/features/post/presentation/manager/post_cubit.dart';
import 'package:shimmer/shimmer.dart';
import 'comment_item.dart';

class CommentsListViewBuilder extends StatelessWidget {
  const CommentsListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      buildWhen: (previous, current) =>
          current is FetchCommentsSuccess ||
          current is FetchCommentsFailure ||
          current is FetchCommentsLoading,
      builder: (context, state) {
        if (state is FetchCommentsSuccess) {
          return state.comments.isEmpty
              ? const Expanded(child: Center(child: Text('No Comments yet')))
              : Expanded(
                  child: ListView.builder(
                    itemCount: state.comments.length,
                    itemBuilder: (context, index) {
                      return CommentItem(
                        commentModel: state.comments[index],
                      );
                    },
                  ),
                );
        }
        if (state is FetchCommentsLoading) {
          return Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    // User Image
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    // User Name
                    SizedBox(
                      height: 70.h,
                      width: 160.h,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r)),
                          height: 15,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

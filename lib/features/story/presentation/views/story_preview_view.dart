import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/story/presentation/manager/story_cubit/story_cubit.dart';
import 'package:instagram_app/features/story/presentation/views/widgets/story_preview_view_body.dart';

class StoryPreviewView extends StatelessWidget {
  const StoryPreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<StoryCubit, StoryState>(
        listener: (context, state) {
          if (state is UploadStoriesLoading) {
            Navigator.pop(context);
          }
        },
        child: const StoryPreviewViewBody(),
      ),
    );
  }
}

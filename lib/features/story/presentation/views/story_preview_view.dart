import 'package:flutter/material.dart';
import 'package:instagram_app/features/story/presentation/views/widgets/story_preview_view_body.dart';

class StoryPreviewView extends StatelessWidget {
  const StoryPreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: StoryPreviewViewBody(),
    );
  }
}

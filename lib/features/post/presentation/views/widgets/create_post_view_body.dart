import 'package:flutter/material.dart';
import 'package:instagram_app/features/post/presentation/views/widgets/create_post_bloc_consumer.dart';

class CreatePostViewBody extends StatelessWidget {
  const CreatePostViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CreatePostBlocConsumer();
  }
}

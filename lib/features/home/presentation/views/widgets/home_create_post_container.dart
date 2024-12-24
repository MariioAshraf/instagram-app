import 'package:flutter/material.dart';
import 'package:instagram_app/core/utils/spacing.dart';
import 'home_create_post_gradient_container.dart';

class HomeCreatePostContainer extends StatelessWidget {
  const HomeCreatePostContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: HomeCreatePostGradientContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  horizontalSpacing(10),
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80',
                    ),
                  ),
                  horizontalSpacing(10),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {},
                      decoration: const InputDecoration(
                        hintText: 'What\'s in your head?',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.image)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.image)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

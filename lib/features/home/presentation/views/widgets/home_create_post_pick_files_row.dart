import 'package:flutter/material.dart';

class HomeCreatePostPickFilesRow extends StatelessWidget {
  const HomeCreatePostPickFilesRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.image)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.image)),
      ],
    );
  }
}

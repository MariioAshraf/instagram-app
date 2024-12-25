import 'package:flutter/material.dart';

class HomeCreatePostTextField extends StatelessWidget {
  const HomeCreatePostTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {},
      decoration: const InputDecoration(
        hintText: 'What\'s in your head?',
        border: InputBorder.none,
      ),
    );
  }
}

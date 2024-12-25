import 'package:flutter/material.dart';

class UserDefaultProfileCircleAvatar extends StatelessWidget {
  const UserDefaultProfileCircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 28,
      backgroundColor: Colors.grey,
      child: Icon(
        Icons.person,
        color: Colors.black,
      ),
    );
  }
}

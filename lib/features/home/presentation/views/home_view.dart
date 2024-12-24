import 'package:flutter/material.dart';
import 'package:instagram_app/features/home/presentation/views/widgets/gradient_background.dart';
import 'package:instagram_app/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldGradientBackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: HomeViewBody(),
      ),
    );
  }
}


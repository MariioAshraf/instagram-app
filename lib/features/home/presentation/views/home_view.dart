import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/core/theming/app_colors.dart';
import 'package:instagram_app/features/home/presentation/views/widgets/app_main_gradient_background_container.dart';
import 'package:instagram_app/features/story/presentation/manager/story_cubit/story_cubit.dart';
import '../../../profile/presentation/manager/profile_cubit.dart';
import '../../../profile/presentation/views/widgets/build_drawer.dart';
import '../manager/home_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    return AppMainGradientBackgroundContainer(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return homeCubit.userModel == null
              ? const Center(
                  child: CircularProgressIndicator(
                  color: AppColorsManager.mainBlue,
                ))
              : Scaffold(
                  key: HomeCubit.get(context).scaffoldKey,
                  drawer: const BuildDrawer(),
                  backgroundColor: Colors.transparent,
                  bottomNavigationBar: _buildBottomNavBar(homeCubit, context),
                  body: homeCubit.screens[homeCubit.currentIndex],
                );
        },
      ),
    );
  }

  Theme _buildBottomNavBar(HomeCubit homeCubit, BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        iconSize: 24,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: homeCubit.buildBottomNavItems,
        currentIndex: homeCubit.currentIndex,
        onTap: (index) {
          if (index == 1) {
            StoryCubit.get(context).pickStoryMedia();
          } else {
            homeCubit.changeBottomNav(index);
          }
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: AppColorsManager.mainBlue,
        unselectedItemColor: Colors.black54,
      ),
    );
  }
}

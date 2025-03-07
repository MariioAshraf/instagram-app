import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/core/theming/app_colors.dart';
import 'package:instagram_app/features/home/presentation/views/widgets/gradient_background.dart';
import '../../../profile/presentation/manager/profile_cubit.dart';
import '../../../profile/presentation/views/widgets/build_drawer.dart';
import '../manager/home_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit bottomNavCubit = HomeCubit.get(context);
    return ScaffoldGradientBackgroundContainer(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return state is GetUserLoading || state is BottomNavInitial
              ? const Center(
                  child: CircularProgressIndicator(
                  color: AppColorsManager.mainBlue,
                ))
              : Scaffold(
                  key: HomeCubit.get(context).scaffoldKey,
                  drawer: const BuildDrawer(),
                  backgroundColor: Colors.transparent,
                  bottomNavigationBar:
                      _buildBottomNavBar(bottomNavCubit, context),
                  body: bottomNavCubit
                      .screens(context)[bottomNavCubit.currentIndex],
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
        items: homeCubit.buildBottomNavItems(context),
        currentIndex: homeCubit.currentIndex,
        onTap: (index) {
          homeCubit.changeBottomNav(index);
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: AppColorsManager.mainBlue,
        unselectedItemColor: Colors.black54,
      ),
    );
  }
}

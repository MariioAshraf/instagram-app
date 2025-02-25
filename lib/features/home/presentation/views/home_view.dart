import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/core/theming/app_colors.dart';
import 'package:instagram_app/features/home/presentation/views/widgets/gradient_background.dart';
import '../../../profile/presentation/manager/profile_cubit.dart';
import '../../../profile/presentation/views/widgets/build_drawer.dart';
import '../manager/bottom_nav_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late ProfileCubit profileCubit;

  @override
  void initState() {
    profileCubit = ProfileCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BottomNavCubit bottomNavCubit = BottomNavCubit.get(context);
    return ScaffoldGradientBackgroundContainer(
      child: BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (context, state) {
          return Scaffold(
            key: profileCubit.scaffoldKey,
            drawer: const BuildDrawer(),
            backgroundColor: Colors.transparent,
            bottomNavigationBar: _buildBottomNavBar(bottomNavCubit, context),
            body: bottomNavCubit.screens(context)[bottomNavCubit.currentIndex],
          );
        },
      ),
    );
  }

  Theme _buildBottomNavBar(
      BottomNavCubit bottomNavCubit, BuildContext context) {
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
        items: bottomNavCubit.buildBottomNavItems(context),
        currentIndex: bottomNavCubit.currentIndex,
        onTap: (index) {
          bottomNavCubit.changeBottomNav(index);
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: AppColorsManager.mainBlue,
        unselectedItemColor: Colors.black54,
      ),
    );
  }
}

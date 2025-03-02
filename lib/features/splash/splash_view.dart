import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_app/core/functions/hive_functions.dart';
import 'package:instagram_app/features/home/presentation/manager/home_cubit.dart';
import '../../core/routing/routes.dart';
import '../../core/utils/assets.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnToken();
  }

  Future<void> _navigateBasedOnToken() async {
    final String? userId = await HiveFunctions.getUserId();
    // await HomeCubit.get(context).getUser();
    await Future.delayed(const Duration(seconds: 2));
    if (userId != null) {
      if (mounted) {
        HomeCubit.get(context).userId = userId;
      }
      if (mounted) {
        Navigator.pushReplacementNamed(context, Routes.homeView);
      }
      return;
    }

    if (mounted) {
      Navigator.pushReplacementNamed(context, Routes.loginView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SvgPicture.asset(
          AssetsData.homeTopBarLogo,
          width: 200.w,
          height: 120.h,
        ),
      ),
    );
  }
}

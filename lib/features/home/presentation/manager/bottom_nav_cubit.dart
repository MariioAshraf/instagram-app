import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/core/widgets/build_user_profile_image.dart';
import 'package:instagram_app/features/auth/login/presentation/manager/login_cubit.dart';
import 'package:instagram_app/features/story/presentation/manager/story_cubit/story_cubit.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../profile/data/repos/profile_repo_impl.dart';
import '../../../profile/domain/use_cases/profile_use_case.dart';
import '../../../profile/presentation/manager/profile_cubit.dart';
import '../../../profile/presentation/views/profile_view.dart';
import '../../../search/presentation/views/search_view.dart';
import '../views/widgets/home_view_body.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavInitial());

  static BottomNavCubit get(BuildContext context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<BottomNavigationBarItem> buildBottomNavItems(BuildContext context) {
    return [
      const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: CircleAvatar(
          backgroundColor:
              currentIndex == 2 ? Colors.white : Colors.transparent,
          radius: 16.r,
          child: BlocBuilder<LoginCubit, LoginState>(
            buildWhen: (_, current) => current is GetUserSuccess,
            builder: (context, state) {
              return buildUserProfileImage(context, radius: 14);
            },
          ),
        ),
        label: 'Profile',
      ),
    ];
  }

  List<Widget> screens(BuildContext context) {
    return [
      SafeArea(
        child: BlocProvider(
          create: (context) => StoryCubit(),
          child: const HomeViewBody(),
        ),
      ),
      const SearchView(),
      const ProfileView(),
    ];
  }

  void changeBottomNav(index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }
}

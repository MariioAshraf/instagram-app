import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/core/widgets/build_user_profile_image.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import 'package:meta/meta.dart';
import '../../../profile/presentation/views/profile_view.dart';
import '../../../search/presentation/views/search_view.dart';
import '../views/widgets/home_view_body.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavInitial());

  static BottomNavCubit get(BuildContext context) => BlocProvider.of(context);
  int currentIndex = 0;
  late UserModel userModel;

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
        icon: buildUserProfileImage(context, radius: 18),
        label: 'Profile',
      ),
    ];
  }

  List<Widget> screens = [
    const HomeViewBody(),
    const SearchView(),
    const ProfileView(),
  ];

  void changeBottomNav(index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }
}

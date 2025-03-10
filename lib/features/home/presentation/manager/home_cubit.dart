import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/constants.dart';
import 'package:instagram_app/core/widgets/build_user_profile_image.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../post/data/repos/post_repo_impl.dart';
import '../../../post/domain/use_cases/create_post_use_case.dart';
import '../../../post/presentation/manager/post_cubit.dart';
import '../../../profile/presentation/views/profile_view.dart';
import '../../../search/presentation/views/search_view.dart';
import '../views/widgets/home_view_body.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(BottomNavInitial());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  final ScrollController scrollController = ScrollController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  int currentIndex = 0;

  late String userId;

  late UserModel userModel;

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection(kUsersCollection);

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
          child: BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (_, current) => current is GetUserSuccess,
            builder: (context, state) {
              return buildUserProfileImage(
                context,
                radius: 14,
                profileImage: userModel.profileImageUrl!,
              );
            },
          ),
        ),
        label: 'Profile',
      ),
    ];
  }

  Future<void> getUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      emit(GetUserLoading());
      final uId = FirebaseAuth.instance.currentUser!.uid;
      final docSnapShot = await _usersCollection.doc(uId).get();
      userModel = UserModel.fromJson(docSnapShot);
      // print('userModel: ${userModel.toJson()}');
      emit(GetUserSuccess());
    }
  }

  // getUser() async {
  //   final userModel = await HiveFunctions.getUserModel();
  //   if (userModel != null) {
  //     this.userModel = userModel;
  //     emit(GetUserSuccess());
  //   }
  // }

  List<Widget> screens(BuildContext context) {
    return [
      const SafeArea(
        child: HomeViewBody(),
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

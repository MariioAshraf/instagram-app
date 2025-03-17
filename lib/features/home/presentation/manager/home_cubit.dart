import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/constants.dart';
import 'package:instagram_app/core/functions/hive_functions.dart';
import 'package:instagram_app/core/widgets/build_user_profile_image.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import '../../../post/data/models/post_model.dart';
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

  String? userId;

  UserModel? userModel;

  Map<String, UserModel> allUsersMap = {};

  Map<String, PostModel> homePostsMap = {};

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection(kUsersCollection);

  List<BottomNavigationBarItem> get buildBottomNavItems => [
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.add),
          label: 'add story',
        ),
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            backgroundColor:
                currentIndex == 3 ? Colors.white : Colors.transparent,
            radius: 16.r,
            child: BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (_, current) => current is GetUserSuccess,
              builder: (context, state) {
                return buildUserProfileImage(
                  context,
                  radius: 14,
                  profileImage: userModel!.profileImageUrl!,
                );
              },
            ),
          ),
          label: 'Profile',
        ),
      ];

  // getUserId() async {
  //   userId = await HiveFunctions.getUser();
  // }

  Future<void> getUser() async {
    userModel = await HiveFunctions.getUser();
    userId = userModel?.uId;
    emit(GetUserSuccess());
    updateUserFromFirebase();
  }

  Future<void> updateUserFromFirebase() async {
    if (FirebaseAuth.instance.currentUser != null) {
      // emit(GetUserLoading());
      final uId = FirebaseAuth.instance.currentUser!.uid;
      final docSnapShot = await _usersCollection.doc(uId).get();
      userModel = UserModel.fromJson(docSnapShot);
      // print('userModel: ${userModel.toJson()}');
      emit(GetUserSuccess());
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    userModel = null;
    HiveFunctions.removeUser();
    emit(LogoutSuccess());
  }

  // getUser() async {
  //   final userModel = await HiveFunctions.getUserModel();
  //   if (userModel != null) {
  //     this.userModel = userModel;
  //     emit(GetUserSuccess());
  //   }
  // }

  List<Widget> get screens => [
        const SafeArea(
          child: HomeViewBody(),
        ),
        const Center(child: Text('add story')),
        const SearchView(),
        const ProfileView(),
      ];

  void changeBottomNav(index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }
}

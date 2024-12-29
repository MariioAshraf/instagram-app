import 'package:flutter/material.dart';
import 'package:instagram_app/features/profile/presentation/views/widgets/build_drawer.dart';
import 'package:instagram_app/features/profile/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const BuildDrawer(),
      backgroundColor: Colors.transparent,
      body: ProfileViewBody(
        scaffoldKey: _scaffoldKey,
      ),
    );
  }
}

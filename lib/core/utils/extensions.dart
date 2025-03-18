import 'package:flutter/material.dart';
import 'package:instagram_app/core/theming/app_colors.dart';

import '../theming/app_styles.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  Future<void> logOutAndGoToLogin(String loginRouteName) async {
    Navigator.of(this).pushNamedAndRemoveUntil(
      loginRouteName,
      (route) => false,
    );
  }

  void pop() => Navigator.of(this).pop();
}

extension ShowSnackBar on BuildContext {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      {required String message, Color? color}) {
    final snackBar = SnackBar(
      content: Text(message, style: AppTextStyles.font14DarkBlueMedium),
      backgroundColor: color ?? AppColorsManager.mainBlue,
    );
    return ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}

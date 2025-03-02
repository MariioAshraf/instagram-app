import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/core/utils/extensions.dart';
import '../../../../../../core/routing/routes.dart';
import '../../../../../../core/theming/app_styles.dart';

class DoNotHaveAnAccountAndSignUpText extends StatelessWidget {
  const DoNotHaveAnAccountAndSignUpText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an account yet? ',
              style: AppTextStyles.font14DarkBlueMedium.copyWith(fontSize: 13.sp),
            ),
            TextSpan(
              text: ' Sign Up',
              style: AppTextStyles.font13BlueRegular,
              recognizer: TapGestureRecognizer()..onTap = (){
                context.pushReplacementNamed(Routes.signUpView);
              }
            ),
          ],
        ),
      ),
    );
  }
}

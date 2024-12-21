// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class SignUpBlocListener extends StatelessWidget {
//   const SignUpBlocListener({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<SignUpCubit, SignUpState>(
//       child: const SizedBox.shrink(),
//       listener: (context, state) {
//         state.whenOrNull(
//           loading: () {
//             showDialog(
//               context: context,
//               builder: (context) => const Center(
//                 child: CircularProgressIndicator(
//                   color: AppColorsManager.mainBlue,
//                 ),
//               ),
//             );
//           },
//           success: (signUpResponseBody) {
//             context.pop();
//             context.pushNamed(Routes.homeView);
//           },
//           failure: (errMsg) {
//             context.pop();
//             showDialog(
//               context: context,
//               builder: (context) => AlertDialog(
//                 icon: const Icon(
//                   Icons.error,
//                   color: Colors.red,
//                   size: 32,
//                 ),
//                 content: Text(errMsg),
//                 actions: [
//                   TextButton(
//                       onPressed: () {
//                         context.pop();
//                       },
//                       child: Text(
//                         'Got it',
//                         style: AppTextStyles.font14DarkBlueMedium,
//                       ))
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

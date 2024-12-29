import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileRow extends StatelessWidget {
  const EditProfileRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 0.7.w, color: Colors.grey)),
            height: 50.h,
            child: const Center(
                child: Text(
              'EDIT PROFILE',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            )),
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Container(
          width: 50.w,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 0.7.w,
              color: Colors.grey,
            ),
          ),
          height: 50.h,
          child: const Center(
            child: Icon(
              size: 32,
              Icons.settings_outlined,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}

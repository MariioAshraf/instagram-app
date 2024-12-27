import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
class PhotoCollage extends StatelessWidget {
  final List<XFile> images;

  const PhotoCollage({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    int additionalCount = images.length - 3;
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: images.length == 1 ? 1 : 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemCount: images.length > 4 ? 4 : images.length,
        itemBuilder: (context, index) {
          if (images.length == 1) {
            return SizedBox(
              width: double.maxFinite,
              height: 150.h,
              child: Image.file(
                fit: BoxFit.cover,
                File(images[index].path),
              ),
            );
          }
          if (index == 3 && images.length > 4) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Image.file(
                  fit: BoxFit.cover,
                  File(images[index].path),
                ),
                Container(
                  color: Colors.black54,
                  child: Center(
                    child: Text(
                      "+$additionalCount",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return SizedBox(
              height: 150.h,
              child: Image.file(
                fit: BoxFit.cover,
                File(images[index].path),
              ),
            );
          }
        },
      ),
    );
  }
}
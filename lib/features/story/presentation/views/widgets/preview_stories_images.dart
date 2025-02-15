import 'dart:io';
import 'package:flutter/material.dart';

class PreviewStoriesImages extends StatelessWidget {
  const PreviewStoriesImages({
    super.key,
    required this.file,
  });

  final File file;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(file),
        ),
      ),
    );
  }
}

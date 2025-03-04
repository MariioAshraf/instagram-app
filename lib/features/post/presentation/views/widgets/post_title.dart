import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PostTitle extends StatefulWidget {
  const PostTitle({
    super.key,
    required this.text,
  });

  final String text;

  @override
  State<PostTitle> createState() => _PostTitleState();
}

class _PostTitleState extends State<PostTitle> {
  bool seeMore = false;
  int maxLength = 100;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      children: [
        TextSpan(
            text: seeMore
                ? widget.text
                : widget.text.length > maxLength
                    ? '${widget.text.substring(0, maxLength)}... '
                    : widget.text,
            style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w400)),
        if (widget.text.length > maxLength)
          TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  setState(() {
                    seeMore = !seeMore;
                  });
                },
              text: seeMore ? '  see less' : 'see more',
              style: const TextStyle(fontSize: 15, color: Colors.grey)),
      ],
    ));
  }
}

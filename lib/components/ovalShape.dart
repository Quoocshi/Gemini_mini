import 'package:flutter/material.dart';

class CustomClip extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width, size.height - 71);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}

class OvalShape extends StatelessWidget {
  const OvalShape({
    super.key,
    required this.height,
    required this.width,
    required this.color,
  });

  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipper: CustomClip(),
      child: Container(
        height: height,
        width: width,
        color: color,
      ),
    );
  }
}

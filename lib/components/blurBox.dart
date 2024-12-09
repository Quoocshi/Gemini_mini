import 'package:flutter/material.dart';
import 'dart:ui';

class BlurBox extends StatelessWidget {
  const BlurBox({
    super.key,
    required this.sigmax,
    required this.sigmay,
  });
  final double sigmax;
  final double sigmay;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: sigmax,
        sigmaY: sigmay,
      ),
      child: Container(),
    );
  }
}

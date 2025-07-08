import 'package:flutter/material.dart';

class AnimatedLogo extends StatelessWidget {
  final Animation<double> animation;
  final double size;
  const AnimatedLogo({super.key, required this.animation, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) => Transform.translate(
        offset: Offset(0, animation.value),
        child: child,
      ),
      child: Image.asset('assets/images/logo.png', height: 48));
  }
}

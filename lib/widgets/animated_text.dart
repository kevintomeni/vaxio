import 'package:flutter/material.dart';

class AnimatedText extends StatelessWidget {
  final Animation<double> animation;
  final String text;
  const AnimatedText({super.key, required this.animation, required this.text});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) => Transform.translate(
        offset: Offset(0, animation.value),
        child: child,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          fontSize: 36,
          color: Colors.white,
          letterSpacing: 2,
        ),
      ),
    );
  }
}

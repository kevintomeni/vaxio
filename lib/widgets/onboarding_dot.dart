import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class OnboardingDot extends StatelessWidget {
  final bool isActive;
  const OnboardingDot({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

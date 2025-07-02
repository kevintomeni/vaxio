 import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String label;
  final String assetPath;
  final VoidCallback onTap;

  const SocialButton({
    super.key,
    required this.label,
    required this.assetPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: Image.asset(assetPath, height: 24),
        label: Text(label),
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          side: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}

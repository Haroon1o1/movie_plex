import 'package:flutter/material.dart';
import 'package:movie_plex/core/constants/app_colors.dart';

class CustomRoundIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const CustomRoundIcon({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surfaceAlt,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.line),
        ),
        child: Icon(icon, size: 20, color: AppColors.text),
      ),
    );
  }
}

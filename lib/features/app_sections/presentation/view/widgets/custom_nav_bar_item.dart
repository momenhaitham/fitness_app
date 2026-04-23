import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomNavBarItem extends StatelessWidget {
  const CustomNavBarItem({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final VoidCallback onTap;
  final String icon;
  final bool isSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSlide(
              offset: isSelected ? const Offset(0, -0.2) : Offset.zero,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(
                  isSelected
                      ? AppColors.primaryColor
                      : AppColors.baseWhiteColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: isSelected
                  ? Text(title, key: ValueKey(title))
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingDotIndicators extends StatelessWidget {
  const OnboardingDotIndicators({
    super.key,
    required this.totalPages,
    required this.currentIndex,
  });

  final int totalPages;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: currentIndex == i ? 24.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: currentIndex == i
                ? AppColors.primaryColor
                : Colors.white.withOpacity(0.35),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
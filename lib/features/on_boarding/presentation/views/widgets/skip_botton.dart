import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingSkipButton extends StatelessWidget {
  const OnboardingSkipButton({
    super.key,
    required this.currentIndex,
    required this.totalPages,
    required this.onSkip,
  });

  final int currentIndex;
  final int totalPages;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    if (currentIndex >= totalPages - 1) return const SizedBox.shrink();

    return Positioned(
      top: 48.h,
      right: 20.w,
      child: TextButton(
        onPressed: onSkip,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        ),
        child: Text(
          'Skip',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
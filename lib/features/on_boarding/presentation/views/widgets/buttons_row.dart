import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingButtonsRow extends StatelessWidget {
  const OnboardingButtonsRow({
    super.key,
    required this.currentIndex,
    required this.totalPages,
    required this.onNext,
    required this.onBack,
  });

  final int currentIndex;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onBack;

  bool get _isFirstPage => currentIndex == 0;
  bool get _isLastPage => currentIndex == totalPages - 1;

  @override
  Widget build(BuildContext context) {
    // ── First page: full-width Next only ────────────────────────────────
    if (_isFirstPage) {
      return SizedBox(
        width: double.infinity,
        height: 52.h,
        child: ElevatedButton(
          onPressed: onNext,
          style: _elevatedStyle(),
          child: const Text('Next'),
        ),
      );
    }

    // ── Pages 2 & 3: Back (outline) + Next/Do IT ────────────────────────
    return Row(
      children: [
        // Back button
        Expanded(
          child: SizedBox(
            height: 52.h,
            child: OutlinedButton(
              onPressed: onBack,
              style: _outlinedStyle(),
              child: const Text('Back'),
            ),
          ),
        ),

        SizedBox(width: 150.w),

        // Next / Do IT button
        Expanded(
          child: SizedBox(
            height: 52.h,
            child: ElevatedButton(
              onPressed: onNext,
              style: _elevatedStyle(),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250 , ),
                child: Text(
                  _isLastPage ? 'Do IT' : 'Next',
                  key: ValueKey('btn$currentIndex'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  ButtonStyle _elevatedStyle() => ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      );

  ButtonStyle _outlinedStyle() => OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        side: BorderSide(color: AppColors.primaryColor, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
      );
}
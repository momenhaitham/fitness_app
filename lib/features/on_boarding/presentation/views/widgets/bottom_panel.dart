import 'package:fitness_app/features/on_boarding/presentation/views/widgets/buttons_row.dart';
import 'package:fitness_app/features/on_boarding/presentation/views/widgets/dot_indicators.dart';
import 'package:fitness_app/features/on_boarding/presentation/views/widgets/onboarding_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingBottomPanel extends StatelessWidget {
  const OnboardingBottomPanel({
    super.key,
    required this.pages,
    required this.currentIndex,
    required this.onNext,
    required this.onBack,
  });

  final List<OnboardingData> pages;
  final int currentIndex;
  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 36.h),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.50),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          border: Border.all(
            color: Colors.white.withOpacity(0.08),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Title ────────────────────────────────────────────────────
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.15),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
              child: Text(
                pages[currentIndex].title,
                key: ValueKey('title$currentIndex'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20.sp,
                  letterSpacing: 0.5,
                  height: 1.4,
                ),
              ),
            ),

            SizedBox(height: 12.h),

            // ── Description ──────────────────────────────────────────────
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              child: Text(
                pages[currentIndex].description,
                key: ValueKey('desc$currentIndex'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.60),
                  fontSize: 13.sp,
                  height: 1.6,
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // ── Dot indicators ───────────────────────────────────────────
            OnboardingDotIndicators(
              totalPages: pages.length,
              currentIndex: currentIndex,
            ),

            SizedBox(height: 24.h),

            // ── Buttons ──────────────────────────────────────────────────
            OnboardingButtonsRow(
              currentIndex: currentIndex,
              totalPages: pages.length,
              onNext: onNext,
              onBack: onBack,
            ),
          ],
        ),
      ),
    );
  }
}
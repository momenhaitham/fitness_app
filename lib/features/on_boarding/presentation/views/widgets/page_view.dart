import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'onboarding_data.dart';

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({
    super.key,
    required this.pages,
    required this.controller,
    required this.onPageChanged,
  });

  final List<OnboardingData> pages;
  final PageController controller;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemCount: pages.length,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        return _OnboardingPage(data: pages[index]);
      },
    );
  }
}

// ─── Single page widget ───────────────────────────────────────────────────────

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.data});

  final OnboardingData data;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 60.h),
        child: Image.asset(data.imagePath, fit: BoxFit.contain),
      ),
    );
  }
}